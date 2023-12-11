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
    id 20 \
    name output_stream \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_output_stream \
    op interface \
    ports { output_stream_dout { I 16 vector } output_stream_empty_n { I 1 bit } output_stream_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 21 \
    name HP3 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_HP3 \
    op interface \
    ports { m_axi_HP3_AWVALID { O 1 bit } m_axi_HP3_AWREADY { I 1 bit } m_axi_HP3_AWADDR { O 64 vector } m_axi_HP3_AWID { O 1 vector } m_axi_HP3_AWLEN { O 32 vector } m_axi_HP3_AWSIZE { O 3 vector } m_axi_HP3_AWBURST { O 2 vector } m_axi_HP3_AWLOCK { O 2 vector } m_axi_HP3_AWCACHE { O 4 vector } m_axi_HP3_AWPROT { O 3 vector } m_axi_HP3_AWQOS { O 4 vector } m_axi_HP3_AWREGION { O 4 vector } m_axi_HP3_AWUSER { O 1 vector } m_axi_HP3_WVALID { O 1 bit } m_axi_HP3_WREADY { I 1 bit } m_axi_HP3_WDATA { O 16 vector } m_axi_HP3_WSTRB { O 2 vector } m_axi_HP3_WLAST { O 1 bit } m_axi_HP3_WID { O 1 vector } m_axi_HP3_WUSER { O 1 vector } m_axi_HP3_ARVALID { O 1 bit } m_axi_HP3_ARREADY { I 1 bit } m_axi_HP3_ARADDR { O 64 vector } m_axi_HP3_ARID { O 1 vector } m_axi_HP3_ARLEN { O 32 vector } m_axi_HP3_ARSIZE { O 3 vector } m_axi_HP3_ARBURST { O 2 vector } m_axi_HP3_ARLOCK { O 2 vector } m_axi_HP3_ARCACHE { O 4 vector } m_axi_HP3_ARPROT { O 3 vector } m_axi_HP3_ARQOS { O 4 vector } m_axi_HP3_ARREGION { O 4 vector } m_axi_HP3_ARUSER { O 1 vector } m_axi_HP3_RVALID { I 1 bit } m_axi_HP3_RREADY { O 1 bit } m_axi_HP3_RDATA { I 16 vector } m_axi_HP3_RLAST { I 1 bit } m_axi_HP3_RID { I 1 vector } m_axi_HP3_RUSER { I 1 vector } m_axi_HP3_RRESP { I 2 vector } m_axi_HP3_BVALID { I 1 bit } m_axi_HP3_BREADY { O 1 bit } m_axi_HP3_BRESP { I 2 vector } m_axi_HP3_BID { I 1 vector } m_axi_HP3_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 22 \
    name output_r \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_output_r \
    op interface \
    ports { output_r_dout { I 64 vector } output_r_empty_n { I 1 bit } output_r_read { O 1 bit } } \
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


