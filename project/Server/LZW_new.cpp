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
#pragma HLS pipeline II=1
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
// Compute LZW header
void getlzwheader(unsigned char lzw_header[4], int size, int flag)
{
   // flag = 0 -> unique
   //flag  = 1 -> repeat, size is index
   if (flag == 0)
   {
       lzw_header[0] = size << 1;
       lzw_header[1] = size >> 7;
       lzw_header[2] = size >> 15;
       lzw_header[3] = size >> 23;
   }
   else if (flag == 1)
   {
       lzw_header[0] = size << 1 | 1;
       lzw_header[1] = size >> 7;
       lzw_header[2] = size >> 15;
       lzw_header[3] = size >> 23;
   }
}


// TODO if we don't have 4 chunks, we only have 2 or 1 chunks. How should we do




void hardware_encoding(unsigned char s1[CHUNKS*8192],unsigned char output[CHUNKS*CHUNK_SIZE],int lzw_size[CHUNKS],int input_size[CHUNKS],int chunk_number[1])
{
#pragma HLS INTERFACE m_axi port=s1 bundle=HP1
#pragma HLS INTERFACE m_axi port=output bundle=HP3
#pragma HLS INTERFACE m_axi port=input_size bundle=HP1
#pragma HLS INTERFACE m_axi port=lzw_size bundle=HP3


//init header buffer
unsigned char lzw_header[4];
int total_size = 0; // record previous chunk lzw size; Compute current output pos


//init flag to point chunk


for(int current_chunk = 0; current_chunk <  chunk_number[0];current_chunk++){
//Start LZW


//Determine the type of Current Chunk
// lzw_size[i] = 4 which means current chunk is repeat chunk
// we can save the repeat index in input_size[i]
// So, we just send header
if(lzw_size[current_chunk] == 4){
   getlzwheader(lzw_header,input_size[current_chunk],1);
   output[total_size+0] = lzw_header[0];
   output[total_size+1] = lzw_header[1];
   output[total_size+2] = lzw_header[2];
   output[total_size+3] = lzw_header[3];
   total_size = total_size + 4;
   //move to next chunk
   continue;
}




  unsigned char temp_output[CHUNK_SIZE];
  bool send_two = false;
  unsigned char high_four;




  int hit_second = 2;
  // create hash table and assoc mem
  unsigned long hash_table[2][CAPACITY];
  assoc_mem my_assoc_mem;
  int output_pos = 0;
  output_char = 0;
  output_bit = 0;


  // make sure the memories are clear


     for(int i = 0; i < CAPACITY; i++)
     {
#pragma HLS unroll factor=2
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




  // init the memories with the first 256 codes
//   for(unsigned long i = 0; i < 256; i++)
//   {
//#pragma HLS unroll
//       bool collision = 0;
//       unsigned int key = (i << 8) + 0UL; // lower 8 bits are the next char, the upper bits are the prefix code
//       insert(hash_table, &my_assoc_mem, key, i, &collision);
//   }
  int next_code = 256;


  int prefix_code = s1[current_chunk*8192+0];
  unsigned int code = 0;
  unsigned char next_char = 0;




  int len = input_size[current_chunk];
   std::cout << "len:\t" <<len<<std::endl;
  for(int i = 0;i<len;)
  {
      if(i + 1 == len)
      {
          // transfer
          if(!send_two){
              temp_output[output_pos++] = (unsigned char)(prefix_code >> 4);
              send_two = true;
              high_four = (unsigned char)(prefix_code << 4) & 0xf0;
          } else{
              temp_output[output_pos++] = high_four | ((unsigned char)(prefix_code >> 8) & 0x0f);
              temp_output[output_pos++] = (unsigned char)(prefix_code) & 0xff;
              send_two = false;
          }
          // end
          break;
      }
      next_char = s1[current_chunk*8192 + i + 1];




      bool hit = 0;
      lookup(hash_table, &my_assoc_mem, (prefix_code << 8) + next_char, &hit, &code);
       if(!hit)
      {
          // transfer
          if(!send_two){
              temp_output[output_pos++] = (unsigned char)(prefix_code >> 4);
              send_two = true;
              high_four = (unsigned char)(prefix_code << 4) & 0xf0;
          } else{
              temp_output[output_pos++] = high_four | ((unsigned char)(prefix_code >> 8) & 0x0f);
              temp_output[output_pos++] = (unsigned char)(prefix_code) & 0xff;
              send_two = false;
          }
          // ends






          bool collision = 0;
          insert(hash_table, &my_assoc_mem, (prefix_code << 8) + next_char, next_code, &collision);
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


  if(send_two){
      temp_output[output_pos++] = high_four;
  }
   // Send unique LZW header
   getlzwheader(lzw_header,output_pos,0);
   output[total_size+0] = lzw_header[0];
   output[total_size+1] = lzw_header[1];
   output[total_size+2] = lzw_header[2];
   output[total_size+3] = lzw_header[3];
   total_size = total_size + 4;


   // Send Data
   std::cout << "output len:\t" << output_pos << std::endl;
  // Copy Temp output to output array
  for(int i = 0; i < output_pos; i++){
#pragma HLS unroll
      output[total_size+i] = temp_output[i];
  }
  total_size = total_size + output_pos;
  lzw_size[current_chunk] = output_pos + 4;
 // std::cout << std::endl << "assoc mem entry count: " << my_assoc_mem.fill << std::endl;
   }
  // END of LZW Computing
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
