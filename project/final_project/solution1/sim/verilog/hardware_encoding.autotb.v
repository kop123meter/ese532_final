// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
 `timescale 1ns/1ps


`define AUTOTB_DUT      hardware_encoding
`define AUTOTB_DUT_INST AESL_inst_hardware_encoding
`define AUTOTB_TOP      apatb_hardware_encoding_top
`define AUTOTB_LAT_RESULT_FILE "hardware_encoding.result.lat.rb"
`define AUTOTB_PER_RESULT_TRANS_FILE "hardware_encoding.performance.result.transaction.xml"
`define AUTOTB_TOP_INST AESL_inst_apatb_hardware_encoding_top
`define AUTOTB_MAX_ALLOW_LATENCY  15000000
`define AUTOTB_CLOCK_PERIOD_DIV2 3.33

`define AESL_DEPTH_HP1 1
`define AESL_DEPTH_HP3 1
`define AESL_DEPTH_s1 1
`define AESL_DEPTH_output_r 1
`define AUTOTB_TVIN_HP1  "../tv/cdatafile/c.hardware_encoding.autotvin_HP1.dat"
`define AUTOTB_TVIN_s1  "../tv/cdatafile/c.hardware_encoding.autotvin_s1.dat"
`define AUTOTB_TVIN_output_r  "../tv/cdatafile/c.hardware_encoding.autotvin_output_r.dat"
`define AUTOTB_TVIN_HP1_out_wrapc  "../tv/rtldatafile/rtl.hardware_encoding.autotvin_HP1.dat"
`define AUTOTB_TVIN_s1_out_wrapc  "../tv/rtldatafile/rtl.hardware_encoding.autotvin_s1.dat"
`define AUTOTB_TVIN_output_r_out_wrapc  "../tv/rtldatafile/rtl.hardware_encoding.autotvin_output_r.dat"
`define AUTOTB_TVOUT_HP3  "../tv/cdatafile/c.hardware_encoding.autotvout_HP3.dat"
`define AUTOTB_TVOUT_HP3_out_wrapc  "../tv/rtldatafile/rtl.hardware_encoding.autotvout_HP3.dat"
module `AUTOTB_TOP;

parameter AUTOTB_TRANSACTION_NUM = 1;
parameter PROGRESS_TIMEOUT = 10000000;
parameter LATENCY_ESTIMATION = -1;
parameter LENGTH_HP1 = 16388;
parameter LENGTH_HP3 = 32772;
parameter LENGTH_s1 = 1;
parameter LENGTH_output_r = 1;

task read_token;
    input integer fp;
    output reg [191 : 0] token;
    integer ret;
    begin
        token = "";
        ret = 0;
        ret = $fscanf(fp,"%s",token);
    end
endtask

