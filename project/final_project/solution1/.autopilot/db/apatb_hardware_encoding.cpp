#include <systemc>
#include <iostream>
#include <cstdlib>
#include <cstddef>
#include <stdint.h>
#include "SysCFileHandler.h"
#include "ap_int.h"
#include "ap_fixed.h"
#include <complex>
#include <stdbool.h>
#include "autopilot_cbe.h"
#include "hls_stream.h"
#include "hls_half.h"
#include "hls_signal_handler.h"

using namespace std;
using namespace sc_core;
using namespace sc_dt;

// wrapc file define:
#define AUTOTB_TVIN_gmem "../tv/cdatafile/c.hardware_encoding.autotvin_gmem.dat"
#define AUTOTB_TVOUT_gmem "../tv/cdatafile/c.hardware_encoding.autotvout_gmem.dat"
// wrapc file define:
#define AUTOTB_TVIN_s1 "../tv/cdatafile/c.hardware_encoding.autotvin_s1.dat"
#define AUTOTB_TVOUT_s1 "../tv/cdatafile/c.hardware_encoding.autotvout_s1.dat"
// wrapc file define:
#define AUTOTB_TVIN_output "../tv/cdatafile/c.hardware_encoding.autotvin_output_r.dat"
#define AUTOTB_TVOUT_output "../tv/cdatafile/c.hardware_encoding.autotvout_output_r.dat"
// wrapc file define:
#define AUTOTB_TVIN_lzw_size "../tv/cdatafile/c.hardware_encoding.autotvin_lzw_size.dat"
#define AUTOTB_TVOUT_lzw_size "../tv/cdatafile/c.hardware_encoding.autotvout_lzw_size.dat"
// wrapc file define:
#define AUTOTB_TVIN_input_size "../tv/cdatafile/c.hardware_encoding.autotvin_input_size.dat"
#define AUTOTB_TVOUT_input_size "../tv/cdatafile/c.hardware_encoding.autotvout_input_size.dat"

#define INTER_TCL "../tv/cdatafile/ref.tcl"

// tvout file define:
#define AUTOTB_TVOUT_PC_gmem "../tv/rtldatafile/rtl.hardware_encoding.autotvout_gmem.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_s1 "../tv/rtldatafile/rtl.hardware_encoding.autotvout_s1.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_output "../tv/rtldatafile/rtl.hardware_encoding.autotvout_output_r.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_lzw_size "../tv/rtldatafile/rtl.hardware_encoding.autotvout_lzw_size.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_input_size "../tv/rtldatafile/rtl.hardware_encoding.autotvout_input_size.dat"

class INTER_TCL_FILE {
  public:
INTER_TCL_FILE(const char* name) {
  mName = name; 
  gmem_depth = 0;
  s1_depth = 0;
  output_depth = 0;
  lzw_size_depth = 0;
  input_size_depth = 0;
  trans_num =0;
}
~INTER_TCL_FILE() {
  mFile.open(mName);
  if (!mFile.good()) {
    cout << "Failed to open file ref.tcl" << endl;
    exit (1); 
  }
  string total_list = get_depth_list();
  mFile << "set depth_list {\n";
  mFile << total_list;
  mFile << "}\n";
  mFile << "set trans_num "<<trans_num<<endl;
  mFile.close();
}
string get_depth_list () {
  stringstream total_list;
  total_list << "{gmem " << gmem_depth << "}\n";
  total_list << "{s1 " << s1_depth << "}\n";
  total_list << "{output_r " << output_depth << "}\n";
  total_list << "{lzw_size " << lzw_size_depth << "}\n";
  total_list << "{input_size " << input_size_depth << "}\n";
  return total_list.str();
}
void set_num (int num , int* class_num) {
  (*class_num) = (*class_num) > num ? (*class_num) : num;
}
void set_string(std::string list, std::string* class_list) {
  (*class_list) = list;
}
  public:
    int gmem_depth;
    int s1_depth;
    int output_depth;
    int lzw_size_depth;
    int input_size_depth;
    int trans_num;
  private:
    ofstream mFile;
    const char* mName;
};

