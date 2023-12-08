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
#include "LZW_new.h"
#include "server.h"
#include "Utilities.h"
#include "stopwatch.h"



int offset = 0;
int chunk_number = 0;
int total_chunk_number = 0;
int chunk_boundary[CHUNK_NUMBER_MAX];
uint32_t new_hash_table[CHUNK_NUMBER_MAX][12];
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


void hashing_deduplication_neon(uint32_t hash_table[][12], int i, int &flag, int &chunk_index)
{
    // unsigned char *lzw_header = (unsigned char*)malloc(4 * sizeof(unsigned char));
    for (int j = 0; j < i; j++)
    {
        int compare_flag = 1;
        for(int k = 0; k < 12;k++){
            if (hash_table[i][k] != hash_table[j][k])
            {
                compare_flag = 0; // current value is not same
                break;
            }
        }
        if(compare_flag == 1){
            flag = 1;
            chunk_index = j;
            break;
        }
    }

}


int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        std::cout << "Usage:  " << argv[0] << "<Compressed file>" << std::endl;
        return EXIT_SUCCESS;
    }

    int bytes_read = 0;
    
    
    stopwatch ethernet_timer;
	stopwatch encode_timer;
    stopwatch cdc_timer;
    stopwatch sha_timer;
    stopwatch ded_timer;
    stopwatch lzw_timer;

    EventTimer timer1, timer2;
    timer1.add("Main program");

    // ------------------------------------------------------------------------------------
    // Step 1: Initialize the OpenCL environment
    // ------------------------------------------------------------------------------------
    timer2.add("OpenCL Initialization");
    cl_int err;

    std::string binaryFile = "hardware_encoding.xclbin";
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
    cl::Buffer lzwsize_buf;
    cl::Buffer inputsize_buf;
    cl::Buffer lzwchunk_buf;

    
    in_buf = cl::Buffer(context, CL_MEM_READ_ONLY, LZW_CHUNK*8192*sizeof(unsigned char), NULL, &err);
    inputsize_buf  = cl::Buffer(context, CL_MEM_READ_ONLY, sizeof(int)*LZW_CHUNK,NULL,&err);
    out_buf = cl::Buffer(context, CL_MEM_WRITE_ONLY, LZW_CHUNK*8196*sizeof(unsigned char), NULL, &err);
    lzwsize_buf = cl::Buffer(context, CL_MEM_WRITE_ONLY, sizeof(int)*LZW_CHUNK,NULL, &err);
    lzwchunk_buf = cl::Buffer(context, CL_MEM_READ_ONLY, sizeof(int)*1,NULL, &err);
    
    

    unsigned char *in;
    int *inputsize;

    unsigned char *Output;
    int *lzwsize;
    int *lzwchunk;

    

    in = (unsigned char *)q.enqueueMapBuffer(in_buf, CL_TRUE, CL_MAP_WRITE, 0, LZW_CHUNK*8192*sizeof(unsigned char));
    inputsize = (int *)q.enqueueMapBuffer(inputsize_buf,CL_TRUE,CL_MAP_WRITE,0,sizeof(int)*LZW_CHUNK);
    lzwchunk = (int *)q.enqueueMapBuffer(lzwchunk_buf,CL_TRUE,CL_MAP_WRITE,0,sizeof(int)*1);
    Output = (unsigned char *)q.enqueueMapBuffer(out_buf,CL_TRUE,CL_MAP_READ,0, LZW_CHUNK*8196*sizeof(unsigned char));
    lzwsize = (int *)q.enqueueMapBuffer(lzwsize_buf,CL_TRUE,CL_MAP_READ,0,sizeof(int)*LZW_CHUNK);


    // ------------------------------------------------------------------------------------
    // Step 3: Run the kernel
    // ------------------------------------------------------------------------------------
    timer2.add("Running kernel");
    

    //init index for writting
    int unqiue_index = 0;
    int repeat_index = 0;

    unsigned char *input[NUM_PACKETS];
    int writer = 0;
    int done = 0;
    unsigned int length = 0;
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
    int lzw_chunk_counter = 0;
    std::vector<cl::Event> read_events;
    std::vector<cl::Event> exec_events;
    std::vector<cl::Event> write_events;
    timer2.add("Encode");
    while (!done)
    {
        // reset ring buffer
        if (writer == NUM_PACKETS)
        {
            writer = 0;
        }
        ethernet_timer.start();
        server.get_packet(input[writer]);
        ethernet_timer.stop();

        // get packet
        unsigned char *buffer = input[writer];
        // decode
        done = buffer[1] & DONE_BIT_L;
        length = buffer[0] | (buffer[1] << 8);
        length &= ~DONE_BIT_H;
        bytes_read = bytes_read + length;
        std::cout << "Read\t" << bytes_read << "\tBytes" << std::endl;
     

        chunk_number = 0; // initialize chunk number
        encode_timer.start();
        cdc_timer.start();
        cdc(&buffer[HEADER], length,chunk_number,chunk_boundary);
        std::cout << "Chunk number:\t" << chunk_number << std::endl;
       
        cdc_timer.stop();

        //Compute SHA
        sha_timer.start();
        //SHA(&buffer[HEADER], hash_table,chunk_boundary,chunk_number,total_chunk_number);
        sha_neon(&buffer[HEADER],new_hash_table,chunk_boundary,chunk_number,total_chunk_number);
        sha_timer.stop();
        std::cout << "SHA OK!" << std::endl;

        // Copy DATA to buffer
        //memcpy(&in[0], &buffer[HEADER], length);

        // deduplication
        flag = 0;
        chunk_index = 0;
        start = 0;
        end = chunk_boundary[0];

        int LZW_count = 0;
        for (int i = 0; i < chunk_number; i++)
        {
            cl::Event write_ev,read_ev,exec_ev;
            ded_timer.start();
            //hashing_deduplication(hash_table, total_chunk_number + i, flag, chunk_index);
            hashing_deduplication_neon(new_hash_table,total_chunk_number+i,flag,chunk_index);
            ded_timer.stop();
            if (flag == 1)
            {
                std::cout << "find!" << std::endl;
                lzwsize[lzw_chunk_counter] = 4;
                inputsize[lzw_chunk_counter] = chunk_index;
                flag = 0;
            }
            else
            {
                // unique chunk
                std::cout << "Unique!" << std::endl;
                std::cout << "current chunk:\t" << lzw_chunk_counter <<std::endl; 
                lzwsize[lzw_chunk_counter] = 0;
                std::cout << lzwsize[lzw_chunk_counter] << std::endl;
                inputsize[lzw_chunk_counter] = end - start;
                std::cout << "Input Size:\t" << inputsize[lzw_chunk_counter] << std::endl;
                memcpy(&in[lzw_chunk_counter*8192],&buffer[HEADER+start],inputsize[lzw_chunk_counter]);
                std::cout << "copy!" << std::endl;
               
            }
            lzw_chunk_counter++;
            lzw_timer.start();
            if(lzw_chunk_counter == 4){
                lzwchunk[0] = lzw_chunk_counter;
                krnl_hardware.setArg(0,in_buf);
                krnl_hardware.setArg(1,out_buf);
                krnl_hardware.setArg(2,lzwsize_buf);
                krnl_hardware.setArg(3,inputsize_buf);
                krnl_hardware.setArg(4,lzwchunk_buf);

                if(LZW_count == 0){
                    q.enqueueMigrateMemObjects({in_buf, inputsize_buf,lzwchunk_buf}, 0, NULL, &write_ev);
                } else{
                    q.enqueueMigrateMemObjects({in_buf, inputsize_buf,lzwchunk_buf}, 0, &read_events, &write_ev);
                }
                
                write_events.push_back(write_ev);
                q.enqueueTask(krnl_hardware, &write_events,&exec_ev);
                exec_events.push_back(exec_ev);
                q.enqueueMigrateMemObjects({out_buf,lzwsize_buf}, CL_MIGRATE_MEM_OBJECT_HOST, &exec_events, &read_ev);
                read_events.push_back(read_ev);
                
                if(LZW_count != 0){
                int total_size = 0;
                std::cout << "1 lzw size:\t" << lzwsize[0] << std::endl;
                std::cout << "2 lzw size:\t" << lzwsize[1] << std::endl;
                int t0 = lzwsize[0] + lzwsize[1];
                std::cout << "3 lzw size:\t" << lzwsize[2] << std::endl;
                std::cout << "4 lzw size:\t" << lzwsize[3] << std::endl;
                int t1 = lzwsize[2] + lzwsize[3];
                total_size = t0 + t1;
                memcpy(&file[offset], &Output[0],total_size);
                offset +=total_size;
                lzw_chunk_counter = 0;
                }

                LZW_count++;
            }
            lzw_timer.stop();
            start = end;
            end = chunk_boundary[i + 1];
        }
        writer++;
        total_chunk_number += chunk_number;
    }
    if(lzw_chunk_counter != 0){
    	cl::Event write_ev,read_ev,exec_ev;
        lzwchunk[0] = lzw_chunk_counter;
        krnl_hardware.setArg(0,in_buf);
        krnl_hardware.setArg(1,out_buf);
        krnl_hardware.setArg(2,lzwsize_buf);
        krnl_hardware.setArg(3,inputsize_buf);
        krnl_hardware.setArg(4,lzwchunk_buf);
        q.enqueueMigrateMemObjects({in_buf, inputsize_buf,lzwchunk_buf}, 0, &read_events, &write_ev);
        write_events.push_back(write_ev);
        q.enqueueTask(krnl_hardware, &write_events,&exec_ev);
        exec_events.push_back(exec_ev);
        q.enqueueMigrateMemObjects({out_buf,lzwsize_buf}, CL_MIGRATE_MEM_OBJECT_HOST, &exec_events, &read_ev);
        read_events.push_back(read_ev);
        Output = (unsigned char *)q.enqueueMapBuffer(out_buf,CL_TRUE,CL_MAP_READ,0, LZW_CHUNK*8196*sizeof(unsigned char));
        lzwsize = (int *)q.enqueueMapBuffer(lzwsize_buf,CL_TRUE,CL_MAP_READ,0,sizeof(int)*LZW_CHUNK);
        int total_size = 0;
        std::cout << "1 lzw size:\t" << lzwsize[0] << std::endl;
        std::cout << "2 lzw size:\t" << lzwsize[1] << std::endl;
        int t0 = lzwsize[0] + lzwsize[1];
        std::cout << "3 lzw size:\t" << lzwsize[2] << std::endl;
        std::cout << "4 lzw size:\t" << lzwsize[3] << std::endl;
        int t1 = lzwsize[2] + lzwsize[3];
        total_size = t0 + t1;
        memcpy(&file[offset], &Output[0],total_size);
        offset +=total_size;
        lzw_chunk_counter = 0;
    }

    q.finish();
    encode_timer.stop();