reg AESL_clock;
reg rst;
reg dut_rst;
reg start;
reg ce;
reg tb_continue;
wire AESL_start;
wire AESL_reset;
wire AESL_ce;
wire AESL_ready;
wire AESL_idle;
wire AESL_continue;
wire AESL_done;
reg AESL_done_delay = 0;
reg AESL_done_delay2 = 0;
reg AESL_ready_delay = 0;
wire ready;
wire ready_wire;
wire [5 : 0] control_AWADDR;
wire  control_AWVALID;
wire  control_AWREADY;
wire  control_WVALID;
wire  control_WREADY;
wire [31 : 0] control_WDATA;
wire [3 : 0] control_WSTRB;
wire [5 : 0] control_ARADDR;
wire  control_ARVALID;
wire  control_ARREADY;
wire  control_RVALID;
wire  control_RREADY;
wire [31 : 0] control_RDATA;
wire [1 : 0] control_RRESP;
wire  control_BVALID;
wire  control_BREADY;
wire [1 : 0] control_BRESP;
wire  control_INTERRUPT;
wire  HP1_AWVALID;
wire  HP1_AWREADY;
wire [63 : 0] HP1_AWADDR;
wire [0 : 0] HP1_AWID;
wire [7 : 0] HP1_AWLEN;
wire [2 : 0] HP1_AWSIZE;
wire [1 : 0] HP1_AWBURST;
wire [1 : 0] HP1_AWLOCK;
wire [3 : 0] HP1_AWCACHE;
wire [2 : 0] HP1_AWPROT;
wire [3 : 0] HP1_AWQOS;
wire [3 : 0] HP1_AWREGION;
wire [0 : 0] HP1_AWUSER;
wire  HP1_WVALID;
wire  HP1_WREADY;
wire [31 : 0] HP1_WDATA;
wire [3 : 0] HP1_WSTRB;
wire  HP1_WLAST;
wire [0 : 0] HP1_WID;
wire [0 : 0] HP1_WUSER;
wire  HP1_ARVALID;
wire  HP1_ARREADY;
wire [63 : 0] HP1_ARADDR;
wire [0 : 0] HP1_ARID;
wire [7 : 0] HP1_ARLEN;
wire [2 : 0] HP1_ARSIZE;
wire [1 : 0] HP1_ARBURST;
wire [1 : 0] HP1_ARLOCK;
wire [3 : 0] HP1_ARCACHE;
wire [2 : 0] HP1_ARPROT;
wire [3 : 0] HP1_ARQOS;
wire [3 : 0] HP1_ARREGION;
wire [0 : 0] HP1_ARUSER;
wire  HP1_RVALID;
wire  HP1_RREADY;
wire [31 : 0] HP1_RDATA;
wire  HP1_RLAST;
wire [0 : 0] HP1_RID;
wire [0 : 0] HP1_RUSER;
wire [1 : 0] HP1_RRESP;
wire  HP1_BVALID;
wire  HP1_BREADY;
wire [1 : 0] HP1_BRESP;
wire [0 : 0] HP1_BID;
wire [0 : 0] HP1_BUSER;
wire  HP3_AWVALID;
wire  HP3_AWREADY;
wire [63 : 0] HP3_AWADDR;
wire [0 : 0] HP3_AWID;
wire [7 : 0] HP3_AWLEN;
wire [2 : 0] HP3_AWSIZE;
wire [1 : 0] HP3_AWBURST;
wire [1 : 0] HP3_AWLOCK;
wire [3 : 0] HP3_AWCACHE;
wire [2 : 0] HP3_AWPROT;
wire [3 : 0] HP3_AWQOS;
wire [3 : 0] HP3_AWREGION;
wire [0 : 0] HP3_AWUSER;
wire  HP3_WVALID;
wire  HP3_WREADY;
wire [31 : 0] HP3_WDATA;
wire [3 : 0] HP3_WSTRB;
wire  HP3_WLAST;
wire [0 : 0] HP3_WID;
wire [0 : 0] HP3_WUSER;
wire  HP3_ARVALID;
wire  HP3_ARREADY;
wire [63 : 0] HP3_ARADDR;
wire [0 : 0] HP3_ARID;
wire [7 : 0] HP3_ARLEN;
wire [2 : 0] HP3_ARSIZE;
wire [1 : 0] HP3_ARBURST;
wire [1 : 0] HP3_ARLOCK;
wire [3 : 0] HP3_ARCACHE;
wire [2 : 0] HP3_ARPROT;
wire [3 : 0] HP3_ARQOS;
wire [3 : 0] HP3_ARREGION;
wire [0 : 0] HP3_ARUSER;
wire  HP3_RVALID;
wire  HP3_RREADY;
wire [31 : 0] HP3_RDATA;
wire  HP3_RLAST;
wire [0 : 0] HP3_RID;
wire [0 : 0] HP3_RUSER;
wire [1 : 0] HP3_RRESP;
wire  HP3_BVALID;
wire  HP3_BREADY;
wire [1 : 0] HP3_BRESP;
wire [0 : 0] HP3_BID;
wire [0 : 0] HP3_BUSER;
integer done_cnt = 0;
integer AESL_ready_cnt = 0;
integer ready_cnt = 0;
reg ready_initial;
reg ready_initial_n;
reg ready_last_n;
reg ready_delay_last_n;
reg done_delay_last_n;
reg interface_done = 0;
wire control_write_data_finish;
wire AESL_slave_start;
reg AESL_slave_start_lock = 0;
wire AESL_slave_write_start_in;
wire AESL_slave_write_start_finish;
reg AESL_slave_ready;
wire AESL_slave_output_done;
wire AESL_slave_done;
reg ready_rise = 0;
reg start_rise = 0;
reg slave_start_status = 0;
reg slave_done_status = 0;
reg ap_done_lock = 0;

wire ap_clk;
wire ap_rst_n;
wire ap_rst_n_n;

