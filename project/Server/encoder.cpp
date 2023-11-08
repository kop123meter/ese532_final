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
#include <sys/mman.h>
#include <math.h>
#include <bitset>
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
		// Change 0 to Header / WIN_SIZE 
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
		//change buff to buff+HEADER
        if((hash_func(buff,i) % MODULUS) == TARGET){
            //create chunk here
			chunk_boundary[chunk_number] = i;
			chunk_number++;
		}
    }
	// if(chunk_boundary[chunk_number-1] != (buff_size)){
	// 	chunk_boundary[chunk_number] = buff_size;
	// 	chunk_number++;
	// }
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

void getlzwheader(unsigned char *lzw_header,int size,int flag){
	if(flag == 0){
		lzw_header[0] = size << 1;
		lzw_header[1] = size >> 7;
		lzw_header[2] = size >> 15;
		lzw_header[3] = size >> 23;
	}
	else if(flag == 1){
		lzw_header[0] = size << 1 | 1;
		lzw_header[1] = size >> 7;
		lzw_header[2] = size >> 15;
		lzw_header[3] = size >> 23;
	}
}


void hashing_deduplication(uint64_t * hash_table,int i,int &flag,int &chunk_index){
	//unsigned char *lzw_header = (unsigned char*)malloc(4 * sizeof(unsigned char));
		for(int j = 0; j < i;j++){
			if((hash_table[i] == hash_table[j]) && (i != j)){
				flag = 1;
				chunk_index = j;
				break;
			}
		}
		
}



int main(int argc, char* argv[]) {
	stopwatch ethernet_timer;
	

	unsigned char* input[NUM_PACKETS];
	int writer = 0;
	int done = 0;
	int length = 0;
	unsigned char* lzw_header = (unsigned char*)malloc(4 * sizeof(unsigned char));
	unsigned char* output_temp = (unsigned char*)malloc(70000000 * sizeof(unsigned char));
	unsigned char* input_temp = (unsigned char*)malloc(70000000 * sizeof(unsigned char));
	unsigned char* input_packet_buffer = (unsigned char*)malloc(70000000 * sizeof(unsigned char));

	ESE532_Server server;

	// default is 2k
	int blocksize = BLOCKSIZE;

	// set blocksize if decalred through command line
	handle_input(argc, argv, &blocksize);

	file = (unsigned char*) malloc(sizeof(unsigned char) *  70000000);
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

	// get packet
	unsigned char* buffer = input[writer];

	// decode
	done = buffer[1] & DONE_BIT_L;
	length = buffer[0] | (buffer[1] << 8);
	length &= ~DONE_BIT_H;
    
	chunk_number = 0; // initialize chunk number
	cdc(&buffer[HEADER], length);

	// hash
	std::cout << "*************** hash table ***************" << std::endl;
	for(int i = 0; i < chunk_number;i++){
		std::cout<<"chunk_boundary: "<<chunk_boundary[i]<<std::endl;
	}
	std::cout << "*************** hash table ***************" << std::endl;


	uint64_t hash_table[chunk_number];
	SHA256(&buffer[HEADER],hash_table);

	//Copy DATA to buffer
	memcpy(&input_packet_buffer[0],&buffer[HEADER],length);

	std::cout << "*************** DATA Length ***************" << std::endl;
	std::cout << "length: " << length << std::endl;
	std::cout << "*************** DATA Length ***************" << std::endl;
	
	// Deduplicate

	int flag = 0;
	int chunk_index = 0;
	int start = 0;
	int end = chunk_boundary[0];
	for(int i = 0 ; i < chunk_number ;i++){
		hashing_deduplication(hash_table,i,flag,chunk_index);
		int input_size = end - start;
		std::cout<<"input_size: "<<input_size<<std::endl;
		if(flag == 1){
			getlzwheader(&lzw_header[0],chunk_index,1);
			memcpy(&file[offset], &lzw_header[0], 4);
			offset += 4;
			flag = 0;
		}
		else{
			// unique chunk
			int lzw_size = 0;
			// memcpy(&input_temp[0],&buffer[start],input_size);
			// hardware_encoding(&input_temp[0],&output_temp[0],lzw_size,input_size);
			hardware_encoding(&input_packet_buffer[start],&output_temp[0],lzw_size,input_size);
			getlzwheader(&lzw_header[0],lzw_size,0);
			memcpy(&file[offset], &lzw_header[0], 4);
			offset += 4;
			memcpy(&file[offset], &output_temp[0], lzw_size);
			offset += lzw_size;
		}
		start = end;
		end = chunk_boundary[i+1];
	}



	writer++;
	
	
	while (!done) {
		// reset ring buffer
		if (writer == NUM_PACKETS) {
			writer = 0;
		}

		ethernet_timer.start();
		server.get_packet(input[writer]);
		ethernet_timer.stop();


		// get packet
		unsigned char* buffer = input[writer];
		// decode
		done = buffer[1] & DONE_BIT_L;
		length = buffer[0] | (buffer[1] << 8);
		length &= ~DONE_BIT_H;



		chunk_number = 0; // initialize chunk number
		cdc(&buffer[HEADER], length);
		uint64_t hash_table_temp[chunk_number];
		SHA256(&buffer[HEADER],hash_table_temp);

		//Copy DATA to buffer
		memcpy(&input_packet_buffer[0],&buffer[HEADER],length);

		//deduplication
		flag = 0;
		chunk_index = 0;
		start = 0;
		end = chunk_boundary[0];
	for(int i = 0 ; i < chunk_number ;i++){
		hashing_deduplication(hash_table_temp,i,flag,chunk_index);
		if(flag == 1){
			getlzwheader(&lzw_header[0],chunk_index,1);
			memcpy(&file[offset], &lzw_header[0], 4);
			offset += 4;
			flag = 0;
		}
		else{
			// unique chunk
			int lzw_size = 0;
			int input_size = end - start;
			//memcpy(&input_temp[0],&input_packet_buffer[start],input_size);
			//hardware_encoding(&input_temp[0],&output_temp[0],lzw_size,input_size);
			hardware_encoding(&input_packet_buffer[start],&output_temp[0],lzw_size,input_size);
			getlzwheader(&lzw_header[0],lzw_size,0);
			memcpy(&file[offset], &lzw_header[0], 4);
			offset += 4;
			memcpy(&file[offset], &output_temp[0], lzw_size);
			offset += lzw_size;
		}
		start = end;
		end = chunk_boundary[i+1];
	}


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
	free(lzw_header);
	free(output_temp);
	free(input_temp);
	free(input_packet_buffer);
	std::cout << "--------------- Key Throughputs ---------------" << std::endl;
	float ethernet_latency = ethernet_timer.latency() / 1000.0;
	float input_throughput = (bytes_written * 8 / 1000000.0) / ethernet_latency; // Mb/s
	std::cout << "Input Throughput to Encoder: " << input_throughput << " Mb/s."
			<< " (Latency: " << ethernet_latency << "s)." << std::endl;


	return 0;
}

