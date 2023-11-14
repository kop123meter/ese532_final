#ifndef SRC_UTILITIES_
#define SRC_UTILITIES_

#define CL_HPP_CL_1_2_DEFAULT_BUILD
#define CL_HPP_TARGET_OPENCL_VERSION 120
#define CL_HPP_MINIMUM_OPENCL_VERSION 120
#define CL_HPP_ENABLE_PROGRAM_CONSTRUCTION_FROM_ARRAY_COMPATIBILITY 1
#define CL_USE_DEPRECATED_OPENCL_1_2_APIS

#define INPUT_FRAME_WIDTH  (960)
#define INPUT_FRAME_HEIGHT (540)

#define FILTER_LENGTH (7)

#define SCALED_FRAME_WIDTH  (INPUT_FRAME_WIDTH / 2)
#define SCALED_FRAME_HEIGHT (INPUT_FRAME_HEIGHT / 2)

#define OUTPUT_FRAME_WIDTH  (SCALED_FRAME_WIDTH - (FILTER_LENGTH - 1))
#define OUTPUT_FRAME_HEIGHT (SCALED_FRAME_HEIGHT - (FILTER_LENGTH - 1))

#define INPUT_FRAME_SIZE (INPUT_FRAME_WIDTH * INPUT_FRAME_HEIGHT)
#define SCALED_FRAME_SIZE (SCALED_FRAME_WIDTH * SCALED_FRAME_HEIGHT)
#define OUTPUT_FRAME_SIZE (OUTPUT_FRAME_WIDTH * OUTPUT_FRAME_HEIGHT)

#define FRAMES (200)

#define STAGES (4)

#define MAX_OUTPUT_SIZE (5000 * 1024 * 10)


// OCL_CHECK doesn't work if call has templatized function call
#define OCL_CHECK(error, call)                                                 \
  call;                                                                        \
  if (error != CL_SUCCESS) {                                                   \
    printf("%s:%d Error calling " #call ", error code is: %d\n", __FILE__,     \
           __LINE__, error);                                                   \
    exit(EXIT_FAILURE);                                                        \
  }

#include <vector>
#include <unistd.h>
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <thread>
#include <stdio.h>
#include <CL/cl2.hpp>

void Exit_with_error(const char *s);
void Load_data(unsigned char *Data);
void pin_thread_to_cpu(std::thread &t, int cpu_num);
void pin_main_thread_to_cpu0();
void Store_data(const char *Filename, unsigned char *Data, unsigned int Size);
void Check_data(unsigned char *Data, unsigned int Size);
std::vector<cl::Device> get_xilinx_devices();
char* read_binary_file(const std::string &xclbin_file_name, unsigned &nb);

#endif