`AUTOTB_DUT `AUTOTB_DUT_INST(
    .s_axi_control_AWADDR(control_AWADDR),
    .s_axi_control_AWVALID(control_AWVALID),
    .s_axi_control_AWREADY(control_AWREADY),
    .s_axi_control_WVALID(control_WVALID),
    .s_axi_control_WREADY(control_WREADY),
    .s_axi_control_WDATA(control_WDATA),
    .s_axi_control_WSTRB(control_WSTRB),
    .s_axi_control_ARADDR(control_ARADDR),
    .s_axi_control_ARVALID(control_ARVALID),
    .s_axi_control_ARREADY(control_ARREADY),
    .s_axi_control_RVALID(control_RVALID),
    .s_axi_control_RREADY(control_RREADY),
    .s_axi_control_RDATA(control_RDATA),
    .s_axi_control_RRESP(control_RRESP),
    .s_axi_control_BVALID(control_BVALID),
    .s_axi_control_BREADY(control_BREADY),
    .s_axi_control_BRESP(control_BRESP),
    .interrupt(control_INTERRUPT),
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .m_axi_HP1_AWVALID(HP1_AWVALID),
    .m_axi_HP1_AWREADY(HP1_AWREADY),
    .m_axi_HP1_AWADDR(HP1_AWADDR),
    .m_axi_HP1_AWID(HP1_AWID),
    .m_axi_HP1_AWLEN(HP1_AWLEN),
    .m_axi_HP1_AWSIZE(HP1_AWSIZE),
    .m_axi_HP1_AWBURST(HP1_AWBURST),
    .m_axi_HP1_AWLOCK(HP1_AWLOCK),
    .m_axi_HP1_AWCACHE(HP1_AWCACHE),
    .m_axi_HP1_AWPROT(HP1_AWPROT),
    .m_axi_HP1_AWQOS(HP1_AWQOS),
    .m_axi_HP1_AWREGION(HP1_AWREGION),
    .m_axi_HP1_AWUSER(HP1_AWUSER),
    .m_axi_HP1_WVALID(HP1_WVALID),
    .m_axi_HP1_WREADY(HP1_WREADY),
    .m_axi_HP1_WDATA(HP1_WDATA),
    .m_axi_HP1_WSTRB(HP1_WSTRB),
    .m_axi_HP1_WLAST(HP1_WLAST),
    .m_axi_HP1_WID(HP1_WID),
    .m_axi_HP1_WUSER(HP1_WUSER),
    .m_axi_HP1_ARVALID(HP1_ARVALID),
    .m_axi_HP1_ARREADY(HP1_ARREADY),
    .m_axi_HP1_ARADDR(HP1_ARADDR),
    .m_axi_HP1_ARID(HP1_ARID),
    .m_axi_HP1_ARLEN(HP1_ARLEN),
    .m_axi_HP1_ARSIZE(HP1_ARSIZE),
    .m_axi_HP1_ARBURST(HP1_ARBURST),
    .m_axi_HP1_ARLOCK(HP1_ARLOCK),
    .m_axi_HP1_ARCACHE(HP1_ARCACHE),
    .m_axi_HP1_ARPROT(HP1_ARPROT),
    .m_axi_HP1_ARQOS(HP1_ARQOS),
    .m_axi_HP1_ARREGION(HP1_ARREGION),
    .m_axi_HP1_ARUSER(HP1_ARUSER),
    .m_axi_HP1_RVALID(HP1_RVALID),
    .m_axi_HP1_RREADY(HP1_RREADY),
    .m_axi_HP1_RDATA(HP1_RDATA),
    .m_axi_HP1_RLAST(HP1_RLAST),
    .m_axi_HP1_RID(HP1_RID),
    .m_axi_HP1_RUSER(HP1_RUSER),
    .m_axi_HP1_RRESP(HP1_RRESP),
    .m_axi_HP1_BVALID(HP1_BVALID),
    .m_axi_HP1_BREADY(HP1_BREADY),
    .m_axi_HP1_BRESP(HP1_BRESP),
    .m_axi_HP1_BID(HP1_BID),
    .m_axi_HP1_BUSER(HP1_BUSER),
    .m_axi_HP3_AWVALID(HP3_AWVALID),
    .m_axi_HP3_AWREADY(HP3_AWREADY),
    .m_axi_HP3_AWADDR(HP3_AWADDR),
    .m_axi_HP3_AWID(HP3_AWID),
    .m_axi_HP3_AWLEN(HP3_AWLEN),
    .m_axi_HP3_AWSIZE(HP3_AWSIZE),
    .m_axi_HP3_AWBURST(HP3_AWBURST),
    .m_axi_HP3_AWLOCK(HP3_AWLOCK),
    .m_axi_HP3_AWCACHE(HP3_AWCACHE),
    .m_axi_HP3_AWPROT(HP3_AWPROT),
    .m_axi_HP3_AWQOS(HP3_AWQOS),
    .m_axi_HP3_AWREGION(HP3_AWREGION),
    .m_axi_HP3_AWUSER(HP3_AWUSER),
    .m_axi_HP3_WVALID(HP3_WVALID),
    .m_axi_HP3_WREADY(HP3_WREADY),
    .m_axi_HP3_WDATA(HP3_WDATA),
    .m_axi_HP3_WSTRB(HP3_WSTRB),
    .m_axi_HP3_WLAST(HP3_WLAST),
    .m_axi_HP3_WID(HP3_WID),
    .m_axi_HP3_WUSER(HP3_WUSER),
    .m_axi_HP3_ARVALID(HP3_ARVALID),
    .m_axi_HP3_ARREADY(HP3_ARREADY),
    .m_axi_HP3_ARADDR(HP3_ARADDR),
    .m_axi_HP3_ARID(HP3_ARID),
    .m_axi_HP3_ARLEN(HP3_ARLEN),
    .m_axi_HP3_ARSIZE(HP3_ARSIZE),
    .m_axi_HP3_ARBURST(HP3_ARBURST),
    .m_axi_HP3_ARLOCK(HP3_ARLOCK),
    .m_axi_HP3_ARCACHE(HP3_ARCACHE),
    .m_axi_HP3_ARPROT(HP3_ARPROT),
    .m_axi_HP3_ARQOS(HP3_ARQOS),
    .m_axi_HP3_ARREGION(HP3_ARREGION),
    .m_axi_HP3_ARUSER(HP3_ARUSER),
    .m_axi_HP3_RVALID(HP3_RVALID),
    .m_axi_HP3_RREADY(HP3_RREADY),
    .m_axi_HP3_RDATA(HP3_RDATA),
    .m_axi_HP3_RLAST(HP3_RLAST),
    .m_axi_HP3_RID(HP3_RID),
    .m_axi_HP3_RUSER(HP3_RUSER),
    .m_axi_HP3_RRESP(HP3_RRESP),
    .m_axi_HP3_BVALID(HP3_BVALID),
    .m_axi_HP3_BREADY(HP3_BREADY),
    .m_axi_HP3_BRESP(HP3_BRESP),
    .m_axi_HP3_BID(HP3_BID),
    .m_axi_HP3_BUSER(HP3_BUSER));

