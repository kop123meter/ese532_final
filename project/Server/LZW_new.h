#ifndef SRC_APP_H_
#define SRC_APP_H_

#include <hls_stream.h>

#include <iostream>
#include <vector>
#include <unordered_map>
#include <stdlib.h>
#include "stopwatch.h"
#define CHUNKS 4 // Max chunk
#define CHUNK_SIZE 8192
void hardware_encoding(unsigned char s1[CHUNKS * 8194], uint16_t output[CHUNKS * 8193]);
void encoding(unsigned char * s1,unsigned char * output,int &size,int len);
#endif
