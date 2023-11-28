#include <cstdlib>
#include <cstdio>
#include <string.h>
#include "sha256.h"
#include "encoder.h"

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