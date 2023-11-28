#include <systemc>
#include <vector>
#include <iostream>
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_fixed.h"
using namespace std;
using namespace sc_dt;
class AESL_RUNTIME_BC {
  public:
    AESL_RUNTIME_BC(const char* name) {
      file_token.open( name);
      if (!file_token.good()) {
        cout << "Failed to open tv file " << name << endl;
        exit (1);
      }
      file_token >> mName;//[[[runtime]]]
    }
    ~AESL_RUNTIME_BC() {
      file_token.close();
    }
    int read_size () {
      int size = 0;
      file_token >> mName;//[[transaction]]
      file_token >> mName;//transaction number
      file_token >> mName;//pop_size
      size = atoi(mName.c_str());
      file_token >> mName;//[[/transaction]]
      return size;
    }
  public:
    fstream file_token;
    string mName;
};
extern "C" void hardware_encoding(int*, int, int, int, int);
extern "C" void apatb_hardware_encoding_hw(volatile void * __xlx_apatb_param_s1, volatile void * __xlx_apatb_param_output, volatile void * __xlx_apatb_param_lzw_size, volatile void * __xlx_apatb_param_input_size) {
  // Collect __xlx_s1_output_lzw_size_input_size__tmp_vec
  vector<sc_bv<32> >__xlx_s1_output_lzw_size_input_size__tmp_vec;
  for (int j = 0, e = 1; j != e; ++j) {
    __xlx_s1_output_lzw_size_input_size__tmp_vec.push_back(((int*)__xlx_apatb_param_s1)[j]);
  }
  int __xlx_size_param_s1 = 1;
  int __xlx_offset_param_s1 = 0;
  int __xlx_offset_byte_param_s1 = 0*4;
  for (int j = 0, e = 1; j != e; ++j) {
    __xlx_s1_output_lzw_size_input_size__tmp_vec.push_back(((int*)__xlx_apatb_param_output)[j]);
  }
  int __xlx_size_param_output = 1;
  int __xlx_offset_param_output = 1;
  int __xlx_offset_byte_param_output = 1*4;
  for (int j = 0, e = 1; j != e; ++j) {
    __xlx_s1_output_lzw_size_input_size__tmp_vec.push_back(((int*)__xlx_apatb_param_lzw_size)[j]);
  }
  int __xlx_size_param_lzw_size = 1;
  int __xlx_offset_param_lzw_size = 2;
  int __xlx_offset_byte_param_lzw_size = 2*4;
  for (int j = 0, e = 1; j != e; ++j) {
    __xlx_s1_output_lzw_size_input_size__tmp_vec.push_back(((int*)__xlx_apatb_param_input_size)[j]);
  }
  int __xlx_size_param_input_size = 1;
  int __xlx_offset_param_input_size = 3;
  int __xlx_offset_byte_param_input_size = 3*4;
  int* __xlx_s1_output_lzw_size_input_size__input_buffer= new int[__xlx_s1_output_lzw_size_input_size__tmp_vec.size()];
  for (int i = 0; i < __xlx_s1_output_lzw_size_input_size__tmp_vec.size(); ++i) {
    __xlx_s1_output_lzw_size_input_size__input_buffer[i] = __xlx_s1_output_lzw_size_input_size__tmp_vec[i].range(31, 0).to_uint64();
  }
  // DUT call
  hardware_encoding(__xlx_s1_output_lzw_size_input_size__input_buffer, __xlx_offset_byte_param_s1, __xlx_offset_byte_param_output, __xlx_offset_byte_param_lzw_size, __xlx_offset_byte_param_input_size);
// print __xlx_apatb_param_s1
  sc_bv<32>*__xlx_s1_output_buffer = new sc_bv<32>[__xlx_size_param_s1];
  for (int i = 0; i < __xlx_size_param_s1; ++i) {
    __xlx_s1_output_buffer[i] = __xlx_s1_output_lzw_size_input_size__input_buffer[i+__xlx_offset_param_s1];
  }
  for (int i = 0; i < __xlx_size_param_s1; ++i) {
    ((int*)__xlx_apatb_param_s1)[i] = __xlx_s1_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_output
  sc_bv<32>*__xlx_output_output_buffer = new sc_bv<32>[__xlx_size_param_output];
  for (int i = 0; i < __xlx_size_param_output; ++i) {
    __xlx_output_output_buffer[i] = __xlx_s1_output_lzw_size_input_size__input_buffer[i+__xlx_offset_param_output];
  }
  for (int i = 0; i < __xlx_size_param_output; ++i) {
    ((int*)__xlx_apatb_param_output)[i] = __xlx_output_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_lzw_size
  sc_bv<32>*__xlx_lzw_size_output_buffer = new sc_bv<32>[__xlx_size_param_lzw_size];
  for (int i = 0; i < __xlx_size_param_lzw_size; ++i) {
    __xlx_lzw_size_output_buffer[i] = __xlx_s1_output_lzw_size_input_size__input_buffer[i+__xlx_offset_param_lzw_size];
  }
  for (int i = 0; i < __xlx_size_param_lzw_size; ++i) {
    ((int*)__xlx_apatb_param_lzw_size)[i] = __xlx_lzw_size_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_input_size
  sc_bv<32>*__xlx_input_size_output_buffer = new sc_bv<32>[__xlx_size_param_input_size];
  for (int i = 0; i < __xlx_size_param_input_size; ++i) {
    __xlx_input_size_output_buffer[i] = __xlx_s1_output_lzw_size_input_size__input_buffer[i+__xlx_offset_param_input_size];
  }
  for (int i = 0; i < __xlx_size_param_input_size; ++i) {
    ((int*)__xlx_apatb_param_input_size)[i] = __xlx_input_size_output_buffer[i].to_uint64();
  }
}