// Assignment for control signal
assign ap_clk = AESL_clock;
assign ap_rst_n = dut_rst;
assign ap_rst_n_n = ~dut_rst;
assign AESL_reset = rst;
assign AESL_start = start;
assign AESL_ce = ce;
assign AESL_continue = tb_continue;
  assign AESL_slave_write_start_in = slave_start_status  & control_write_data_finish;
  assign AESL_slave_start = AESL_slave_write_start_finish;
  assign AESL_done = slave_done_status ;

always @(posedge AESL_clock)
begin
    if(AESL_reset === 0)
    begin
        slave_start_status <= 1;
    end
    else begin
        if (AESL_start == 1 ) begin
            start_rise = 1;
        end
        if (start_rise == 1 && AESL_done == 1 ) begin
            slave_start_status <= 1;
        end
        if (AESL_slave_write_start_in == 1 && AESL_done == 0) begin 
            slave_start_status <= 0;
            start_rise = 0;
        end
    end
end

always @(posedge AESL_clock)
begin
    if(AESL_reset === 0)
    begin
        AESL_slave_ready <= 0;
        ready_rise = 0;
    end
    else begin
        if (AESL_ready == 1 ) begin
            ready_rise = 1;
        end
        if (ready_rise == 1 && AESL_done_delay == 1 ) begin
            AESL_slave_ready <= 1;
        end
        if (AESL_slave_ready == 1) begin 
            AESL_slave_ready <= 0;
            ready_rise = 0;
        end
    end
end

always @ (posedge AESL_clock)
begin
    if (AESL_done == 1) begin
        slave_done_status <= 0;
    end
    else if (AESL_slave_output_done == 1 ) begin
        slave_done_status <= 1;
    end
end




