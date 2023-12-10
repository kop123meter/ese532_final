# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 9 \
    name HP1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_HP1 \
    op interface \
    ports { m_axi_HP1_AWVALID { O 1 bit } m_axi_HP1_AWREADY { I 1 bit } m_axi_HP1_AWADDR { O 64 vector } m_axi_HP1_AWID { O 1 vector } m_axi_HP1_AWLEN { O 32 vector } m_axi_HP1_AWSIZE { O 3 vector } m_axi_HP1_AWBURST { O 2 vector } m_axi_HP1_AWLOCK { O 2 vector } m_axi_HP1_AWCACHE { O 4 vector } m_axi_HP1_AWPROT { O 3 vector } m_axi_HP1_AWQOS { O 4 vector } m_axi_HP1_AWREGION { O 4 vector } m_axi_HP1_AWUSER { O 1 vector } m_axi_HP1_WVALID { O 1 bit } m_axi_HP1_WREADY { I 1 bit } m_axi_HP1_WDATA { O 32 vector } m_axi_HP1_WSTRB { O 4 vector } m_axi_HP1_WLAST { O 1 bit } m_axi_HP1_WID { O 1 vector } m_axi_HP1_WUSER { O 1 vector } m_axi_HP1_ARVALID { O 1 bit } m_axi_HP1_ARREADY { I 1 bit } m_axi_HP1_ARADDR { O 64 vector } m_axi_HP1_ARID { O 1 vector } m_axi_HP1_ARLEN { O 32 vector } m_axi_HP1_ARSIZE { O 3 vector } m_axi_HP1_ARBURST { O 2 vector } m_axi_HP1_ARLOCK { O 2 vector } m_axi_HP1_ARCACHE { O 4 vector } m_axi_HP1_ARPROT { O 3 vector } m_axi_HP1_ARQOS { O 4 vector } m_axi_HP1_ARREGION { O 4 vector } m_axi_HP1_ARUSER { O 1 vector } m_axi_HP1_RVALID { I 1 bit } m_axi_HP1_RREADY { O 1 bit } m_axi_HP1_RDATA { I 32 vector } m_axi_HP1_RLAST { I 1 bit } m_axi_HP1_RID { I 1 vector } m_axi_HP1_RUSER { I 1 vector } m_axi_HP1_RRESP { I 2 vector } m_axi_HP1_BVALID { I 1 bit } m_axi_HP1_BREADY { O 1 bit } m_axi_HP1_BRESP { I 2 vector } m_axi_HP1_BID { I 1 vector } m_axi_HP1_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10 \
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
    id 11 \
    name inputsize \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_inputsize \
    op interface \
    ports { inputsize_din { O 32 vector } inputsize_full_n { I 1 bit } inputsize_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 12 \
    name s1 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_s1 \
    op interface \
    ports { s1_dout { I 64 vector } s1_empty_n { I 1 bit } s1_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 13 \
    name input_size \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_input_size \
    op interface \
    ports { input_size_dout { I 64 vector } input_size_empty_n { I 1 bit } input_size_read { O 1 bit } } \
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


