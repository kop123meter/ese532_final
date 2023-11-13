#include <iostream>
#include <vector>
#include <unordered_map>
#include <stdlib.h>
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

void hash_lookup(unsigned long* hash_table, unsigned int key, bool* hit, unsigned int* result)
{
    //std::cout << "hash_lookup():" << std::endl;
    key &= 0xFFFFF; // make sure key is only 20 bits 

    unsigned long lookup = hash_table[my_hash(key)];

    // [valid][value][key]
    unsigned int stored_key = lookup&0xFFFFF;       // stored key is 20 bits
    unsigned int value = (lookup >> 20)&0xFFF;      // value is 12 bits
    unsigned int valid = (lookup >> (20 + 12))&0x1; // valid is 1 bit
    
    if(valid && (key == stored_key))
    {
        *hit = 1;
        *result = value;
        //std::cout << "\thit the hash" << std::endl;
        //std::cout << "\t(k,v,h) = " << key << " " << value << " " << my_hash(key) << std::endl;
    }
    else
    {
        *hit = 0;
        *result = 0;
        //std::cout << "\tmissed the hash" << std::endl;
    }
}

void hash_insert(unsigned long* hash_table, unsigned int key, unsigned int value, bool* collision)
{
    //std::cout << "hash_insert():" << std::endl;
    key &= 0xFFFFF;   // make sure key is only 20 bits
    value &= 0xFFF;   // value is only 12 bits

    unsigned long lookup = hash_table[my_hash(key)];
    unsigned int valid = (lookup >> (20 + 12))&0x1;

    if(valid)
    {
        *collision = 1;
        //std::cout << "\tcollision in the hash" << std::endl;
    }
    else
    {
        hash_table[my_hash(key)] = (1UL << (20 + 12)) | (value << 20) | key;
        *collision = 0;
        //std::cout << "\tinserted into the hash table" << std::endl;
        //std::cout << "\t(k,v,h) = " << key << " " << value << " " << my_hash(key) << std::endl;
    }
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
void insert(unsigned long* hash_table, assoc_mem* mem, unsigned int key, unsigned int value, bool* collision)
{
    hash_insert(hash_table, key, value, collision);
    if(*collision)
    {
        assoc_insert(mem, key, value, collision);
    }
}

void lookup(unsigned long* hash_table, assoc_mem* mem, unsigned int key, bool* hit, unsigned int* result)
{
    hash_lookup(hash_table, key, hit, result);

    if(!*hit)
    {
        assoc_lookup(mem, key, hit, result);
    }
}
//****************************************************************************************************************
void hardware_encoding(unsigned char * s1,unsigned char * output,int &size,int len)
{
	int hit_second = 2;
    // create hash table and assoc mem
    unsigned long hash_table[CAPACITY];
    assoc_mem my_assoc_mem;
    int output_pos = 0;
    size = 0;
    output_char = 0;
    output_bit = 0;

    // make sure the memories are clear
    for(int i = 0; i < CAPACITY; i++)
    {
        hash_table[i] = 0;
    }
    my_assoc_mem.fill = 0;
    for(int i = 0; i < 512; i++)
    {
        my_assoc_mem.upper_key_mem[i] = 0;
        my_assoc_mem.middle_key_mem[i] = 0;
        my_assoc_mem.lower_key_mem[i] = 0;
    }

    // init the memories with the first 256 codes
    for(unsigned long i = 0; i < 256; i++)
    {
#pragma HLS unroll
        bool collision = 0;
        unsigned int key = (i << 8) + 0UL; // lower 8 bits are the next char, the upper bits are the prefix code
        insert(hash_table, &my_assoc_mem, key, i, &collision);
    }
    int next_code = 256;


    int prefix_code = s1[0];
    unsigned int code = 0;
    unsigned char next_char = 0;


    for(int i = 0;i<len;)
//#pragma HLS pipeline II=1
    {
        if(i + 1 == len)
        {
            // transfer
            for(int x = 11; x >= 0; x--){
                output_char = (output_char << 1) | (prefix_code >> (x) & 0x1);
                output_bit++;
                if(output_bit % 8 == 0){
                    output[output_pos++] = output_char;
                    output_char = 0;
                    size++;
                }
            }
            if(output_bit % 8 != 0){
                output_char = output_char << (8 - (output_bit % 8));
                output[output_pos++] = output_char;
                output_char = 0;
                size++;
            }
            // end
            break;
        }
        next_char = s1[i + 1];

        bool hit = 0;
        lookup(hash_table, &my_assoc_mem, (prefix_code << 8) + next_char, &hit, &code);
        if(!hit)
        {
            // transfer
            for(int x = 11; x >= 0; x--){
                output_char = (output_char << 1) | (prefix_code >> (x) & 0x1);
                output_bit++;
                if(output_bit % 8 == 0){
                    output[output_pos++] = output_char;
                    output_char = 0;
                    size++;
                }
            }
            // end
            



            bool collision = 0;
            insert(hash_table, &my_assoc_mem, (prefix_code << 8) + next_char, next_code, &collision);
            // std::cout << "prefix_code:" << prefix_code << "\tnext_code:" << next_code << "\tnext char"<<(int)next_char<< std::endl;std::cout << "prefix_code:" << prefix_code << "\tnext_code:" << next_code << "\tnext char"<<(int)next_char<< std::endl;

            if(collision)
            {
                std::cout << "ERROR: FAILED TO INSERT! NO MORE ROOM IN ASSOC MEM!" << std::endl;
                return;
            }
            next_code += 1;

            prefix_code = next_char;

        }
        else
        {
            prefix_code = code;
        }
        i += 1;
    }
   // std::cout << std::endl << "assoc mem entry count: " << my_assoc_mem.fill << std::endl;
}
//****************************************************************************************************************
void encoding(unsigned char * s1,unsigned char * output,int &size,int len)
{
	bool send_two = false;
	unsigned char high_four;
	int output_pos = 0;

    std::unordered_map<std::string, int> table;
    for (int i = 0; i <= 255; i++) {
        std::string ch = "";
        ch += char(i);
        table[ch] = i;
    }
 
    std::string p = "", c = "";
    p += s1[0];
    int code = 256;
    std::vector<int> output_code;
    for (int i = 0; i < len; i++) {
        if (i != len - 1)
            c += s1[i + 1];
        if (table.find(p + c) != table.end()) {
            p = p + c;
        }
        else {
            // output_code.push_back(table[p]);
            if(!send_two){
            	output[output_pos++] = (unsigned char)(table[p] >> 4);
            	send_two = true;
            	high_four = (unsigned char)(table[p] << 4) & 0xf0;
            } else{
            	output[output_pos++] = high_four | ((unsigned char)(table[p] >> 8) & 0x0f);
            	output[output_pos++] = (unsigned char)(table[p]) & 0xff;
            	send_two = false;
            }
            size += 1;
            table[p + c] = code;
            code++;
            p = c;
        }
        c = "";
    }
    output_code.push_back(table[p]);
    if(!send_two){
    	output[output_pos++] = (unsigned char)(table[p] >> 4);
        send_two = true;
        high_four = (unsigned char)(table[p] << 4) & 0xf0;
    } else{
    	output[output_pos++] = high_four | ((unsigned char)((table[p] >> 8) & 0x0f));
    	output[output_pos++] = (unsigned char)(table[p]) & 0xff;
        send_two = false;
    }

    if(send_two){
    	output[output_pos++] = high_four;
    }
    size = output_pos;
}

void decoding(std::vector<int> op)
{
    std::cout << "\nDecoding\n";
    std::unordered_map<int, std::string> table;
    for (int i = 0; i <= 255; i++) {
        std::string ch = "";
        ch += char(i);
        table[i] = ch;
    }
    int old = op[0], n;
    std::string s = table[old];
    std::string c = "";
    c += s[0];
    std::cout << s;
    int count = 256;
    for (int i = 0; i < op.size() - 1; i++) {
        n = op[i + 1];
        if (table.find(n) == table.end()) {
            s = table[old];
            s = s + c;
        }
        else {
            s = table[n];
        }
        std::cout << s;
        c = "";
        c += s[0];
        table[count] = table[old] + c;
        count++;
        old = n;
    }
}
