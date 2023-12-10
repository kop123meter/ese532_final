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
    id 31 \
    name compress_size_0 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compress_size_0 \
    op interface \
    ports { compress_size_0_dout { I 32 vector } compress_size_0_empty_n { I 1 bit } compress_size_0_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 32 \
    name lzw_size \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_lzw_size \
    op interface \
    ports { lzw_size_dout { I 64 vector } lzw_size_empty_n { I 1 bit } lzw_size_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 33 \
    name HP0 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_HP0 \
    op interface \
    ports { m_axi_HP0_AWVALID { O 1 bit } m_axi_HP0_AWREADY { I 1 bit } m_axi_HP0_AWADDR { O 64 vector } m_axi_HP0_AWID { O 1 vector } m_axi_HP0_AWLEN { O 32 vector } m_axi_HP0_AWSIZE { O 3 vector } m_axi_HP0_AWBURST { O 2 vector } m_axi_HP0_AWLOCK { O 2 vector } m_axi_HP0_AWCACHE { O 4 vector } m_axi_HP0_AWPROT { O 3 vector } m_axi_HP0_AWQOS { O 4 vector } m_axi_HP0_AWREGION { O 4 vector } m_axi_HP0_AWUSER { O 1 vector } m_axi_HP0_WVALID { O 1 bit } m_axi_HP0_WREADY { I 1 bit } m_axi_HP0_WDATA { O 32 vector } m_axi_HP0_WSTRB { O 4 vector } m_axi_HP0_WLAST { O 1 bit } m_axi_HP0_WID { O 1 vector } m_axi_HP0_WUSER { O 1 vector } m_axi_HP0_ARVALID { O 1 bit } m_axi_HP0_ARREADY { I 1 bit } m_axi_HP0_ARADDR { O 64 vector } m_axi_HP0_ARID { O 1 vector } m_axi_HP0_ARLEN { O 32 vector } m_axi_HP0_ARSIZE { O 3 vector } m_axi_HP0_ARBURST { O 2 vector } m_axi_HP0_ARLOCK { O 2 vector } m_axi_HP0_ARCACHE { O 4 vector } m_axi_HP0_ARPROT { O 3 vector } m_axi_HP0_ARQOS { O 4 vector } m_axi_HP0_ARREGION { O 4 vector } m_axi_HP0_ARUSER { O 1 vector } m_axi_HP0_RVALID { I 1 bit } m_axi_HP0_RREADY { O 1 bit } m_axi_HP0_RDATA { I 32 vector } m_axi_HP0_RLAST { I 1 bit } m_axi_HP0_RID { I 1 vector } m_axi_HP0_RUSER { I 1 vector } m_axi_HP0_RRESP { I 2 vector } m_axi_HP0_BVALID { I 1 bit } m_axi_HP0_BREADY { O 1 bit } m_axi_HP0_BRESP { I 2 vector } m_axi_HP0_BID { I 1 vector } m_axi_HP0_BUSER { I 1 vector } } \
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
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } ap_continue { I 1 bit } } \
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


