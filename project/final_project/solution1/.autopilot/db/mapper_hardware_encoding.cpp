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
extern "C" void hardware_encoding(char*, int, int, volatile void *, int);
extern "C" void apatb_hardware_encoding_hw(volatile void * __xlx_apatb_param_s1, volatile void * __xlx_apatb_param_output, volatile void * __xlx_apatb_param_size, int __xlx_apatb_param_len) {
  // Collect __xlx_s1_output__tmp_vec
  vector<sc_bv<8> >__xlx_s1_output__tmp_vec;
  for (int j = 0, e = 1; j != e; ++j) {
    __xlx_s1_output__tmp_vec.push_back(((char*)__xlx_apatb_param_s1)[j]);
  }
  int __xlx_size_param_s1 = 1;
  int __xlx_offset_param_s1 = 0;
  int __xlx_offset_byte_param_s1 = 0*1;
  for (int j = 0, e = 1; j != e; ++j) {
    __xlx_s1_output__tmp_vec.push_back(((char*)__xlx_apatb_param_output)[j]);
  }
  int __xlx_size_param_output = 1;
  int __xlx_offset_param_output = 1;
  int __xlx_offset_byte_param_output = 1*1;
  char* __xlx_s1_output__input_buffer= new char[__xlx_s1_output__tmp_vec.size()];
  for (int i = 0; i < __xlx_s1_output__tmp_vec.size(); ++i) {
    __xlx_s1_output__input_buffer[i] = __xlx_s1_output__tmp_vec[i].range(7, 0).to_uint64();
  }
  // DUT call
  hardware_encoding(__xlx_s1_output__input_buffer, __xlx_offset_byte_param_s1, __xlx_offset_byte_param_output, __xlx_apatb_param_size, __xlx_apatb_param_len);
// print __xlx_apatb_param_s1
  sc_bv<8>*__xlx_s1_output_buffer = new sc_bv<8>[__xlx_size_param_s1];
  for (int i = 0; i < __xlx_size_param_s1; ++i) {
    __xlx_s1_output_buffer[i] = __xlx_s1_output__input_buffer[i+__xlx_offset_param_s1];
  }
  for (int i = 0; i < __xlx_size_param_s1; ++i) {
    ((char*)__xlx_apatb_param_s1)[i] = __xlx_s1_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_output
  sc_bv<8>*__xlx_output_output_buffer = new sc_bv<8>[__xlx_size_param_output];
  for (int i = 0; i < __xlx_size_param_output; ++i) {
    __xlx_output_output_buffer[i] = __xlx_s1_output__input_buffer[i+__xlx_offset_param_output];
  }
  for (int i = 0; i < __xlx_size_param_output; ++i) {
    ((char*)__xlx_apatb_param_output)[i] = __xlx_output_output_buffer[i].to_uint64();
  }
}
