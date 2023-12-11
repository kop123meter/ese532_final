#include <iostream>
#include <vector>
#include <unordered_map>
#include <stdlib.h>
#include <hls_stream.h>
#include "LZW_new.h"
//****************************************************************************************************************
#define CAPACITY 32768 // hash output is 15 bits, and we have 1 entry per bucket, so capacity is 2^15
//#define CAPACITY 4096
// try  uncommenting the line above and commenting line 6 to make the hash table smaller
// and see what happens to the number of entries in the assoc mem
// (make sure to also comment line 27 and uncomment line 28)
static unsigned char output_char = 0;
static int output_bit = 0;

unsigned int my_hash(unsigned long key)
{
    key &= 0xFFFFF; // make sure the key is only 20 bits

    unsigned int hashed = 0;

    for(int i = 0; i < 20; i++)
//#pragma HLS pipeline II=2
    {
        hashed += (key >> i)&0x01;
        hashed += hashed << 10;
        hashed ^= hashed >> 6;
    }
    hashed += hashed << 3;
    hashed ^= hashed >> 11;
    hashed += hashed << 15;
    return hashed & 0x7FFF;          // hash output is 15 bits
    //return hashed & 0xFFF;
}

void hash_lookup(unsigned long hash_table[2][CAPACITY], unsigned int key, bool* hit, unsigned int* result)
{
    //std::cout << "hash_lookup():" << std::endl;
    key &= 0xFFFFF; // make sure key is only 20 bits

    unsigned long lookup_0 = hash_table[0][my_hash(key)];
    unsigned long lookup_1 = hash_table[1][my_hash(key)];

    // [valid][value][key]
    unsigned int stored_key_0 = lookup_0&0xFFFFF;       // stored key is 20 bits
    unsigned int value_0 = (lookup_0 >> 20)&0xFFF;      // value is 12 bits
    unsigned int valid_0 = (lookup_0 >> (20 + 12))&0x1; // valid is 1 bit

    unsigned int stored_key_1 = lookup_1&0xFFFFF;       // stored key is 20 bits
    unsigned int value_1 = (lookup_1 >> 20)&0xFFF;      // value is 12 bits
    unsigned int valid_1 = (lookup_1 >> (20 + 12))&0x1; // valid is 1 bit

    if(valid_0 && (key == stored_key_0))
    {
        *hit = 1;
        *result = value_0;
        //std::cout << "\thit the hash" << std::endl;
        //std::cout << "\t(k,v,h) = " << key << " " << value << " " << my_hash(key) << std::endl;
    }
    else if(valid_1 && (key == stored_key_1))
    {
        *hit = 1;
        *result = value_1;
    }
    else
    {
        *hit = 0;
        *result = 0;
        //std::cout << "\tmissed the hash" << std::endl;
    }
}

void hash_insert(unsigned long hash_table[2][CAPACITY], unsigned int key, unsigned int value, bool* collision)
{
   //std::cout << "hash_insert():" << std::endl;
   key &= 0xFFFFF;   // make sure key is only 20 bits
   value &= 0xFFF;   // value is only 12 bits
   unsigned int hash_result = my_hash(key);
   unsigned long lookup_0 = hash_table[0][hash_result];
   unsigned int valid_0 = (lookup_0 >> (20 + 12))&0x1;
   if(!valid_0){
       hash_table[0][hash_result] = (1UL << (20 + 12)) | (value << 20) | key;
       *collision = 0;
       return;
   }
   unsigned long lookup_1 = hash_table[1][hash_result];
   unsigned int valid_1 = (lookup_1 >> (20 + 12))&0x1;
   if(!valid_1){
       hash_table[1][hash_result] = (1UL << (20 + 12)) | (value << 20) | key;
       *collision = 0;
       return;
   }
   *collision = 1;
}