static void RTLOutputCheckAndReplacement(std::string &AESL_token, std::string PortName) {
  bool no_x = false;
  bool err = false;

  no_x = false;
  // search and replace 'X' with '0' from the 3rd char of token
  while (!no_x) {
    size_t x_found = AESL_token.find('X', 0);
    if (x_found != string::npos) {
      if (!err) { 
        cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'X' on port" 
             << PortName << ", possible cause: There are uninitialized variables in the C design."
             << endl; 
        err = true;
      }
      AESL_token.replace(x_found, 1, "0");
    } else
      no_x = true;
  }
  no_x = false;
  // search and replace 'x' with '0' from the 3rd char of token
  while (!no_x) {
    size_t x_found = AESL_token.find('x', 2);
    if (x_found != string::npos) {
      if (!err) { 
        cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'x' on port" 
             << PortName << ", possible cause: There are uninitialized variables in the C design."
             << endl; 
        err = true;
      }
      AESL_token.replace(x_found, 1, "0");
    } else
      no_x = true;
  }
}
extern "C" void hardware_encoding_hw_stub_wrapper(volatile void *, volatile void *, volatile void *, volatile void *);

extern "C" void apatb_hardware_encoding_hw(volatile void * __xlx_apatb_param_s1, volatile void * __xlx_apatb_param_output, volatile void * __xlx_apatb_param_lzw_size, volatile void * __xlx_apatb_param_input_size) {
  refine_signal_handler();
  fstream wrapc_switch_file_token;
  wrapc_switch_file_token.open(".hls_cosim_wrapc_switch.log");
  int AESL_i;
  if (wrapc_switch_file_token.good())
  {

    CodeState = ENTER_WRAPC_PC;
    static unsigned AESL_transaction_pc = 0;
    string AESL_token;
    string AESL_num;{
      static ifstream rtl_tv_out_file;
      if (!rtl_tv_out_file.is_open()) {
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_gmem);
        if (rtl_tv_out_file.good()) {
          rtl_tv_out_file >> AESL_token;
          if (AESL_token != "[[[runtime]]]")
            exit(1);
        }
      }
  
      if (rtl_tv_out_file.good()) {
        rtl_tv_out_file >> AESL_token; 
        rtl_tv_out_file >> AESL_num;  // transaction number
        if (AESL_token != "[[transaction]]") {
          cerr << "Unexpected token: " << AESL_token << endl;
          exit(1);
        }
        if (atoi(AESL_num.c_str()) == AESL_transaction_pc) {
          std::vector<sc_bv<32> > gmem_pc_buffer(4);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "gmem");
  
            // push token into output port buffer
            if (AESL_token != "") {
              gmem_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {{
            int i = 0;
            for (int j = 0, e = 1; j < e; j += 1, ++i) {
            ((int*)__xlx_apatb_param_s1)[j] = gmem_pc_buffer[i].to_int64();
          }
            for (int j = 0, e = 1; j < e; j += 1, ++i) {
            ((int*)__xlx_apatb_param_output)[j] = gmem_pc_buffer[i].to_int64();
          }
            for (int j = 0, e = 1; j < e; j += 1, ++i) {
            ((int*)__xlx_apatb_param_lzw_size)[j] = gmem_pc_buffer[i].to_int64();
          }
            for (int j = 0, e = 1; j < e; j += 1, ++i) {
            ((int*)__xlx_apatb_param_input_size)[j] = gmem_pc_buffer[i].to_int64();
          }}}
        } // end transaction
      } // end file is good
    } // end post check logic bolck
  
    AESL_transaction_pc++;
    return ;
  }
