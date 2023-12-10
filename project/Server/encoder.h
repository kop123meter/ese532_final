#ifndef _ENCODER_H_
#define _ENCODER_H_

#include <string>
#include <cstdlib>
// max number of elements we can get from ethernet
#define NUM_ELEMENTS 16384
#define HEADER 2
#define WIN_SIZE 16
#define PRIME 3
#define TARGET 0
#define MODULUS 4096
#define LZW_CHUNK 10
#define CHUNK_BUFFER 2

#define NUM_PACKETS 8
#define pipe_depth 4
#define CHUNK_SIZE_MAX 8192
#define CHUNK_NUMBER_MAX 100000
#define DONE_BIT_L (1 << 7)
#define DONE_BIT_H (1 << 15)


void cdc(unsigned char *buff, unsigned int buff_size,int& chunk_number, int * chunk_boundary);
uint64_t hash_func(unsigned char *input, unsigned int pos);
uint64_t hash_func_revised(unsigned char *input, unsigned int pos);
void SHA(unsigned char *buffer, std::string *hash_table,int * chunk_boundary,int chunk_number,int total_chunk_number);
void sha_neon(unsigned char *buffer, uint32_t hash_table[][12],int * chunk_boundary,int chunk_number,int total_chunk_number);
void sha256_process_arm(uint32_t state[8], const uint8_t data[], uint32_t length);
#endif