wire    AESL_axi_master_HP1_ready;
wire    AESL_axi_master_HP1_done;
AESL_axi_master_HP1 AESL_AXI_MASTER_HP1(
    .clk   (AESL_clock),
    .reset (AESL_reset),
    .TRAN_HP1_AWVALID (HP1_AWVALID),
    .TRAN_HP1_AWREADY (HP1_AWREADY),
    .TRAN_HP1_AWADDR (HP1_AWADDR),
    .TRAN_HP1_AWID (HP1_AWID),
    .TRAN_HP1_AWLEN (HP1_AWLEN),
    .TRAN_HP1_AWSIZE (HP1_AWSIZE),
    .TRAN_HP1_AWBURST (HP1_AWBURST),
    .TRAN_HP1_AWLOCK (HP1_AWLOCK),
    .TRAN_HP1_AWCACHE (HP1_AWCACHE),
    .TRAN_HP1_AWPROT (HP1_AWPROT),
    .TRAN_HP1_AWQOS (HP1_AWQOS),
    .TRAN_HP1_AWREGION (HP1_AWREGION),
    .TRAN_HP1_AWUSER (HP1_AWUSER),
    .TRAN_HP1_WVALID (HP1_WVALID),
    .TRAN_HP1_WREADY (HP1_WREADY),
    .TRAN_HP1_WDATA (HP1_WDATA),
    .TRAN_HP1_WSTRB (HP1_WSTRB),
    .TRAN_HP1_WLAST (HP1_WLAST),
    .TRAN_HP1_WID (HP1_WID),
    .TRAN_HP1_WUSER (HP1_WUSER),
    .TRAN_HP1_ARVALID (HP1_ARVALID),
    .TRAN_HP1_ARREADY (HP1_ARREADY),
    .TRAN_HP1_ARADDR (HP1_ARADDR),
    .TRAN_HP1_ARID (HP1_ARID),
    .TRAN_HP1_ARLEN (HP1_ARLEN),
    .TRAN_HP1_ARSIZE (HP1_ARSIZE),
    .TRAN_HP1_ARBURST (HP1_ARBURST),
    .TRAN_HP1_ARLOCK (HP1_ARLOCK),
    .TRAN_HP1_ARCACHE (HP1_ARCACHE),
    .TRAN_HP1_ARPROT (HP1_ARPROT),
    .TRAN_HP1_ARQOS (HP1_ARQOS),
    .TRAN_HP1_ARREGION (HP1_ARREGION),
    .TRAN_HP1_ARUSER (HP1_ARUSER),
    .TRAN_HP1_RVALID (HP1_RVALID),
    .TRAN_HP1_RREADY (HP1_RREADY),
    .TRAN_HP1_RDATA (HP1_RDATA),
    .TRAN_HP1_RLAST (HP1_RLAST),
    .TRAN_HP1_RID (HP1_RID),
    .TRAN_HP1_RUSER (HP1_RUSER),
    .TRAN_HP1_RRESP (HP1_RRESP),
    .TRAN_HP1_BVALID (HP1_BVALID),
    .TRAN_HP1_BREADY (HP1_BREADY),
    .TRAN_HP1_BRESP (HP1_BRESP),
    .TRAN_HP1_BID (HP1_BID),
    .TRAN_HP1_BUSER (HP1_BUSER),
    .ready (AESL_axi_master_HP1_ready),
    .done  (AESL_axi_master_HP1_done)
);
assign    AESL_axi_master_HP1_ready    =   ready;
assign    AESL_axi_master_HP1_done    =   AESL_done_delay;
wire    AESL_axi_master_HP3_ready;
wire    AESL_axi_master_HP3_done;
AESL_axi_master_HP3 AESL_AXI_MASTER_HP3(
    .clk   (AESL_clock),
    .reset (AESL_reset),
    .TRAN_HP3_AWVALID (HP3_AWVALID),
    .TRAN_HP3_AWREADY (HP3_AWREADY),
    .TRAN_HP3_AWADDR (HP3_AWADDR),
    .TRAN_HP3_AWID (HP3_AWID),
    .TRAN_HP3_AWLEN (HP3_AWLEN),
    .TRAN_HP3_AWSIZE (HP3_AWSIZE),
    .TRAN_HP3_AWBURST (HP3_AWBURST),
    .TRAN_HP3_AWLOCK (HP3_AWLOCK),
    .TRAN_HP3_AWCACHE (HP3_AWCACHE),
    .TRAN_HP3_AWPROT (HP3_AWPROT),
    .TRAN_HP3_AWQOS (HP3_AWQOS),
    .TRAN_HP3_AWREGION (HP3_AWREGION),
    .TRAN_HP3_AWUSER (HP3_AWUSER),
    .TRAN_HP3_WVALID (HP3_WVALID),
    .TRAN_HP3_WREADY (HP3_WREADY),
    .TRAN_HP3_WDATA (HP3_WDATA),
    .TRAN_HP3_WSTRB (HP3_WSTRB),
    .TRAN_HP3_WLAST (HP3_WLAST),
    .TRAN_HP3_WID (HP3_WID),
    .TRAN_HP3_WUSER (HP3_WUSER),
    .TRAN_HP3_ARVALID (HP3_ARVALID),
    .TRAN_HP3_ARREADY (HP3_ARREADY),
    .TRAN_HP3_ARADDR (HP3_ARADDR),
    .TRAN_HP3_ARID (HP3_ARID),
    .TRAN_HP3_ARLEN (HP3_ARLEN),
    .TRAN_HP3_ARSIZE (HP3_ARSIZE),
    .TRAN_HP3_ARBURST (HP3_ARBURST),
    .TRAN_HP3_ARLOCK (HP3_ARLOCK),
    .TRAN_HP3_ARCACHE (HP3_ARCACHE),
    .TRAN_HP3_ARPROT (HP3_ARPROT),
    .TRAN_HP3_ARQOS (HP3_ARQOS),
    .TRAN_HP3_ARREGION (HP3_ARREGION),
    .TRAN_HP3_ARUSER (HP3_ARUSER),
    .TRAN_HP3_RVALID (HP3_RVALID),
    .TRAN_HP3_RREADY (HP3_RREADY),
    .TRAN_HP3_RDATA (HP3_RDATA),
    .TRAN_HP3_RLAST (HP3_RLAST),
    .TRAN_HP3_RID (HP3_RID),
    .TRAN_HP3_RUSER (HP3_RUSER),
    .TRAN_HP3_RRESP (HP3_RRESP),
    .TRAN_HP3_BVALID (HP3_BVALID),
    .TRAN_HP3_BREADY (HP3_BREADY),
    .TRAN_HP3_BRESP (HP3_BRESP),
    .TRAN_HP3_BID (HP3_BID),
    .TRAN_HP3_BUSER (HP3_BUSER),
    .ready (AESL_axi_master_HP3_ready),
    .done  (AESL_axi_master_HP3_done)
);
assign    AESL_axi_master_HP3_ready    =   ready;
assign    AESL_axi_master_HP3_done    =   AESL_done_delay;

AESL_axi_slave_control AESL_AXI_SLAVE_control(
    .clk   (AESL_clock),
    .reset (AESL_reset),
    .TRAN_s_axi_control_AWADDR (control_AWADDR),
    .TRAN_s_axi_control_AWVALID (control_AWVALID),
    .TRAN_s_axi_control_AWREADY (control_AWREADY),
    .TRAN_s_axi_control_WVALID (control_WVALID),
    .TRAN_s_axi_control_WREADY (control_WREADY),
    .TRAN_s_axi_control_WDATA (control_WDATA),
    .TRAN_s_axi_control_WSTRB (control_WSTRB),
    .TRAN_s_axi_control_ARADDR (control_ARADDR),
    .TRAN_s_axi_control_ARVALID (control_ARVALID),
    .TRAN_s_axi_control_ARREADY (control_ARREADY),
    .TRAN_s_axi_control_RVALID (control_RVALID),
    .TRAN_s_axi_control_RREADY (control_RREADY),
    .TRAN_s_axi_control_RDATA (control_RDATA),
    .TRAN_s_axi_control_RRESP (control_RRESP),
    .TRAN_s_axi_control_BVALID (control_BVALID),
    .TRAN_s_axi_control_BREADY (control_BREADY),
    .TRAN_s_axi_control_BRESP (control_BRESP),
    .TRAN_control_interrupt (control_INTERRUPT),
    .TRAN_control_write_data_finish(control_write_data_finish),
    .TRAN_control_ready_out (AESL_ready),
    .TRAN_control_ready_in (AESL_slave_ready),
    .TRAN_control_done_out (AESL_slave_output_done),
    .TRAN_control_idle_out (AESL_idle),
    .TRAN_control_write_start_in     (AESL_slave_write_start_in),
    .TRAN_control_write_start_finish (AESL_slave_write_start_finish),
    .TRAN_control_transaction_done_in (AESL_done_delay),
    .TRAN_control_start_in  (AESL_slave_start)
);

