#ifndef SRC_APP_H_
#define SRC_APP_H_

#include <hls_stream.h>

#include <iostream>
#include <vector>
#include <unordered_map>
#include <stdlib.h>
#include "stopwatch.h"
#define CHUNKS 4
#define CHUNK_SIZE 8192
void hardware_encoding(unsigned char s1[8192], uint16_t output[8192],int lzw_size[1],int input_size[1],int input2_size[1]);
void encoding(unsigned char * s1,unsigned char * output,int &size,int len);
#endif
