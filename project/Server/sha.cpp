#include <cstdlib>
#include <cstdio>
#include <string.h>
#include "sha256.h"
#include "encoder.h"

// for sha256 neon

void SHA(unsigned char *buffer, std::string *hash_table,int * chunk_boundary,int chunk_number,int total_chunk_number)
{
    // hash now contains the SHA-256 hash of buffer
    SHA256 sha256;
    int start_point = 0;
    int end_point = chunk_boundary[0];
    for (int chunk = 0; chunk < chunk_number; chunk++)
    {
        int length = end_point - start_point;
        hash_table[total_chunk_number + chunk] = sha256(&buffer[start_point], length);
        start_point = end_point;
        end_point = chunk_boundary[chunk + 1];
    }
}

void sha_neon(unsigned char *buffer, uint32_t hash_table[][12],int * chunk_boundary,int chunk_number,int total_chunk_number)
{
    int start_point = 0;
    int end_point = chunk_boundary[0];
    for (int chunk = 0; chunk < chunk_number; chunk++)
    {
        uint32_t state[8] = {
        0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
        0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
        };
        int length = end_point - start_point;
        int insert_index = total_chunk_number + chunk;

        sha256_process_arm(state,&buffer[start_point],length);
        for(int i = 0 ; i < 8;i++){
        hash_table[insert_index][i] = state[i];
        }
        hash_table[insert_index][8] = length;

        hash_table[insert_index][9] = buffer[start_point];
        hash_table[insert_index][10] = buffer[start_point+(length)%3];
        hash_table[insert_index][11] = buffer[start_point+(length)%7];

        start_point = end_point;
        end_point = chunk_boundary[chunk + 1];
    }
}