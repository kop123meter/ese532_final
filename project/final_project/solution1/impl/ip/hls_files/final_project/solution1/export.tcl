############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project final_project
set_top hardware_encoding
add_files Server/LZW_new.cpp
add_files Server/LZW_new.h
add_files Server/stopwatch.h
add_files -tb Server/Testbench.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vitis
set_part {xczu3eg-sbva484-1-i}
create_clock -period 150MHz -name default
config_interface -m_axi_alignment_byte_size 64 -m_axi_latency 64 -m_axi_max_widen_bitwidth 512 -m_axi_offset slave
config_rtl -register_reset_num 3
config_export -format xo -output /mnt/castor/seas_home/l/lize1/ese532_final/project/hardware_encoding.xo -rtl verilog
source "./final_project/solution1/directives.tcl"
export_design -rtl verilog -format xo -output /mnt/castor/seas_home/l/lize1/ese532_final/project/hardware_encoding.xo