initial begin : generate_AESL_ready_cnt_proc
    AESL_ready_cnt = 0;
    wait(AESL_reset === 1);
    while(AESL_ready_cnt != AUTOTB_TRANSACTION_NUM) begin
        while(AESL_ready !== 1) begin
            @(posedge AESL_clock);
            # 0.4;
        end
        @(negedge AESL_clock);
        AESL_ready_cnt = AESL_ready_cnt + 1;
        @(posedge AESL_clock);
        # 0.4;
    end
end

    event next_trigger_ready_cnt;
    
    initial begin : gen_ready_cnt
        ready_cnt = 0;
        wait (AESL_reset === 1);
        forever begin
            @ (posedge AESL_clock);
            if (ready == 1) begin
                if (ready_cnt < AUTOTB_TRANSACTION_NUM) begin
                    ready_cnt = ready_cnt + 1;
                end
            end
            -> next_trigger_ready_cnt;
        end
    end
    
    wire all_finish = (done_cnt == AUTOTB_TRANSACTION_NUM);
    
    // done_cnt
    always @ (posedge AESL_clock) begin
        if (~AESL_reset) begin
            done_cnt <= 0;
        end else begin
            if (AESL_done == 1) begin
                if (done_cnt < AUTOTB_TRANSACTION_NUM) begin
                    done_cnt <= done_cnt + 1;
                end
            end
        end
    end
    
    initial begin : finish_simulation
        wait (all_finish == 1);
        // last transaction is saved at negedge right after last done
        @ (posedge AESL_clock);
        @ (posedge AESL_clock);
        @ (posedge AESL_clock);
        @ (posedge AESL_clock);
        $finish;
    end
    
initial begin
    AESL_clock = 0;
    forever #`AUTOTB_CLOCK_PERIOD_DIV2 AESL_clock = ~AESL_clock;
end


reg end_HP1;
reg [31:0] size_HP1;
reg [31:0] size_HP1_backup;
reg end_s1;
reg [31:0] size_s1;
reg [31:0] size_s1_backup;
reg end_output_r;
reg [31:0] size_output_r;
reg [31:0] size_output_r_backup;
reg end_HP3;
reg [31:0] size_HP3;
reg [31:0] size_HP3_backup;

initial begin : initial_process
    integer proc_rand;
    rst = 0;
    # 100;
    repeat(3+3) @ (posedge AESL_clock);
    rst = 1;
end
initial begin : initial_process_for_dut_rst
    integer proc_rand;
    dut_rst = 0;
    # 100;
    repeat(3) @ (posedge AESL_clock);
    dut_rst = 1;
end
initial begin : start_process
    integer proc_rand;
    reg [31:0] start_cnt;
    ce = 1;
    start = 0;
    start_cnt = 0;
    wait (AESL_reset === 1);
    @ (posedge AESL_clock);
    #0 start = 1;
    start_cnt = start_cnt + 1;
    forever begin
        if (start_cnt >= AUTOTB_TRANSACTION_NUM + 1) begin
            #0 start = 0;
        end
        @ (posedge AESL_clock);
        if (AESL_ready) begin
            start_cnt = start_cnt + 1;
        end
    end
end

always @(AESL_done)
begin
    tb_continue = AESL_done;
end

initial begin : ready_initial_process
    ready_initial = 0;
    wait (AESL_start === 1);
    ready_initial = 1;
    @(posedge AESL_clock);
    ready_initial = 0;
end

always @(posedge AESL_clock)
begin
    if(AESL_reset === 0)
      AESL_ready_delay = 0;
  else
      AESL_ready_delay = AESL_ready;
end
initial begin : ready_last_n_process
  ready_last_n = 1;
  wait(ready_cnt == AUTOTB_TRANSACTION_NUM)
  @(posedge AESL_clock);
  ready_last_n <= 0;
end

always @(posedge AESL_clock)
begin
    if(AESL_reset === 0)
      ready_delay_last_n = 0;
  else
      ready_delay_last_n <= ready_last_n;
end
assign ready = (ready_initial | AESL_ready_delay);
assign ready_wire = ready_initial | AESL_ready_delay;
initial begin : done_delay_last_n_process
  done_delay_last_n = 1;
  while(done_cnt < AUTOTB_TRANSACTION_NUM)
      @(posedge AESL_clock);
  # 0.1;
  done_delay_last_n = 0;
end

always @(posedge AESL_clock)
begin
    if(AESL_reset === 0)
  begin
      AESL_done_delay <= 0;
      AESL_done_delay2 <= 0;
  end
  else begin
      AESL_done_delay <= AESL_done & done_delay_last_n;
      AESL_done_delay2 <= AESL_done_delay;
  end
