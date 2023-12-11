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


int data_16to12(uint16_t *data_16, int length_16, unsigned char * data_12){
    bool send_two = false;
    unsigned char high_four;
    int length_12 = 0;
    for(int i = 0; i < length_16;i++){
        if(!send_two){
            data_12[length_12++] = (unsigned char)(data_16[i] >> 4);
            send_two = true;
            high_four = (unsigned char)(data_16[i] << 4) & 0xf0;
        } else {
            data_12[length_12++] = high_four | ((unsigned char)(data_16[i] >> 8) & 0x0f);
            data_12[length_12++] = (unsigned char)(data_16[i]) & 0xff;
            send_two = false;
        }
    }
    if(send_two){
        data_12[length_12++] = high_four;
    }
    return length_12;
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
    stopwatch total_timer;
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


    
    in_buf = cl::Buffer(context, CL_MEM_READ_ONLY, MAX_LZW_CHUNK*8194, NULL, &err);
    out_buf = cl::Buffer(context, CL_MEM_WRITE_ONLY, MAX_LZW_CHUNK*8193, NULL, &err);
    
    

    unsigned char *in;
    uint16_t *Output; 
  
    in = (unsigned char *)q.enqueueMapBuffer(in_buf, CL_TRUE, CL_MAP_WRITE, 0, MAX_LZW_CHUNK*8194);


    // ------------------------------------------------------------------------------------
    // Step 3: Run the kernel
    // ------------------------------------------------------------------------------------
    timer2.add("Running kernel");
    

    unsigned char *input[NUM_PACKETS];
    int writer = 0;
    int done = 0;
    unsigned int length = 0;
    int packet_index = 0;

    // init encoder variables    
    int chunk_info[CHUNK_NUMBER_MAX]; // Record Chunk status ( -1:unique chunk ; other: repeat chunk. The index should same with chunk index)
    int chunk_send_counter = 0;
    int unique_chunk_number = 0;
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

        cdc_timer.start();
        total_timer.start();
        cdc(&buffer[HEADER], length,chunk_number,chunk_boundary);
        cdc_timer.stop();
        //std::cout << "Chunk number:\t" << chunk_number << std::endl;
    
        //Compute SHA

        sha_timer.start();
        sha_neon(&buffer[HEADER],new_hash_table,chunk_boundary,chunk_number,total_chunk_number);
        sha_timer.stop();

       // std::cout << "SHA OK!" << std::endl;

        // deduplication
   


        int LZW_count = 0;
        std::vector<cl::Event> read_events;
        std::vector<cl::Event> exec_events;
        std::vector<cl::Event> write_events;
        int start = 0;
    	int end = chunk_boundary[0];
    	int flag = 0;
    	int chunk_index = -5;
        for (int i = 0; i < chunk_number; i++)
        {
            cl::Event write_ev,read_ev,exec_ev;
            ded_timer.start();
            hashing_deduplication_neon(new_hash_table,total_chunk_number+i,flag,chunk_index);
            ded_timer.stop();
            if (flag == 1)
            {
            	chunk_info[chunk_send_counter++] = chunk_index;
                flag = 0;
                continue;
            }
            else
            {  
                // unique chunk
                chunk_info[chunk_send_counter++] = -1;
                int inputsize = end - start;
                in[unique_chunk_number * 8194 + 0] = (unsigned char)(inputsize / 100);
                in[unique_chunk_number * 8194 + 1] = (unsigned char)(inputsize % 100);
                
                memcpy(&in[unique_chunk_number * 8194 + 2],&buffer[HEADER+start],inputsize);
                unique_chunk_number++;
            }
            if(unique_chunk_number == 4 || done){
            	if(chunk_send_counter == 0){
            		continue;
            	}
            	if(unique_chunk_number != 0){
                    
                
                
     
            	lzw_timer.start();
            	// call encoding function
            	krnl_hardware.setArg(0, in_buf);
            	krnl_hardware.setArg(1, out_buf);
            	if(LZW_count == 0){
                    q.enqueueMigrateMemObjects({in_buf},0,NULL,&write_ev);
                }else{
                    q.enqueueMigrateMemObjects({in_buf},0,&read_events,&write_ev);
                }
                LZW_count++;
                
                write_events.push_back(write_ev);
                q.enqueueTask(krnl_hardware,&write_events,&exec_ev);;
                exec_events.push_back(exec_ev);
                q.enqueueMigrateMemObjects({out_buf},CL_MIGRATE_MEM_OBJECT_HOST,&exec_events,&read_ev);
                read_events.push_back(read_ev);

 		        // Send to output array
 		        Output = (uint16_t *)q.enqueueMapBuffer(out_buf,CL_TRUE,CL_MAP_READ,0, MAX_LZW_CHUNK * 8193);
                std::cout << "*******************************" << std::endl;
                std::cout << (int)Output[3*8193+0] << std::endl;
                std::cout << (int)Output[3*8193+1] << std::endl;
                std::cout << (int)Output[3*8193+2] << std::endl;
                std::cout << (int)Output[3*8193+3] << std::endl;
                std::cout << (int)Output[3*8193+4] << std::endl;
                std::cout << "*******************************" << std::endl;
 		        lzw_timer.stop();
                }
 		        
 		
 		
 		// Send Chunk to file
 		int unique_index = 0;
        std::cout << "start sending " << chunk_send_counter << std::endl;
        std::cout << "unique " << unique_chunk_number << std::endl;
 		for(int chunk = 0 ; chunk < chunk_send_counter;chunk++){
 			if(chunk_info[chunk] == -1){
 				// Send Unique Chunk
 				        int compress_size = (int)Output[unique_index * 8193 + 0];  
                        std::cout << unique_index<<"Len:\t" <<compress_size << std::endl;  			
            			unsigned char write_back_data[8192];

                        //uint16_t temp_data1[8192];
                        //memcpy(&temp_data1[0],&Output[unique_index * 8193 + 1],compress_size);
                   
            			int write_back_length = data_16to12(&Output[unique_index * 8193 + 1], compress_size, write_back_data);
                        
                
            			
                		getlzwheader(&lzw_header[0], write_back_length, 0);
               			memcpy(&file[offset], &lzw_header[0], 4);
                		offset += 4;
                		
                		memcpy(&file[offset], &write_back_data[0], write_back_length);
                		offset += write_back_length;
                		
                		unique_index++;
 			}
 		    	else{
 		    		//Send repeat chunk
 		    		int send_index = chunk_info[chunk];
 		    		getlzwheader(&lzw_header[0], send_index, 1);
               			memcpy(&file[offset], &lzw_header[0], 4);
                		offset += 4;
 		    	}
 		}
 		// end of send chunk to file
 		chunk_send_counter = 0;
 		unique_chunk_number = 0;
 		
        }
                start = end;
                end = chunk_boundary[i + 1];
                
        }
        total_timer.stop();
        writer++;
        total_chunk_number += chunk_number;
    }
    
    q.finish();


   
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
	float encoder_latency = total_timer.latency() / 1000.0;

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