static unsigned AESL_transaction;
static AESL_FILE_HANDLER aesl_fh;
static INTER_TCL_FILE tcl_file(INTER_TCL);
std::vector<char> __xlx_sprintf_buffer(1024);
CodeState = ENTER_WRAPC;
//gmem
aesl_fh.touch(AUTOTB_TVIN_gmem);
aesl_fh.touch(AUTOTB_TVOUT_gmem);
//s1
aesl_fh.touch(AUTOTB_TVIN_s1);
aesl_fh.touch(AUTOTB_TVOUT_s1);
//output
aesl_fh.touch(AUTOTB_TVIN_output);
aesl_fh.touch(AUTOTB_TVOUT_output);
//lzw_size
aesl_fh.touch(AUTOTB_TVIN_lzw_size);
aesl_fh.touch(AUTOTB_TVOUT_lzw_size);
//input_size
aesl_fh.touch(AUTOTB_TVIN_input_size);
aesl_fh.touch(AUTOTB_TVOUT_input_size);
CodeState = DUMP_INPUTS;
unsigned __xlx_offset_byte_param_s1 = 0;
unsigned __xlx_offset_byte_param_output = 0;
unsigned __xlx_offset_byte_param_lzw_size = 0;
unsigned __xlx_offset_byte_param_input_size = 0;
// print gmem Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_gmem, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_s1 = 0*4;
  if (__xlx_apatb_param_s1) {
    for (int j = 0  - 0, e = 1 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_s1)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_gmem, __xlx_sprintf_buffer.data()); 
      }
  }
  __xlx_offset_byte_param_output = 1*4;
  if (__xlx_apatb_param_output) {
    for (int j = 0  - 0, e = 1 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_output)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_gmem, __xlx_sprintf_buffer.data()); 
      }
  }
  __xlx_offset_byte_param_lzw_size = 2*4;
  if (__xlx_apatb_param_lzw_size) {
    for (int j = 0  - 0, e = 1 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_lzw_size)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_gmem, __xlx_sprintf_buffer.data()); 
      }
  }
  __xlx_offset_byte_param_input_size = 3*4;
  if (__xlx_apatb_param_input_size) {
    for (int j = 0  - 0, e = 1 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_input_size)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_gmem, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(4, &tcl_file.gmem_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_gmem, __xlx_sprintf_buffer.data());
}
// print s1 Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_s1, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_s1;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_s1, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.s1_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_s1, __xlx_sprintf_buffer.data());
}
// print output Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_output, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_output;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_output, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.output_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_output, __xlx_sprintf_buffer.data());
}
// print lzw_size Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_lzw_size, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_lzw_size;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_lzw_size, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.lzw_size_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_lzw_size, __xlx_sprintf_buffer.data());
}
// print input_size Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_input_size, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_input_size;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_input_size, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.input_size_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_input_size, __xlx_sprintf_buffer.data());
}
CodeState = CALL_C_DUT;
hardware_encoding_hw_stub_wrapper(__xlx_apatb_param_s1, __xlx_apatb_param_output, __xlx_apatb_param_lzw_size, __xlx_apatb_param_input_size);
CodeState = DUMP_OUTPUTS;
// print gmem Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_gmem, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_s1 = 0*4;
  if (__xlx_apatb_param_s1) {
    for (int j = 0  - 0, e = 1 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_s1)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_gmem, __xlx_sprintf_buffer.data()); 
      }
  }
  __xlx_offset_byte_param_output = 1*4;
  if (__xlx_apatb_param_output) {
    for (int j = 0  - 0, e = 1 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_output)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_gmem, __xlx_sprintf_buffer.data()); 
      }
  }
  __xlx_offset_byte_param_lzw_size = 2*4;
  if (__xlx_apatb_param_lzw_size) {
    for (int j = 0  - 0, e = 1 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_lzw_size)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_gmem, __xlx_sprintf_buffer.data()); 
      }
  }
  __xlx_offset_byte_param_input_size = 3*4;
  if (__xlx_apatb_param_input_size) {
    for (int j = 0  - 0, e = 1 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_input_size)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_gmem, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(4, &tcl_file.gmem_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_gmem, __xlx_sprintf_buffer.data());
}
CodeState = DELETE_CHAR_BUFFERS;
AESL_transaction++;
tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
}
