#ifndef LZW_H
#define LZW_H
#include <iostream>
#include <stdlib.h>

#define DICT_CAPACITY 65535   // Capacity of the dictionary
#define HEADER 2

/* Global variables */
struct{
    int suffix;
    int parent;
    int firstChild;
    int nextSibling;
}dictionary[DICT_CAPACITY + 1];



extern int nextNodeIdx;    // Index of next node (i.e. next dictionary entry)
extern int decStack[DICT_CAPACITY]; // Stack for decoding a phrase

/* Functions */
int LzwEncoding(unsigned char * outputfile,unsigned char * inputfile,int chunk_start,int chunk_end,int offset);

//void LzwDecoding();
#endif
