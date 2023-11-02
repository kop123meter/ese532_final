#include <iostream>
#include <stdlib.h>
#include "LZW.h"


void InitialiseDict() {	// Dictionary initialisation (initialise root node 0-255)
	for (int i = 0; i < 256; i++) {
		dictionary[i].suffix = i;  // The suffix of each node is the corresponding ASCII code
		dictionary[i].parent = -1;  // Temporarily doesn't have a parent node (i.e. prefix)
		dictionary[i].firstChild = -1;  // Temporarily doesn't have any child nodes
		dictionary[i].nextSibling = i + 1;	// The index of the next sibling root node is the next ASCII code
	}

	dictionary[255].nextSibling = -1;	// No next sibling for the last root node
	nextNodeIdx = 256;	// The index of next dictionary entry
}

int InDict(int P, int C) {
	if (P == -1) {
		/* In this case, the current character is the start of the file,
		and it's evidently in the dictionary,
		thus return the corresponding ASCII code (let P = this character). */
		return C;
	}

	/* Traverse all child node(s) of node P from left to right (i.e. all sibling nodes of the first child node) */
	int sibling = dictionary[P].firstChild;	// Start from the first child of P
	while (sibling > -1) {	// sibling == -1 indicates the end of sibling traversal
		/* If a C-suffixed sibling is found, then return the code of PC (i.e. the index of this sibling) */
		if (C == dictionary[sibling].suffix) {
			return sibling;
		}
		/* If the suffixes don't match, then look for the next */
		sibling = dictionary[sibling].nextSibling;
	}

	/* The suffix of all siblings don't match PC, thus PC isn't in the dictionary */
	return -1;
}

void NewDictEntry(int P, int C) {
	if (P < 0) {
		return;
	}

	dictionary[nextNodeIdx].suffix = C;
	dictionary[nextNodeIdx].parent = P;
	dictionary[nextNodeIdx].nextSibling = -1;	// Indicates that the node is the last sibling
	dictionary[nextNodeIdx].firstChild = -1;	// Temporarily this node doesn't have a child
	int pFirstChild = dictionary[P].firstChild;	// The first child of P
	int pChild;

	/* Set up the new sibling-relation */
	if (pFirstChild > -1) {	/* Parent of the new node originally have a child node */
		pChild = pFirstChild;	// Start from the first child of P

		/* Look for the youngest child of P (i.e. the last sibling) */
		while (dictionary[pChild].nextSibling > -1) {
			pChild = dictionary[pChild].nextSibling;
		}

		dictionary[pChild].nextSibling = nextNodeIdx;	// Set the new node as the next sibling of the current last sibling
	} else {	/* Parent of the new node originally doesn't have a child */
		dictionary[P].firstChild = nextNodeIdx;	// Set the new node as PC (i.e. the first child of P)
	}

	nextNodeIdx++;	//Index of the next entry + 1
}

int LzwEncoding(unsigned char * outputfile,unsigned char * inputfile,int chunk_start,int chunk_end,int offset) {
	int previousStr;	// P
	int currentChar;	// C
	int PC;	// P & C combined as 1 character

	/* Get the Chunk Size */
	int size = chunk_end - chunk_start;
	int flag = HEADER;
	int output_flag = offset;



	/* Initialise the dictionary and P */
	InitialiseDict();
	previousStr = -1;	// Initialise P

	// Read first character
	currentChar = (int)inputfile[flag];

	//fprintf(outFilePtr, "LZW-encoded string: ");
	while (size!=0) {
		/* Check if PC is in the dictionary */
		PC = InDict(previousStr, currentChar);
		if (PC >= 0) {	/* PC is in the dictionary */
			previousStr = PC;	// Set P = PC
		} else {	/* PC isn't in the dictionary */
			//Output(outBitFilePtr, previousStr);	
			// Output P
			outputfile[output_flag++] = previousStr;

			if (nextNodeIdx < DICT_CAPACITY) {	/* Enough space to add PC into the dictionary */
				NewDictEntry(previousStr, currentChar);
			}
			previousStr = currentChar;	// Set P = C
		}
	}

	//Output(outBitFilePtr, previousStr);	
	// Output the last unencoded character(s)
	outputfile[output_flag++] = previousStr;
    
	return output_flag;



}

