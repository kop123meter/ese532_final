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
#define MAX_UNIQUE_CHUNK 500


void cdc(unsigned char *buff, unsigned int buff_size,int& chunk_number, int * chunk_boundary);
uint64_t hash_func(unsigned char *input, unsigned int pos);
uint64_t hash_func_revised(unsigned char *input, unsigned int pos);
void SHA(unsigned char *buffer, std::string *hash_table,int * chunk_boundary,int chunk_number,int total_chunk_number);
#endif
