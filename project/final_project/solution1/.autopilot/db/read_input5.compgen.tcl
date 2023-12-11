# This script segment is generated automatically by AutoPilot

set id 1
set name hardware_encoding_mac_muladd_8ns_8ns_8ns_15_4_1
set corename simcore_mac
set op mac
set stage_num 4
set max_latency -1
set registered_input 1
set clk_width 1
set clk_signed 0
set reset_width 1
set reset_signed 0
set in0_width 8
set in0_signed 0
set in1_width 8
set in1_signed 0
set in2_width 8
set in2_signed 0
set ce_width 1
set ce_signed 0
set out_width 15
set exp i0*i1+i2
set arg_lists {i0 {8 0 +} i1 {8 0 +} m {15 0 +} i2 {8 0 +} p {15 0 +} c_reg {1} rnd {0} acc {0} }
set TrueReset 0
if {${::AESL::PGuard_simmodel_gen}} {
if {[info proc ap_gen_simcore_mac] == "ap_gen_simcore_mac"} {
eval "ap_gen_simcore_mac { \
    id ${id} \
    name ${name} \
    corename ${corename} \
    op ${op} \
    reset_level 1 \
    sync_rst true \
    true_reset ${TrueReset} \
    stage_num ${stage_num} \
    max_latency ${max_latency} \
    registered_input ${registered_input} \
    clk_width ${clk_width} \
    clk_signed ${clk_signed} \
    reset_width ${reset_width} \
    reset_signed ${reset_signed} \
    in0_width ${in0_width} \
    in0_signed ${in0_signed} \
    in1_width ${in1_width} \
    in1_signed ${in1_signed} \
    in2_width ${in2_width} \
    in2_signed ${in2_signed} \
    ce_width ${ce_width} \
    ce_signed ${ce_signed} \
    out_width ${out_width} \
    exp ${exp} \
    arg_lists {${arg_lists}} \
}"
} else {
puts "@W \[IMPL-100\] Cannot find ap_gen_simcore_mac, check your AutoPilot builtin lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler ${name}
}


set op mac
set corename DSP48
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_dsp48] == "::AESL_LIB_VIRTEX::xil_gen_dsp48"} {
eval "::AESL_LIB_VIRTEX::xil_gen_dsp48 { \
    id ${id} \
    name ${name} \
    corename ${corename} \
    op ${op} \
    reset_level 1 \
    sync_rst true \
    true_reset ${TrueReset} \
    stage_num ${stage_num} \
    max_latency ${max_latency} \
    registered_input ${registered_input} \
    clk_width ${clk_width} \
    clk_signed ${clk_signed} \
    reset_width ${reset_width} \
    reset_signed ${reset_signed} \
    in0_width ${in0_width} \
    in0_signed ${in0_signed} \
    in1_width ${in1_width} \
    in1_signed ${in1_signed} \
    in2_width ${in2_width} \
    in2_signed ${in2_signed} \
    ce_width ${ce_width} \
    ce_signed ${ce_signed} \
    out_width ${out_width} \
    exp ${exp} \
    arg_lists {${arg_lists}} \
}"
} else {
puts "@W \[IMPL-101\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_dsp48, check your platform lib"
}
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 3 \
    name HP1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_HP1 \
    op interface \
    ports { m_axi_HP1_AWVALID { O 1 bit } m_axi_HP1_AWREADY { I 1 bit } m_axi_HP1_AWADDR { O 64 vector } m_axi_HP1_AWID { O 1 vector } m_axi_HP1_AWLEN { O 32 vector } m_axi_HP1_AWSIZE { O 3 vector } m_axi_HP1_AWBURST { O 2 vector } m_axi_HP1_AWLOCK { O 2 vector } m_axi_HP1_AWCACHE { O 4 vector } m_axi_HP1_AWPROT { O 3 vector } m_axi_HP1_AWQOS { O 4 vector } m_axi_HP1_AWREGION { O 4 vector } m_axi_HP1_AWUSER { O 1 vector } m_axi_HP1_WVALID { O 1 bit } m_axi_HP1_WREADY { I 1 bit } m_axi_HP1_WDATA { O 16 vector } m_axi_HP1_WSTRB { O 2 vector } m_axi_HP1_WLAST { O 1 bit } m_axi_HP1_WID { O 1 vector } m_axi_HP1_WUSER { O 1 vector } m_axi_HP1_ARVALID { O 1 bit } m_axi_HP1_ARREADY { I 1 bit } m_axi_HP1_ARADDR { O 64 vector } m_axi_HP1_ARID { O 1 vector } m_axi_HP1_ARLEN { O 32 vector } m_axi_HP1_ARSIZE { O 3 vector } m_axi_HP1_ARBURST { O 2 vector } m_axi_HP1_ARLOCK { O 2 vector } m_axi_HP1_ARCACHE { O 4 vector } m_axi_HP1_ARPROT { O 3 vector } m_axi_HP1_ARQOS { O 4 vector } m_axi_HP1_ARREGION { O 4 vector } m_axi_HP1_ARUSER { O 1 vector } m_axi_HP1_RVALID { I 1 bit } m_axi_HP1_RREADY { O 1 bit } m_axi_HP1_RDATA { I 16 vector } m_axi_HP1_RLAST { I 1 bit } m_axi_HP1_RID { I 1 vector } m_axi_HP1_RUSER { I 1 vector } m_axi_HP1_RRESP { I 2 vector } m_axi_HP1_BVALID { I 1 bit } m_axi_HP1_BREADY { O 1 bit } m_axi_HP1_BRESP { I 2 vector } m_axi_HP1_BID { I 1 vector } m_axi_HP1_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 4 \
    name input_r \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_input_r \
    op interface \
    ports { input_r_din { O 8 vector } input_r_full_n { I 1 bit } input_r_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 5 \
    name s1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_s1 \
    op interface \
    ports { s1 { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
    name output_r \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_output_r \
    op interface \
    ports { output_r { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 7 \
    name output_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_output_out \
    op interface \
    ports { output_out_din { O 64 vector } output_out_full_n { I 1 bit } output_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_done { O 1 bit } ap_idle { O 1 bit } ap_continue { I 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