//Step 4
   

    delete[] fileBuf;

    timer2.add("Writing output to output_fpga.bin");
    FILE *outfd = fopen(argv[1], "wb");
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

    std::cout<<"------------------CDC time------------------"<<std::endl;
    std::cout << cdc_timer.latency()  << "ms" << std::endl;
    float cdc_latency = cdc_timer.latency() / 1000;
    float cdc_throughput = (bytes_read * 8 / 1000000.0) / cdc_latency; //Mb/s
    std::cout << "CDC Throughput:\t" << cdc_throughput <<"\tMb/s"<< std::endl;

    std::cout<<"------------------SHA256 time------------------"<<std::endl;
    std::cout << sha_timer.latency()  << "ms" << std::endl;
    float sha_latency = sha_timer.latency() / 1000;
    float sha_throughput = (bytes_read * 8 / 1000000.0) / sha_latency; //Mb/s
    std::cout << "SHA Throughput:\t" << sha_throughput <<"\tMb/s"<< std::endl;

    std::cout<<"------------------Deduplicate time------------------"<<std::endl;
    std::cout << ded_timer.latency() << "ms" << std::endl;
    float ded_latency = ded_timer.latency() / 1000;
    float ded_throughput = (bytes_read * 8 / 1000000.0) / ded_latency; //Mb/s
    std::cout << "Deduplicate Throughput:\t" << ded_throughput <<"\tMb/s"<< std::endl;
    
    std::cout<<"------------------LZW time------------------"<<std::endl;
    std::cout << lzw_timer.latency() << "ms" << std::endl;
    float lzw_latency = lzw_timer.latency() / 1000;
    float lzw_throughput = (bytes_read * 8 / 1000000.0) / lzw_latency; //Mb/s
    std::cout << "LZW Throughput:\t" << lzw_throughput <<"\tMb/s"<< std::endl;

    std::cout << "--------------- Key Throughputs ---------------" << std::endl;
	float ethernet_latency = ethernet_timer.latency() / 1000.0;
	float encoder_latency = encode_timer.latency() / 1000.0;

	float input_throughput = (bytes_read * 8 / 1000000.0) / ethernet_latency; // Mb/s
	float encoder_throughput = (bytes_read * 8 / 1000000.0) / encoder_latency; // Mb/s

	std::cout << "Input Throughput to Encoder: " << input_throughput << " Mb/s."
			<< " (Latency: " << ethernet_latency << "s)." << std::endl;
	std::cout << "Throughput to Bin File: " << encoder_throughput  << " Mb/s."
			<< " (Latency: " << encoder_latency << "s)." << std::endl;

    free(lzw_header);
    free(file);
    return 0;
}
