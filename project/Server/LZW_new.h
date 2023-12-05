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
void hardware_encoding(unsigned char * s1,unsigned char * output,int *lzw_size,int *len);
void encoding(unsigned char * s1,unsigned char * output,int &size,int len);
#endif