end
always @(posedge AESL_clock)
begin
    if(AESL_reset === 0)
      interface_done = 0;
  else begin
      # 0.01;
      if(ready === 1 && ready_cnt > 0 && ready_cnt < AUTOTB_TRANSACTION_NUM)
          interface_done = 1;
      else if(AESL_done_delay === 1 && done_cnt == AUTOTB_TRANSACTION_NUM)
          interface_done = 1;
      else
          interface_done = 0;
  end
end

reg dump_tvout_finish_HP3;

initial begin : dump_tvout_runtime_sign_HP3
    integer fp;
    dump_tvout_finish_HP3 = 0;
    fp = $fopen(`AUTOTB_TVOUT_HP3_out_wrapc, "w");
    if (fp == 0) begin
        $display("Failed to open file \"%s\"!", `AUTOTB_TVOUT_HP3_out_wrapc);
        $display("ERROR: Simulation using HLS TB failed.");
        $finish;
    end
    $fdisplay(fp,"[[[runtime]]]");
    $fclose(fp);
    wait (done_cnt == AUTOTB_TRANSACTION_NUM);
    // last transaction is saved at negedge right after last done
    @ (posedge AESL_clock);
    @ (posedge AESL_clock);
    @ (posedge AESL_clock);
    fp = $fopen(`AUTOTB_TVOUT_HP3_out_wrapc, "a");
    if (fp == 0) begin
        $display("Failed to open file \"%s\"!", `AUTOTB_TVOUT_HP3_out_wrapc);
        $display("ERROR: Simulation using HLS TB failed.");
        $finish;
    end
    $fdisplay(fp,"[[[/runtime]]]");
    $fclose(fp);
    dump_tvout_finish_HP3 = 1;
end


////////////////////////////////////////////
// progress and performance
////////////////////////////////////////////

task wait_start();
    while (~AESL_start) begin
        @ (posedge AESL_clock);
    end
endtask

reg [31:0] clk_cnt = 0;
reg AESL_ready_p1;
reg AESL_start_p1;

always @ (posedge AESL_clock) begin
    if (AESL_reset == 0) begin
        clk_cnt <= 32'h0;
        AESL_ready_p1 <= 1'b0;
        AESL_start_p1 <= 1'b0;
    end
    else begin
        clk_cnt <= clk_cnt + 1;
        AESL_ready_p1 <= AESL_ready;
        AESL_start_p1 <= AESL_start;
    end
end

reg [31:0] start_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] start_cnt;
reg [31:0] ready_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] ap_ready_cnt;
reg [31:0] finish_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] finish_cnt;
reg [31:0] lat_total;
event report_progress;

