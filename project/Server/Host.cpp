#define CL_HPP_CL_1_2_DEFAULT_BUILD
#define CL_HPP_TARGET_OPENCL_VERSION 120
#define CL_HPP_MINIMUM_OPENCL_VERSION 120
#define CL_HPP_ENABLE_PROGRAM_CONSTRUCTION_FROM_ARRAY_COMPATIBILITY 1
#define CL_USE_DEPRECATED_OPENCL_1_2_APIS

#include "EventTimer.h"
#include <CL/cl2.hpp>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <unistd.h>
#include <vector>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <pthread.h>
#include <errno.h>
#include <sys/mman.h>
#include <math.h>
#include <bitset>
#include "encoder.h"
#include "sha256.h"
#include "LZW_new.h"
#include "server.h"
#include "Utilities.h"

#define NUM_PACKETS 8
#define pipe_depth 4
#define CHUNK_SIZE_MAX 8192
#define CHUNK_NUMBER_MAX 100000
#define DONE_BIT_L (1 << 7)
#define DONE_BIT_H (1 << 15)

int offset = 0;
int chunk_number = 0;
int total_chunk_number = 0;
int chunk_boundary[CHUNK_NUMBER_MAX];
std::string hash_table[CHUNK_NUMBER_MAX];
unsigned char *file;

void handle_input(int argc, char *argv[], int *blocksize)
{
    int x;
    extern char *optarg;

    while ((x = getopt(argc, argv, ":b:")) != -1)
    {
        switch (x)
        {
        case 'b':
            *blocksize = atoi(optarg);
            printf("blocksize is set to %d optarg\n", *blocksize);
            break;
        case ':':
            printf("-%c without parameter\n", optopt);
            break;
        }
    }
}

// placeholder hash function for cdc
uint64_t hash_func(unsigned char *input, unsigned int pos)
{
    uint64_t hash = 0;
    uint64_t temp = 0;
    // Change 0 to Header / WIN_SIZE
    for (int i = 0; i < WIN_SIZE; i++)
    {
        temp = (uint64_t)(input[pos + WIN_SIZE - 1 - i]);
        temp = temp * pow(PRIME, i + 1);
        hash = hash + temp;
    }
    return hash;
}

void cdc(unsigned char *buff, unsigned int buff_size)
{
    for (u_int i = WIN_SIZE; i < (buff_size - WIN_SIZE); i++)
    {
        // change buff to buff+HEADER
        if ((hash_func(buff, i) % MODULUS) == TARGET)
        {
            // create chunk here
            chunk_boundary[chunk_number] = i;
            chunk_number++;
        }
    }
    if (chunk_boundary[chunk_number - 1] != (buff_size))
    {
        chunk_boundary[chunk_number] = buff_size;
        chunk_number++;
    }
}

void SHA(unsigned char *buffer, std::string *hash_table)
{
    // hash now contains the SHA-256 hash of buffer
    SHA256 sha256;
    int start_point = 0;
    int end_point = chunk_boundary[0];
    for (int chunk = 0; chunk < chunk_number; chunk++)
    {
        int length = end_point - start_point;
        uint64_t hash = 0;
        uint64_t temp = 0;
        for (int i = 0; i < length; i++)
        {
            temp = (uint64_t)buffer[start_point + i];
            hash = hash + temp;
        }
        hash_table[total_chunk_number + chunk] = sha256(&buffer[start_point], length);
        start_point = end_point;
        end_point = chunk_boundary[chunk + 1];
    }
}
void getlzwheader(unsigned char *lzw_header, int size, int flag)
{
    if (flag == 0)
    {
        lzw_header[0] = size << 1;
        lzw_header[1] = size >> 7;
        lzw_header[2] = size >> 15;
        lzw_header[3] = size >> 23;
    }
    else if (flag == 1)
    {
        lzw_header[0] = size << 1 | 1;
        lzw_header[1] = size >> 7;
        lzw_header[2] = size >> 15;
        lzw_header[3] = size >> 23;
    }
}

