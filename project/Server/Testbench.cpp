#include <iostream>
#include <cstdlib>
#include <chrono>
#include "LZW_new.h"

//#define STRING_LENGTH 2500
//using namespace std;
//typedef unsigned char matrix_type;
//
//matrix_type * Create_string(void)
//{
//	  matrix_type * Matrix = static_cast<matrix_type *>(
//	      malloc(STRING_LENGTH * sizeof(matrix_type)));
//	  if (Matrix == NULL)
//	  {
//	    std::cerr << "Could not allocate matrix." << std::endl;
//	    exit (EXIT_FAILURE);
//	  }
//	  return Matrix;
//}
//
//matrix_type * Create_string_output(void)
//{
//	  matrix_type * Matrix = static_cast<matrix_type *>(
//	      malloc(2 * STRING_LENGTH * sizeof(matrix_type)));
//	  if (Matrix == NULL)
//	  {
//	    std::cerr << "Could not allocate matrix." << std::endl;
//	    exit (EXIT_FAILURE);
//	  }
//	  return Matrix;
//}
//
//void Destroy_string(matrix_type * Matrix)
//{
//  free(Matrix);
//}
//
//void Randomize_string(matrix_type * Matrix)
//{
//  for (int i = 0; i < STRING_LENGTH; i++){
//	  Matrix[i] = abs(rand() % 256);
//	  Matrix[i] = Matrix[i] ? Matrix[i] : 1;
//  }
//}
//
//bool Compare_strings(const matrix_type *Matrix_1,
//                      const matrix_type *Matrix_2, int size)
//{
//	bool Equal = true;
//	for(int i = 0 ;i < size ;i++){
//		if(Matrix_1[i] != Matrix_2[i])
//		      {
//		        std::cout <<"Number\t"<<i<<":\t"<<(int)Matrix_1[i] << "!=" << (int)Matrix_2[i] << std::endl;
//		        Equal = false;
//		      }
//	}
//  return Equal;
//}
void hardware_encoding(unsigned char s1[CHUNKS * 8194], uint16_t output[CHUNKS * 8193]);

int main(){
	unsigned char s1[8194 * 4];
	for(int i = 0; i < 4; i++){
		s1[8194 * i] = 70;
		s1[8194 * i + 1] = 50;
		for(int j = 2; j < 8000; j++){
			s1[8194 * i + j] = abs(rand() % 256);
			if(s1[8194 * i + j] == 0){
				s1[8194 * i + j] = 1;
			}
		}
	}
	uint16_t output[8193 * 4];
	hardware_encoding(s1, output);
	// int size[4];
	for(int i = 0; i < 4; i++){
		std::cout << "compress size:" << output[8193 * i] << std::endl;
	}

	for(int i = 1; i < 10; i++){
		std::cout << "data:" << output[3*8193 + i] << std::endl;
	}
	return 0;

}
