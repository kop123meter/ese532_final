#include <cstdint>
#include <cstdlib>
#include <math.h>
#include "encoder.h"

const int const_pow = pow(PRIME, WIN_SIZE);
uint64_t global_hash = 0;

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

uint64_t hash_func_revised(unsigned char *input, unsigned int pos)
{
    global_hash = global_hash - (uint64_t)input[pos - 1] * const_pow;
    global_hash = (global_hash + (uint64_t)input[pos + WIN_SIZE - 1]) * PRIME;
    return global_hash;
}

void cdc(unsigned char *buff, unsigned int buff_size, int& chunk_number,int * chunk_boundary)
{
    global_hash = hash_func(buff, WIN_SIZE - 1);
    for (u_int i = WIN_SIZE; i < (buff_size - WIN_SIZE); i++)
    {
        if ((hash_func_revised(buff, i) % MODULUS) == TARGET)
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
        return;
    }
    else if(chunk_number >= (MAX_UNIQUE_CHUNK)){
        chunk_boundary[chunk_number] = buff_size;
        chunk_number++;
        return;
    }


}