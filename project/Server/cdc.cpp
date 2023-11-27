#include <cstdint>
#include <cstdlib>
#include <math.h>
#include "encoder.h"


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

void cdc(unsigned char *buff, unsigned int buff_size, int& chunk_number,int * chunk_boundary)
{
    for (u_int i = WIN_SIZE; i < (buff_size - WIN_SIZE); i++)
    {
        if ((hash_func(buff, i) % MODULUS) == TARGET)
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
    }
}