always @(posedge AESL_clock)
begin
    if (finish_cnt == AUTOTB_TRANSACTION_NUM - 1 && AESL_done == 1'b1)
        lat_total = clk_cnt - start_timestamp[0];
end

initial begin
    start_cnt = 0;
    finish_cnt = 0;
    ap_ready_cnt = 0;
    wait (AESL_reset == 1);
    wait_start();
    start_timestamp[start_cnt] = clk_cnt;
    start_cnt = start_cnt + 1;
    if (AESL_done) begin
        finish_timestamp[finish_cnt] = clk_cnt;
        finish_cnt = finish_cnt + 1;
    end
    -> report_progress;
    forever begin
        @ (posedge AESL_clock);
        if (start_cnt < AUTOTB_TRANSACTION_NUM) begin
            if ((AESL_start && AESL_ready_p1)||(AESL_start && ~AESL_start_p1)) begin
                start_timestamp[start_cnt] = clk_cnt;
                start_cnt = start_cnt + 1;
            end
        end
        if (ap_ready_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_start_p1 && AESL_ready_p1) begin
                ready_timestamp[ap_ready_cnt] = clk_cnt;
                ap_ready_cnt = ap_ready_cnt + 1;
            end
        end
        if (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_done) begin
                finish_timestamp[finish_cnt] = clk_cnt;
                finish_cnt = finish_cnt + 1;
            end
        end
        -> report_progress;
    end
end

reg [31:0] progress_timeout;

initial begin : simulation_progress
    real intra_progress;
    wait (AESL_reset == 1);
    progress_timeout = PROGRESS_TIMEOUT;
    $display("////////////////////////////////////////////////////////////////////////////////////");
    $display("// Inter-Transaction Progress: Completed Transaction / Total Transaction");
    $display("// Intra-Transaction Progress: Measured Latency / Latency Estimation * 100%%");
    $display("//");
    $display("// RTL Simulation : \"Inter-Transaction Progress\" [\"Intra-Transaction Progress\"] @ \"Simulation Time\"");
    $display("////////////////////////////////////////////////////////////////////////////////////");
    print_progress();
    while (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
        @ (report_progress);
        if (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_done) begin
                print_progress();
                progress_timeout = PROGRESS_TIMEOUT;
            end else begin
                if (progress_timeout == 0) begin
                    print_progress();
                    progress_timeout = PROGRESS_TIMEOUT;
                end else begin
                    progress_timeout = progress_timeout - 1;
                end
            end
        end
    end
    print_progress();
    $display("////////////////////////////////////////////////////////////////////////////////////");
    calculate_performance();
end

task get_intra_progress(output real intra_progress);
    begin
        if (start_cnt > finish_cnt) begin
            intra_progress = clk_cnt - start_timestamp[finish_cnt];
        end else if(finish_cnt > 0) begin
            intra_progress = LATENCY_ESTIMATION;
        end else begin
            intra_progress = 0;
        end
        intra_progress = intra_progress / LATENCY_ESTIMATION;
    end
endtask

task print_progress();
    real intra_progress;
    begin
        if (LATENCY_ESTIMATION > 0) begin
            get_intra_progress(intra_progress);
            $display("// RTL Simulation : %0d / %0d [%2.2f%%] @ \"%0t\"", finish_cnt, AUTOTB_TRANSACTION_NUM, intra_progress * 100, $time);
        end else begin
            $display("// RTL Simulation : %0d / %0d [n/a] @ \"%0t\"", finish_cnt, AUTOTB_TRANSACTION_NUM, $time);
        end
    end
endtask

task calculate_performance();
    integer i;
    integer fp;
    reg [31:0] latency [0:AUTOTB_TRANSACTION_NUM - 1];
    reg [31:0] latency_min;
    reg [31:0] latency_max;
    reg [31:0] latency_total;
    reg [31:0] latency_average;
    reg [31:0] interval [0:AUTOTB_TRANSACTION_NUM - 2];
    reg [31:0] interval_min;
    reg [31:0] interval_max;
    reg [31:0] interval_total;
    reg [31:0] interval_average;
    reg [31:0] total_execute_time;
    begin
        latency_min = -1;
        latency_max = 0;
        latency_total = 0;
        interval_min = -1;
        interval_max = 0;
        interval_total = 0;
        total_execute_time = lat_total;

        for (i = 0; i < AUTOTB_TRANSACTION_NUM; i = i + 1) begin
            // calculate latency
            latency[i] = finish_timestamp[i] - start_timestamp[i];
            if (latency[i] > latency_max) latency_max = latency[i];
            if (latency[i] < latency_min) latency_min = latency[i];
            latency_total = latency_total + latency[i];
            // calculate interval
            if (AUTOTB_TRANSACTION_NUM == 1) begin
                interval[i] = 0;
                interval_max = 0;
                interval_min = 0;
                interval_total = 0;
            end else if (i < AUTOTB_TRANSACTION_NUM - 1) begin
                interval[i] = start_timestamp[i + 1] - start_timestamp[i];
                if (interval[i] > interval_max) interval_max = interval[i];
                if (interval[i] < interval_min) interval_min = interval[i];
                interval_total = interval_total + interval[i];
            end
        end

        latency_average = latency_total / AUTOTB_TRANSACTION_NUM;
        if (AUTOTB_TRANSACTION_NUM == 1) begin
            interval_average = 0;
        end else begin
            interval_average = interval_total / (AUTOTB_TRANSACTION_NUM - 1);
        end

        fp = $fopen(`AUTOTB_LAT_RESULT_FILE, "w");

        $fdisplay(fp, "$MAX_LATENCY = \"%0d\"", latency_max);
        $fdisplay(fp, "$MIN_LATENCY = \"%0d\"", latency_min);
        $fdisplay(fp, "$AVER_LATENCY = \"%0d\"", latency_average);
        $fdisplay(fp, "$MAX_THROUGHPUT = \"%0d\"", interval_max);
        $fdisplay(fp, "$MIN_THROUGHPUT = \"%0d\"", interval_min);
        $fdisplay(fp, "$AVER_THROUGHPUT = \"%0d\"", interval_average);
        $fdisplay(fp, "$TOTAL_EXECUTE_TIME = \"%0d\"", total_execute_time);

        $fclose(fp);

        fp = $fopen(`AUTOTB_PER_RESULT_TRANS_FILE, "w");

        $fdisplay(fp, "%20s%16s%16s", "", "latency", "interval");
        if (AUTOTB_TRANSACTION_NUM == 1) begin
            i = 0;
            $fdisplay(fp, "transaction%8d:%16d%16d", i, latency[i], interval[i]);
        end else begin
            for (i = 0; i < AUTOTB_TRANSACTION_NUM; i = i + 1) begin
                if (i < AUTOTB_TRANSACTION_NUM - 1) begin
                    $fdisplay(fp, "transaction%8d:%16d%16d", i, latency[i], interval[i]);
                end else begin
                    $fdisplay(fp, "transaction%8d:%16d               x", i, latency[i]);
                end
            end
        end

        $fclose(fp);
    end
endtask


////////////////////////////////////////////
// Dependence Check
////////////////////////////////////////////

`ifndef POST_SYN

`endif

AESL_deadlock_detector deadlock_detector(
    .reset(AESL_reset),
    .all_finish(all_finish),
    .clock(AESL_clock));

///////////////////////////////////////////////////////
// dataflow status monitor
///////////////////////////////////////////////////////
dataflow_monitor U_dataflow_monitor(
    .clock(AESL_clock),
    .reset(~rst),
    .finish(all_finish));

`include "fifo_para.vh"

endmodule
