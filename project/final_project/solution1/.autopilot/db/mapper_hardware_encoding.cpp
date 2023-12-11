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
extern "C" void hardware_encoding(short*, short*, int, int);
extern "C" void apatb_hardware_encoding_hw(volatile void * __xlx_apatb_param_s1, volatile void * __xlx_apatb_param_output) {
  // Collect __xlx_s1__tmp_vec
  vector<sc_bv<16> >__xlx_s1__tmp_vec;
  for (int j = 0, e = 16388; j != e; ++j) {
    __xlx_s1__tmp_vec.push_back(((short*)__xlx_apatb_param_s1)[j]);
  }
  int __xlx_size_param_s1 = 16388;
  int __xlx_offset_param_s1 = 0;
  int __xlx_offset_byte_param_s1 = 0*2;
  short* __xlx_s1__input_buffer= new short[__xlx_s1__tmp_vec.size()];
  for (int i = 0; i < __xlx_s1__tmp_vec.size(); ++i) {
    __xlx_s1__input_buffer[i] = __xlx_s1__tmp_vec[i].range(15, 0).to_uint64();
  }
  // Collect __xlx_output__tmp_vec
  vector<sc_bv<16> >__xlx_output__tmp_vec;
  for (int j = 0, e = 32772; j != e; ++j) {
    __xlx_output__tmp_vec.push_back(((short*)__xlx_apatb_param_output)[j]);
  }
  int __xlx_size_param_output = 32772;
  int __xlx_offset_param_output = 0;
  int __xlx_offset_byte_param_output = 0*2;
  short* __xlx_output__input_buffer= new short[__xlx_output__tmp_vec.size()];
  for (int i = 0; i < __xlx_output__tmp_vec.size(); ++i) {
    __xlx_output__input_buffer[i] = __xlx_output__tmp_vec[i].range(15, 0).to_uint64();
  }
  // DUT call
  hardware_encoding(__xlx_s1__input_buffer, __xlx_output__input_buffer, __xlx_offset_byte_param_s1, __xlx_offset_byte_param_output);
// print __xlx_apatb_param_s1
  sc_bv<16>*__xlx_s1_output_buffer = new sc_bv<16>[__xlx_size_param_s1];
  for (int i = 0; i < __xlx_size_param_s1; ++i) {
    __xlx_s1_output_buffer[i] = __xlx_s1__input_buffer[i+__xlx_offset_param_s1];
  }
  for (int i = 0; i < __xlx_size_param_s1; ++i) {
    ((short*)__xlx_apatb_param_s1)[i] = __xlx_s1_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_output
  sc_bv<16>*__xlx_output_output_buffer = new sc_bv<16>[__xlx_size_param_output];
  for (int i = 0; i < __xlx_size_param_output; ++i) {
    __xlx_output_output_buffer[i] = __xlx_output__input_buffer[i+__xlx_offset_param_output];
  }
  for (int i = 0; i < __xlx_size_param_output; ++i) {
    ((short*)__xlx_apatb_param_output)[i] = __xlx_output_output_buffer[i].to_uint64();
  }
}
