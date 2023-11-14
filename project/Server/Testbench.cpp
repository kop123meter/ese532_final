#include <iostream>
#include <cstdlib>
#include <chrono>
#include "LZW_new.h"

#define STRING_LENGTH 1000
using namespace std;
typedef unsigned char matrix_type;

matrix_type * Create_string(void)
{
	  matrix_type * Matrix = static_cast<matrix_type *>(
	      malloc(STRING_LENGTH * sizeof(matrix_type)));
	  if (Matrix == NULL)
	  {
	    std::cerr << "Could not allocate matrix." << std::endl;
	    exit (EXIT_FAILURE);
	  }
	  return Matrix;
}

matrix_type * Create_string_output(void)
{
	  matrix_type * Matrix = static_cast<matrix_type *>(
	      malloc(2 * STRING_LENGTH * sizeof(matrix_type)));
	  if (Matrix == NULL)
	  {
	    std::cerr << "Could not allocate matrix." << std::endl;
	    exit (EXIT_FAILURE);
	  }
	  return Matrix;
}

void Destroy_string(matrix_type * Matrix)
{
  free(Matrix);
}

void Randomize_string(matrix_type * Matrix)
{
  for (int i = 0; i < STRING_LENGTH; i++){
	  Matrix[i] = abs(rand() % 256);
	  Matrix[i] = Matrix[i] ? Matrix[i] : 1;
  }
}

bool Compare_strings(const matrix_type *Matrix_1,
                      const matrix_type *Matrix_2, int size)
{
	bool Equal = true;
	for(int i = 0 ;i < size ;i++){
		if(Matrix_1[i] != Matrix_2[i])
		      {
		        std::cout << Matrix_1[i] << "!=" << Matrix_2[i] << std::endl;
		        Equal = false;
		      }
	}
  return Equal;
}

int main(){
	matrix_type *Input = Create_string();
	matrix_type *Output_HW = Create_string_output();
	matrix_type *Output_SW = Create_string_output();
	int size_HW = 0;
	int size_SW = 0;
	Randomize_string(Input);
	hardware_encoding(Input, Output_HW, size_HW, STRING_LENGTH);
	encoding(Input, Output_SW, size_SW, STRING_LENGTH);
	if(size_HW != size_SW){
		cout << "size HW = " << size_HW << "\tsize SW = " << size_SW << endl;
		// return 0;
	}


	bool Equal = Compare_strings(Output_SW, Output_HW, size_HW);

	Destroy_string(Input);
	Destroy_string(Output_HW);
	Destroy_string(Output_SW);
	cout << "TEST " << (Equal ? "PASSED" : "FAILED") << endl;
	return Equal ? 0 : 1;

}