//****************************************************************************************************************
typedef struct
{
    // Each key_mem has a 9 bit address (so capacity = 2^9 = 512)
    // and the key is 20 bits, so we need to use 3 key_mems to cover all the key bits.
    // The output width of each of these memories is 64 bits, so we can only store 64 key
    // value pairs in our associative memory map.

    unsigned long upper_key_mem[512]; // the output of these  will be 64 bits wide (size of unsigned long).
    unsigned long middle_key_mem[512];
    unsigned long lower_key_mem[512];
    unsigned int value[64];    // value store is 64 deep, because the lookup mems are 64 bits wide
    unsigned int fill;         // tells us how many entries we've currently stored
} assoc_mem;

// cast to struct and use ap types to pull out various feilds.

void assoc_insert(assoc_mem* mem,  unsigned int key, unsigned int value, bool* collision)
{
    //std::cout << "assoc_insert():" << std::endl;
    key &= 0xFFFFF; // make sure key is only 20 bits
    value &= 0xFFF;   // value is only 12 bits

    if(mem->fill < 64)
    {
        mem->upper_key_mem[(key >> 18)%512] |= (1 << mem->fill);  // set the fill'th bit to 1, while preserving everything else
        mem->middle_key_mem[(key >> 9)%512] |= (1 << mem->fill);  // set the fill'th bit to 1, while preserving everything else
        mem->lower_key_mem[(key >> 0)%512] |= (1 << mem->fill);   // set the fill'th bit to 1, while preserving everything else
        mem->value[mem->fill] = value;

        mem->fill++;
        *collision = 0;
    }
    else
    {
        *collision = 1;
        // std::cout << "\tcollision in the assoc mem" << std::endl;
    }
}

void assoc_lookup(assoc_mem* mem, unsigned int key, bool* hit, unsigned int* result)
{
    //std::cout << "assoc_lookup():" << std::endl;
    key &= 0xFFFFF; // make sure key is only 20 bits

    unsigned int match_high = mem->upper_key_mem[(key >> 18)%512];
    unsigned int match_middle = mem->middle_key_mem[(key >> 9)%512];
    unsigned int match_low  = mem->lower_key_mem[(key >> 0)%512];

    unsigned int match = match_high & match_middle & match_low;

    unsigned int address = 0;
    for(; address < 64; address++)
#pragma HLS unroll
    {
        if((match >> address) & 0x1)
        {
            break;
        }
    }
    if(address != 64)
    {
        *result = mem->value[address];
        *hit = 1;
        // if(*result == 283){
        // std::cout << "\thit the assoc" << std::endl;
        // std::cout << "\t(k,v) = " << key << " " << *result << std::endl;
        // }
    }
    else
    {
        *hit = 0;
        //std::cout << "\tmissed the assoc" << std::endl;
    }
}
//****************************************************************************************************************
void insert(unsigned long hash_table[2][CAPACITY], assoc_mem* mem, unsigned int key, unsigned int value, bool* collision)
{
    hash_insert(hash_table, key, value, collision);
    if(*collision)
    {
        assoc_insert(mem, key, value, collision);
    }
}

void lookup(unsigned long hash_table[2][CAPACITY], assoc_mem* mem, unsigned int key, bool* hit, unsigned int* result)
{
    hash_lookup(hash_table, key, hit, result);

    if(!*hit)
    {
        assoc_lookup(mem, key, hit, result);
    }
}
//****************************************************************************************************************
/*
 load function
  s1 :
 	 chunk_size = s1[chunk*8194+0] * 100 + s1[chunk*8194+1]
 	 s1[chunk*8194 + 2~8193] = data
 */