void hashing_deduplication(std::string *hash_table, int i, int &flag, int &chunk_index)
{
    // unsigned char *lzw_header = (unsigned char*)malloc(4 * sizeof(unsigned char));
    for (int j = 0; j < i; j++)
    {
        if ((hash_table[i] == hash_table[j]) && (i != j))
        {
            flag = 1;
            chunk_index = j;
            break;
        }
    }
}
int main(int argc, char *argv[])
{
    if (argc < 3)
    {
        std::cout << "Usage:  " << argv[0] << "<xclbin filer><Compressed file>" << std::endl;
        return EXIT_SUCCESS;
    }

    EventTimer timer1, timer2;
    timer1.add("Main program");

    // ------------------------------------------------------------------------------------
    // Step 1: Initialize the OpenCL environment
    // ------------------------------------------------------------------------------------
    timer2.add("OpenCL Initialization");
    cl_int err;

    std::string binaryFile = argv[1];
    unsigned fileBufSize;

    std::vector<cl::Device> devices = get_xilinx_devices();
    devices.resize(1);
    cl::Device device = devices[0];

    cl::Context context(device, NULL, NULL, NULL, &err);

    char *fileBuf = read_binary_file(binaryFile, fileBufSize);

    cl::Program::Binaries bins{{fileBuf, fileBufSize}};
    cl::Program program(context, devices, bins, NULL, &err);
    cl::CommandQueue q(context, device, CL_QUEUE_PROFILING_ENABLE, &err);
    cl::Kernel krnl_hardware(program, "hardware_encoding", &err);

    // ------------------------------------------------------------------------------------
    // Step 2: Create buffers and initialize test values
    // ------------------------------------------------------------------------------------
    timer2.add("Allocate contiguous OpenCL buffers");

    cl::Buffer in_buf;
    cl::Buffer out_buf;

    in_buf = cl::Buffer(context, CL_MEM_READ_ONLY, CHUNK_SIZE_MAX, NULL, &err);
    out_buf = cl::Buffer(context, CL_MEM_READ_ONLY, CHUNK_SIZE_MAX * 2, NULL, &err);

    unsigned char *in;
    //unsigned char *Output;

    in = (unsigned char *)q.enqueueMapBuffer(in_buf, CL_TRUE, CL_MAP_WRITE, 0, CHUNK_SIZE_MAX);
    //Output = (unsigned char *)q.enqueueMapBuffer(out_buf, CL_TRUE, CL_MAP_READ, 0, CHUNK_SIZE_MAX * 2);

    // ------------------------------------------------------------------------------------
    // Step 3: Run the kernel
    // ------------------------------------------------------------------------------------
    timer2.add("Running kernel");

    unsigned char *input[NUM_PACKETS];
    int writer = 0;
    int done = 0;
    int length = 0;
    int packet_index = 0;
    unsigned char *lzw_header = (unsigned char *)malloc(4 * sizeof(unsigned char));

    ESE532_Server server;

    int blocksize = BLOCKSIZE;

    // set blocksize if decalred through command line
    handle_input(argc, argv, &blocksize);

    file = (unsigned char *)malloc(sizeof(unsigned char) * 70000000);
    if (file == NULL)
    {
        printf("help\n");
    }

    for (int i = 0; i < NUM_PACKETS; i++)
    {
        input[i] = (unsigned char *)malloc(
            sizeof(unsigned char) * (NUM_ELEMENTS + HEADER));
        if (input[i] == NULL)
        {
            std::cout << "aborting " << std::endl;
            return 1;
        }
    }

    server.setup_server(blocksize);

    writer = pipe_depth;
    int flag = 0;
    int chunk_index = 0;
    int start = 0;
    int end = 0;

    while (!done)
    {
        // reset ring buffer
        if (writer == NUM_PACKETS)
        {
            writer = 0;
        }

        server.get_packet(input[writer]);

        // get packet
        unsigned char *buffer = input[writer];
        // decode
        done = buffer[1] & DONE_BIT_L;
        length = buffer[0] | (buffer[1] << 8);
        length &= ~DONE_BIT_H;


        chunk_number = 0; // initialize chunk number
        cdc(&buffer[HEADER], length);

        //Compute SHA
        SHA(&buffer[HEADER], hash_table);

        // Copy DATA to buffer
        //memcpy(&in[0], &buffer[HEADER], length);

        // deduplication
        flag = 0;
        chunk_index = 0;
        start = 0;
        end = chunk_boundary[0];
        std::vector<cl::Event> read_events;
        std::vector<cl::Event> exec_events;
        std::vector<cl::Event> write_events;
        int LZW_count = 0;
        for (int i = 0; i < chunk_number; i++)
        {
            cl::Event write_ev,read_ev,exec_ev;
            hashing_deduplication(hash_table, total_chunk_number + i, flag, chunk_index);
            if (flag == 1)
            {
                getlzwheader(&lzw_header[0], chunk_index, 1);
                memcpy(&file[offset], &lzw_header[0], 4);
                offset += 4;
                flag = 0;
            }
            else
            {
                // unique chunk
                int lzw_size = 0;
                int input_size = end - start;
                memcpy(&in[0],&buffer[HEADER+start],input_size);
                // hardwadre_encoding(&in[0], &Output[0], lzw_size, input_size);
                krnl_hardware.setArg(0, in_buf);
                krnl_hardware.setArg(1, out_buf);
                krnl_hardware.setArg(2, lzw_size);
                krnl_hardware.setArg(3, input_size);

                if(LZW_count == 0){
                    q.enqueueMigrateMemObjects({in_buf},0,NULL,&write_ev);
                }else{
                    q.enqueueMigrateMemObjects({in_buf},0,&read_events,&write_ev);
                }
                LZW_count++;
                write_events.push_back(write_ev);
                q.enqueueTask(krnl_hardware,&write_events,&exec_ev);
                exec_events.push_back(exec_ev);
                q.enqueueMigrateMemObjects({out_buf},CL_MIGRATE_MEM_OBJECT_HOST,&exec_events,&read_ev);
                read_events.push_back(read_ev);

                unsigned char *Output = (unsigned char *)q.enqueueMapBuffer(out_buf,CL_TRUE,CL_MAP_READ,0, CHUNK_SIZE_MAX * 2);

                getlzwheader(&lzw_header[0], lzw_size, 0);
                memcpy(&file[offset], &lzw_header[0], 4);
                offset += 4;
                memcpy(&file[offset], &Output[0], lzw_size);
                offset += lzw_size;
            }
            start = end;
            end = chunk_boundary[i + 1];
        }


        writer++;
        total_chunk_number += chunk_number;
    }
//Step 4
    q.finish();
    delete[] fileBuf;

    timer2.add("Writing output to output_fpga.bin");
    FILE *outfd = fopen(argv[2], "wb");
	int bytes_written = fwrite(&file[0], 1, offset, outfd);
	printf("write file with %d\n", bytes_written);
	fclose(outfd);

	for (int i = 0; i < NUM_PACKETS; i++) {
		free(input[i]);
	}



    

    timer2.finish();
    std::cout << "--------------- Key execution times ---------------"
              << std::endl;
    timer2.print();

    timer1.finish();
    std::cout << "--------------- Total time ---------------"
              << std::endl;
    timer1.print();
    free(lzw_header);
    free(file);
    return 0;
}
