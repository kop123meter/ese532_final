#include "encoder.h"

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include "server.h"
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <math.h>
#include "stopwatch.h"
#include "LZW.h"
#include "LZW_new.h"

#define NUM_PACKETS 8
#define pipe_depth 4
#define DONE_BIT_L (1 << 7)
#define DONE_BIT_H (1 << 15)

int offset = 0;
int chunk_number = 0;
int chunk_boundary[1000];
unsigned char* file;

void handle_input(int argc, char* argv[], int* blocksize) {
	int x;
	extern char *optarg;

	while ((x = getopt(argc, argv, ":b:")) != -1) {
		switch (x) {
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
        for(int i = 0;i < WIN_SIZE ; i++){
                temp =  (uint64_t)(input[pos+WIN_SIZE-1-i]);
                temp = temp * pow(PRIME,i+1);
                hash = hash + temp;
        }
        return hash;
}

void cdc(unsigned char *buff, unsigned int buff_size)
{
    for(u_int i = WIN_SIZE; i < (buff_size - WIN_SIZE);i++){
        if((hash_func(buff,i) % MODULUS) == TARGET){
            //create chunk here
			chunk_boundary[chunk_number] = i;
			chunk_number++;
		}
    }
}

// placeholder SHA function

void SHA256(unsigned char *buffer, uint64_t * hash_table)
{
	// hash now contains the SHA-256 hash of buffer
	uint64_t modulous = pow(2,32);
	int start_point = 0;
	int end_point = chunk_boundary[0];
	for(int chunk = 0; chunk < chunk_number;chunk++){
		int length = end_point - start_point;
		uint64_t hash = 0;
		uint64_t temp = 0;
		for(int i = 0;i<length;i++){
			temp = (uint64_t)buffer[start_point+i];
			hash = hash + temp;
		}
	hash_table[chunk] = hash % modulous;
	start_point = end_point;
	end_point = chunk_boundary[chunk+1];
	}
	
}



void hashing_deduplication(uint64_t * hash_table,unsigned char * input,unsigned char * output){
	int start = 0;
	int end = chunk_boundary[0];
	uint32_t chunk_index = 0;
	unsigned char *lzw_header = (unsigned char*)malloc(4 * sizeof(unsigned char));
	for(int i = 0;i<chunk_number;i++){
		int flag = 0;
		int chunk_size = end - start;
		for(int j = 0;j<i;j++){
			if((hash_table[i] == hash_table[j] )&& (i != j)){
				flag = 1;
				chunk_index = i;
				break;
			}
		}
		if(flag == 0){
			//unique_chunk[unique_chunk_number++] = i;
			int input_size = end - start;
			unsigned char *output_temp = (unsigned char*) malloc(sizeof(unsigned char) * 8192);
			unsigned char *input_chunk = (unsigned char*) malloc(sizeof(unsigned char) * input_size);
			memcpy(&input_chunk[0],&input[start],input_size);
			int * size = (int *)malloc(sizeof(int)*1);
			hardware_encoding(input_chunk,output_temp,size,input_size);
			lzw_header[3] = size[0] << 1;
			lzw_header[2] = size[0] >> 7;
			lzw_header[1] = size[0] >> 15;
			lzw_header[0] = size[0] >> 23;
			memcpy(&output[offset],&lzw_header, 4);
			offset  = offset  + 4;
			memcpy(&output[offset], output_temp, size[0]);
			offset  = offset  + size[0];
			free(size);
			free(input_chunk);
			free(output_temp);

		}
		else if(flag == 1){
			//dedup_chunk[ded_chunk_number++] = i;
			lzw_header[3] = chunk_index << 1 || 1;
			lzw_header[2] = chunk_index >> 7;
			lzw_header[1] = chunk_index >> 15;
			lzw_header[0] = chunk_index >> 23;
			memcpy(&output[offset],&lzw_header, 4);
			offset  = offset  + 4;
			flag = 0;
		}
		start = end;
		end = chunk_boundary[i+1];
	}
	free(lzw_header);
}




int main(int argc, char* argv[]) {
	stopwatch ethernet_timer;

	unsigned char* input[NUM_PACKETS];
	int writer = 0;
	int done = 0;
	int length = 0;
	int count = 0;
	ESE532_Server server;

	// default is 2k
	int blocksize = BLOCKSIZE;

	// set blocksize if decalred through command line
	handle_input(argc, argv, &blocksize);

	file = (unsigned char*) malloc(sizeof(unsigned char) * 70000000);
	if (file == NULL) {
		printf("help\n");
	}

	for (int i = 0; i < NUM_PACKETS; i++) {
		input[i] = (unsigned char*) malloc(
				sizeof(unsigned char) * (NUM_ELEMENTS + HEADER));
		if (input[i] == NULL) {
			std::cout << "aborting " << std::endl;
			return 1;
		}
	}

	server.setup_server(blocksize);

	writer = pipe_depth;
	server.get_packet(input[writer]);
	count++;

	// get packet
	unsigned char* buffer = input[writer];

	// decode
	done = buffer[1] & DONE_BIT_L;
	length = buffer[0] | (buffer[1] << 8);
	length &= ~DONE_BIT_H;
	// printing takes time so be weary of transfer rate
	//printf("length: %d offset %d\n",length,offset);

	// we are just memcpy'ing here, but you should call your
	// top function here.

    
	chunk_number = 0; // initialize chunk number
	cdc(&buffer[HEADER], length);
	uint64_t hash_table[chunk_number];
	SHA256(&buffer[HEADER],hash_table);
	hashing_deduplication(hash_table,&buffer[HEADER],&file[offset]);


	//memcpy(&file[offset], &buffer[HEADER], length);
	//offset += length;
	writer++;

	//last message
	while (!done) {
		// reset ring buffer
		if (writer == NUM_PACKETS) {
			writer = 0;
		}

		ethernet_timer.start();
		server.get_packet(input[writer]);
		ethernet_timer.stop();

		count++;

		// get packet
		unsigned char* buffer = input[writer];

		// decode
		done = buffer[1] & DONE_BIT_L;
		length = buffer[0] | (buffer[1] << 8);
		length &= ~DONE_BIT_H;
		//printf("length: %d offset %d\n",length,offset);
		chunk_number = 0; // initialize chunk number
		cdc(&buffer[HEADER], length);
		uint64_t hash_table_temp[chunk_number];
		SHA256(&buffer[HEADER],hash_table_temp);
		hashing_deduplication(hash_table_temp,&buffer[HEADER],&file[offset]);


		//memcpy(&file[offset], &buffer[HEADER], length);

		writer++;
	}

	// write file to root and you can use diff tool on board
	FILE *outfd = fopen("output_cpu.bin", "wb");
	int bytes_written = fwrite(&file[0], 1, offset, outfd);
	printf("write file with %d\n", bytes_written);
	fclose(outfd);

	for (int i = 0; i < NUM_PACKETS; i++) {
		free(input[i]);
	}

	free(file);
	std::cout << "--------------- Key Throughputs ---------------" << std::endl;
	float ethernet_latency = ethernet_timer.latency() / 1000.0;
	float input_throughput = (bytes_written * 8 / 1000000.0) / ethernet_latency; // Mb/s
	std::cout << "Input Throughput to Encoder: " << input_throughput << " Mb/s."
			<< " (Latency: " << ethernet_latency << "s)." << std::endl;


	return 0;
}

