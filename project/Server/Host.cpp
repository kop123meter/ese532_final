#define CL_HPP_CL_1_2_DEFAULT_BUILD
#define CL_HPP_TARGET_OPENCL_VERSION 120
#define CL_HPP_MINIMUM_OPENCL_VERSION 120
#define CL_HPP_ENABLE_PROGRAM_CONSTRUCTION_FROM_ARRAY_COMPATIBILITY 1
#define CL_USE_DEPRECATED_OPENCL_1_2_APIS


//#include "EventTimer.h"
#include <CL/cl2.hpp>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <unistd.h>
#include <vector>
#include "encoder.h"
#include "sha256.h"
#include "LZW_new.h"



int main(int argc, char *argv[])
{
   EventTimer timer1, timer2;
   timer1.add("Main program");


   // ------------------------------------------------------------------------------------
   // Step 1: Initialize the OpenCL environment
    // ------------------------------------------------------------------------------------
   timer2.add("OpenCL Initialization");
   cl_int err;
   std::string binaryFile = argv[1];
   unsigned fileBufSize;
   std::vector<cl::Device> devices = get_xilinx_devices();
   devices.resize(1);
   cl::Device device = devices[0];
   cl::Context context(device, NULL, NULL, NULL, &err);
   char *fileBuf = read_binary_file(binaryFile, fileBufSize);
   cl::Program::Binaries bins{{fileBuf, fileBufSize}};
   cl::Program program(context, devices, bins, NULL, &err);
   cl::CommandQueue q(context, device, CL_QUEUE_PROFILING_ENABLE | CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE, &err);
   cl::Kernel krnl_filter(program, "Filter_HW", &err);
   // ------------------------------------------------------------------------------------
   // Step 2: Create buffers and initialize test values
   // ------------------------------------------------------------------------------------
   timer2.add("Allocate contiguous OpenCL buffers");


   cl::Buffer in_buf;
   cl::Buffer out_buf;


   in_buf = cl::Buffer(context, CL_MEM_READ_ONLY, SCALED_FRAME_SIZE, NULL, &err);
   out_buf = cl::Buffer(context, CL_MEM_READ_ONLY, OUTPUT_FRAME_SIZE, NULL, &err);


   unsigned char *in;
  // unsigned char *Output;


   in = (unsigned char*)q.enqueueMapBuffer(in_buf, CL_TRUE, CL_MAP_WRITE, 0, SCALED_FRAME_SIZE);
   //Output = (unsigned char*)q.enqueueMapBuffer(out_buf, CL_TRUE, CL_MAP_WRITE, 0, sizeof(unsigned char)*OUTPUT_FRAME_HEIGHT*OUTPUT_FRAME_WIDTH);
  
   timer2.add("Populating buffer inputs");


   // ------------------------------------------------------------------------------------
   // Step 3: Run the kernel
   // ------------------------------------------------------------------------------------
   timer2.add("Running kernel");
   unsigned char *Input_data = (unsigned char *)malloc(FRAMES * INPUT_FRAME_SIZE);
   unsigned char *differ_output = (unsigned char *)malloc(OUTPUT_FRAME_SIZE);
   unsigned char *output_hw = (unsigned char *)malloc(MAX_OUTPUT_SIZE);
   Load_data(Input_data);
  




   std::vector<cl::Event> read_events;
   int Size;
   for(int Frame = 0; Frame < FRAMES ;Frame++){
       Scale_SW(Input_data + Frame * INPUT_FRAME_SIZE, in);
      


      
       // FPGA for Filter
       std::vector<cl::Event> exec_events, write_events;
       cl::Event write_ev;
       cl::Event exec_ev;
       cl::Event read_ev;
       krnl_filter.setArg(0,in_buf);
       krnl_filter.setArg(1,out_buf);
        if(Frame == 0)
       {
           q.enqueueMigrateMemObjects({in_buf}, 0 /* 0 means from host*/, NULL, &write_ev);
       }
       else
       {
           q.enqueueMigrateMemObjects({in_buf}, 0 /* 0 means from host*/, &read_events, &write_ev);
       }
       write_events.push_back(write_ev);
       q.enqueueTask(krnl_filter, &write_events, &exec_ev);
       exec_events.push_back(exec_ev);
       q.enqueueMigrateMemObjects({out_buf}, CL_MIGRATE_MEM_OBJECT_HOST, &exec_events, &read_ev);
       read_events.push_back(read_ev);
      
       unsigned char *differ_input =  (unsigned char*)q.enqueueMapBuffer(out_buf, CL_TRUE, CL_MAP_WRITE, 0, OUTPUT_FRAME_SIZE);

       //Differ
       Differentiate_SW(differ_input,differ_output);


       //Compress
       Size = Compress_SW(differ_output,output_hw);
   }
   q.finish();
   timer2.add("Writing output to output_fpga.bin");


   Check_data(output_hw, Size);



   delete[] fileBuf;
  


   timer2.finish();
   std::cout << "--------------- Key execution times ---------------"
   << std::endl;
   timer2.print();


   timer1.finish();
   std::cout << "--------------- Total time ---------------"
   << std::endl;
   timer1.print();
   free(Input_data);
   free(differ_output);
   free(output_hw);
   return 0;
}