void read_input(unsigned char s1[CHUNKS*8194],hls::stream<unsigned char>& input){
	for(int c = 0; c < CHUNKS;c++){
		// get chunk size
		int size_upper = (int)s1[c * 8194 + 0];
		int size_lower = (int)s1[c * 8194 + 1];
		int size = size_upper * 100 + size_lower;
		input.write(s1[c * 8194 + 0]);
		input.write(s1[c * 8194 + 1]);
		for(int i = 0; i < size ;i++){
			input.write(s1[c * 8194 + i + 2]);
		}
	}

}
void computing(hls::stream<unsigned char>& input, hls::stream<uint16_t>& output){
		unsigned char temp_chunk[8192];

		for(int c = 0; c <CHUNKS;c++){

			// Get chunk size first
			int len_upper = (int)input.read();
			int len_lower = (int)input.read();
			int len = len_upper * 100 + len_lower;


			// Read Chunk data
			for(int i = 0 ;i < len;i++){
				temp_chunk[i] = input.read();
			}

			// Init
			 // create hash table and assoc mem
			unsigned long hash_table[2][CAPACITY];
			assoc_mem my_assoc_mem;

			// make sure the memories are clear
			for(int i = 0; i < CAPACITY; i++)
#pragma HLS unroll factor=2
			{
				hash_table[0][i] = 0;
				hash_table[1][i] = 0;
			}
			my_assoc_mem.fill = 0;
			for(int i = 0; i < 512; i++)
			{
				 my_assoc_mem.upper_key_mem[i] = 0;
				 my_assoc_mem.middle_key_mem[i] = 0;
				 my_assoc_mem.lower_key_mem[i] = 0;
			}
			int next_code = 256;
			int prefix_code = temp_chunk[0];
			unsigned int code = 0;
			unsigned char next_char = 0;
			// LZW computing
			//size[c] = 0;
			for(int i = 0; i < len;i++)
			{
				if(i + 1 == len){
					//size[c]++;
					output.write((uint16_t)prefix_code);
					break;
				}
				next_char = temp_chunk[i+1];
				bool hit = 0;
				lookup(hash_table, &my_assoc_mem, (prefix_code << 8) + next_char, &hit, &code);
				if(!hit)
				{
					 //size[c]++;
					 output.write((uint16_t)prefix_code);
					 bool collision = 0;
					 insert(hash_table, &my_assoc_mem, (prefix_code << 8) + next_char, next_code, &collision);
					 if(collision)
					 {
					    std::cout << "ERROR: FAILED TO INSERT! NO MORE ROOM IN ASSOC MEM!" << std::endl;
					    return;
					 }
					 next_code += 1;
					 prefix_code = next_char;
				} else{
					 prefix_code = code;
					  }

			}
			output.write((uint16_t)0xf000);
			// end of one chunk computing
		} // end of 4 chunks
}

void write_output(hls::stream<uint16_t>& output_stream, uint16_t output[CHUNKS*8193]){
	for(int c = 0; c < CHUNKS ; c++){
		int size = 0;
		for(int i = 1; i < 	8193;i++){
			uint16_t tmp_data = output_stream.read();
			if( tmp_data == (uint16_t)(0xf000)){
				break;
			}

			output[c*8193+i] = tmp_data;
			size++;

		}
		output[c*8193+0] = size;
	}
}
/****************************************************************
 s1 :
 	 chunk_size = s1[chunk*8194+0] * 100 + s1[chunk*8194+1]
 	 s1[chunk*8194 + 2~8193] = data

 output:
 	 output[chunk*8193+0] = compress size
 	 output[chunk*8193 + 1~8192] = data
 */

void hardware_encoding(unsigned char s1[CHUNKS * 8194], uint16_t output[CHUNKS * 8193])
{
#pragma HLS INTERFACE m_axi port=s1 bundle=HP1
#pragma HLS INTERFACE m_axi port=output bundle=HP3



   // Stream for Read buffer
   hls::stream<unsigned char> input_stream;

   //Stream for Output buffer
   hls::stream<uint16_t> output_stream;
#pragma HLS STREAM variable=input_stream depth=500
#pragma HLS STREAM variable=output_stream depth=500


#pragma HLS DATAFLOW
   read_input(s1,input_stream);
   computing(input_stream,output_stream);
   write_output(output_stream, output);
}

