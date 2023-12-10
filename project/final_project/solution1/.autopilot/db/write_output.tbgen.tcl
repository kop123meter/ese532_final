set moduleName write_output
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {write_output}
set C_modelType { void 0 }
set C_modelArgList {
	{ output_stream int 16 regular {fifo 0 volatile }  }
	{ HP3 int 16 regular {axi_master 1}  }
	{ compress_size int 32 regular {pointer 0 volatile }  }
	{ output_r int 64 regular {fifo 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "output_stream", "interface" : "fifo", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HP3", "interface" : "axi_master", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "compress_size", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "output_r", "interface" : "fifo", "bitwidth" : 64, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 59
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ output_stream_dout sc_in sc_lv 16 signal 0 } 
	{ output_stream_empty_n sc_in sc_logic 1 signal 0 } 
	{ output_stream_read sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP3_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP3_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_HP3_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_HP3_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_HP3_AWLEN sc_out sc_lv 32 signal 1 } 
	{ m_axi_HP3_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_HP3_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_HP3_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_HP3_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_HP3_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_HP3_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_HP3_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_HP3_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_HP3_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP3_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_HP3_WDATA sc_out sc_lv 16 signal 1 } 
	{ m_axi_HP3_WSTRB sc_out sc_lv 2 signal 1 } 
	{ m_axi_HP3_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP3_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_HP3_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_HP3_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP3_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_HP3_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_HP3_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_HP3_ARLEN sc_out sc_lv 32 signal 1 } 
	{ m_axi_HP3_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_HP3_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_HP3_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_HP3_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_HP3_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_HP3_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_HP3_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_HP3_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_HP3_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_HP3_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP3_RDATA sc_in sc_lv 16 signal 1 } 
	{ m_axi_HP3_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_HP3_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_HP3_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_HP3_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_HP3_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_HP3_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP3_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_HP3_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_HP3_BUSER sc_in sc_lv 1 signal 1 } 
	{ compress_size sc_in sc_lv 32 signal 2 } 
	{ output_r_dout sc_in sc_lv 64 signal 3 } 
	{ output_r_empty_n sc_in sc_logic 1 signal 3 } 
	{ output_r_read sc_out sc_logic 1 signal 3 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "output_stream_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "output_stream", "role": "dout" }} , 
 	{ "name": "output_stream_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "output_stream", "role": "empty_n" }} , 
 	{ "name": "output_stream_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "output_stream", "role": "read" }} , 
 	{ "name": "m_axi_HP3_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "AWVALID" }} , 
 	{ "name": "m_axi_HP3_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "AWREADY" }} , 
 	{ "name": "m_axi_HP3_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP3", "role": "AWADDR" }} , 
 	{ "name": "m_axi_HP3_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "AWID" }} , 
 	{ "name": "m_axi_HP3_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP3", "role": "AWLEN" }} , 
 	{ "name": "m_axi_HP3_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP3", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_HP3_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP3", "role": "AWBURST" }} , 
 	{ "name": "m_axi_HP3_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP3", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_HP3_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP3", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_HP3_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP3", "role": "AWPROT" }} , 
 	{ "name": "m_axi_HP3_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP3", "role": "AWQOS" }} , 
 	{ "name": "m_axi_HP3_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP3", "role": "AWREGION" }} , 
 	{ "name": "m_axi_HP3_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "AWUSER" }} , 
 	{ "name": "m_axi_HP3_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "WVALID" }} , 
 	{ "name": "m_axi_HP3_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "WREADY" }} , 
 	{ "name": "m_axi_HP3_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HP3", "role": "WDATA" }} , 
 	{ "name": "m_axi_HP3_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP3", "role": "WSTRB" }} , 
 	{ "name": "m_axi_HP3_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "WLAST" }} , 
 	{ "name": "m_axi_HP3_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "WID" }} , 
 	{ "name": "m_axi_HP3_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "WUSER" }} , 
 	{ "name": "m_axi_HP3_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "ARVALID" }} , 
 	{ "name": "m_axi_HP3_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "ARREADY" }} , 
 	{ "name": "m_axi_HP3_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP3", "role": "ARADDR" }} , 
 	{ "name": "m_axi_HP3_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "ARID" }} , 
 	{ "name": "m_axi_HP3_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP3", "role": "ARLEN" }} , 
 	{ "name": "m_axi_HP3_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP3", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_HP3_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP3", "role": "ARBURST" }} , 
 	{ "name": "m_axi_HP3_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP3", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_HP3_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP3", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_HP3_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP3", "role": "ARPROT" }} , 
 	{ "name": "m_axi_HP3_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP3", "role": "ARQOS" }} , 
 	{ "name": "m_axi_HP3_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP3", "role": "ARREGION" }} , 
 	{ "name": "m_axi_HP3_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "ARUSER" }} , 
 	{ "name": "m_axi_HP3_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "RVALID" }} , 
 	{ "name": "m_axi_HP3_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "RREADY" }} , 
 	{ "name": "m_axi_HP3_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HP3", "role": "RDATA" }} , 
 	{ "name": "m_axi_HP3_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "RLAST" }} , 
 	{ "name": "m_axi_HP3_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "RID" }} , 
 	{ "name": "m_axi_HP3_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "RUSER" }} , 
 	{ "name": "m_axi_HP3_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP3", "role": "RRESP" }} , 
 	{ "name": "m_axi_HP3_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "BVALID" }} , 
 	{ "name": "m_axi_HP3_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "BREADY" }} , 
 	{ "name": "m_axi_HP3_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP3", "role": "BRESP" }} , 
 	{ "name": "m_axi_HP3_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "BID" }} , 
 	{ "name": "m_axi_HP3_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "BUSER" }} , 
 	{ "name": "compress_size", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compress_size", "role": "default" }} , 
 	{ "name": "output_r_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "output_r", "role": "dout" }} , 
 	{ "name": "output_r_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "output_r", "role": "empty_n" }} , 
 	{ "name": "output_r_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "output_r", "role": "read" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "write_output",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "output_stream", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "75", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "output_stream_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "HP3", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "HP3_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "HP3_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "HP3_blk_n_B", "Type" : "RtlSignal"}]},
			{"Name" : "compress_size", "Type" : "None", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "1"},
			{"Name" : "output_r", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "output_r_blk_n", "Type" : "RtlSignal"}]}]}]}


set ArgLastReadFirstWriteLatency {
	write_output {
		output_stream {Type I LastRead 3 FirstWrite -1}
		HP3 {Type O LastRead 3 FirstWrite 4}
		compress_size {Type I LastRead 0 FirstWrite -1}
		output_r {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	output_stream { ap_fifo {  { output_stream_dout fifo_data 0 16 }  { output_stream_empty_n fifo_status 0 1 }  { output_stream_read fifo_update 1 1 } } }
	HP3 { m_axi {  { m_axi_HP3_AWVALID VALID 1 1 }  { m_axi_HP3_AWREADY READY 0 1 }  { m_axi_HP3_AWADDR ADDR 1 64 }  { m_axi_HP3_AWID ID 1 1 }  { m_axi_HP3_AWLEN LEN 1 32 }  { m_axi_HP3_AWSIZE SIZE 1 3 }  { m_axi_HP3_AWBURST BURST 1 2 }  { m_axi_HP3_AWLOCK LOCK 1 2 }  { m_axi_HP3_AWCACHE CACHE 1 4 }  { m_axi_HP3_AWPROT PROT 1 3 }  { m_axi_HP3_AWQOS QOS 1 4 }  { m_axi_HP3_AWREGION REGION 1 4 }  { m_axi_HP3_AWUSER USER 1 1 }  { m_axi_HP3_WVALID VALID 1 1 }  { m_axi_HP3_WREADY READY 0 1 }  { m_axi_HP3_WDATA DATA 1 16 }  { m_axi_HP3_WSTRB STRB 1 2 }  { m_axi_HP3_WLAST LAST 1 1 }  { m_axi_HP3_WID ID 1 1 }  { m_axi_HP3_WUSER USER 1 1 }  { m_axi_HP3_ARVALID VALID 1 1 }  { m_axi_HP3_ARREADY READY 0 1 }  { m_axi_HP3_ARADDR ADDR 1 64 }  { m_axi_HP3_ARID ID 1 1 }  { m_axi_HP3_ARLEN LEN 1 32 }  { m_axi_HP3_ARSIZE SIZE 1 3 }  { m_axi_HP3_ARBURST BURST 1 2 }  { m_axi_HP3_ARLOCK LOCK 1 2 }  { m_axi_HP3_ARCACHE CACHE 1 4 }  { m_axi_HP3_ARPROT PROT 1 3 }  { m_axi_HP3_ARQOS QOS 1 4 }  { m_axi_HP3_ARREGION REGION 1 4 }  { m_axi_HP3_ARUSER USER 1 1 }  { m_axi_HP3_RVALID VALID 0 1 }  { m_axi_HP3_RREADY READY 1 1 }  { m_axi_HP3_RDATA DATA 0 16 }  { m_axi_HP3_RLAST LAST 0 1 }  { m_axi_HP3_RID ID 0 1 }  { m_axi_HP3_RUSER USER 0 1 }  { m_axi_HP3_RRESP RESP 0 2 }  { m_axi_HP3_BVALID VALID 0 1 }  { m_axi_HP3_BREADY READY 1 1 }  { m_axi_HP3_BRESP RESP 0 2 }  { m_axi_HP3_BID ID 0 1 }  { m_axi_HP3_BUSER USER 0 1 } } }
	compress_size { ap_none {  { compress_size in_data 0 32 } } }
	output_r { ap_fifo {  { output_r_dout fifo_data 0 64 }  { output_r_empty_n fifo_status 0 1 }  { output_r_read fifo_update 1 1 } } }
}
