#ifndef SRC_APP_H_
#define SRC_APP_H_

#include <hls_stream.h>

#include <iostream>
#include <vector>
#include <unordered_map>
#include <stdlib.h>
#include "stopwatch.h"
#define CHUNKS 10
#define CHUNK_SIZE 8196 // 8192 + 4
void hardware_encoding(unsigned char s1[CHUNKS*8192],unsigned char output[CHUNKS*CHUNK_SIZE],int lzw_size[CHUNKS],int input_size[CHUNKS],int chunk_flag[CHUNKS+1]);
void encoding(unsigned char * s1,unsigned char * output,int &size,int len);
void getlzwheader(unsigned char lzw_header[4], int size, int flag);
#endif
