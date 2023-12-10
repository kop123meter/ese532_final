set moduleName Block_split28_proc
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
set C_modelName {Block_.split28_proc}
set C_modelType { void 0 }
set C_modelArgList {
	{ compress_size_0 int 32 regular {fifo 0}  }
	{ lzw_size int 64 regular {fifo 0}  }
	{ HP0 int 32 regular {axi_master 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "compress_size_0", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "lzw_size", "interface" : "fifo", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "HP0", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 58
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ compress_size_0_dout sc_in sc_lv 32 signal 0 } 
	{ compress_size_0_empty_n sc_in sc_logic 1 signal 0 } 
	{ compress_size_0_read sc_out sc_logic 1 signal 0 } 
	{ lzw_size_dout sc_in sc_lv 64 signal 1 } 
	{ lzw_size_empty_n sc_in sc_logic 1 signal 1 } 
	{ lzw_size_read sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP0_AWVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_HP0_AWREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_HP0_AWADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_HP0_AWID sc_out sc_lv 1 signal 2 } 
	{ m_axi_HP0_AWLEN sc_out sc_lv 32 signal 2 } 
	{ m_axi_HP0_AWSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_HP0_AWBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_HP0_AWLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_HP0_AWCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_HP0_AWPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_HP0_AWQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_HP0_AWREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_HP0_AWUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_HP0_WVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_HP0_WREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_HP0_WDATA sc_out sc_lv 32 signal 2 } 
	{ m_axi_HP0_WSTRB sc_out sc_lv 4 signal 2 } 
	{ m_axi_HP0_WLAST sc_out sc_logic 1 signal 2 } 
	{ m_axi_HP0_WID sc_out sc_lv 1 signal 2 } 
	{ m_axi_HP0_WUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_HP0_ARVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_HP0_ARREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_HP0_ARADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_HP0_ARID sc_out sc_lv 1 signal 2 } 
	{ m_axi_HP0_ARLEN sc_out sc_lv 32 signal 2 } 
	{ m_axi_HP0_ARSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_HP0_ARBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_HP0_ARLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_HP0_ARCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_HP0_ARPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_HP0_ARQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_HP0_ARREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_HP0_ARUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_HP0_RVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_HP0_RREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_HP0_RDATA sc_in sc_lv 32 signal 2 } 
	{ m_axi_HP0_RLAST sc_in sc_logic 1 signal 2 } 
	{ m_axi_HP0_RID sc_in sc_lv 1 signal 2 } 
	{ m_axi_HP0_RUSER sc_in sc_lv 1 signal 2 } 
	{ m_axi_HP0_RRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_HP0_BVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_HP0_BREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_HP0_BRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_HP0_BID sc_in sc_lv 1 signal 2 } 
	{ m_axi_HP0_BUSER sc_in sc_lv 1 signal 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "compress_size_0_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compress_size_0", "role": "dout" }} , 
 	{ "name": "compress_size_0_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compress_size_0", "role": "empty_n" }} , 
 	{ "name": "compress_size_0_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compress_size_0", "role": "read" }} , 
 	{ "name": "lzw_size_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "lzw_size", "role": "dout" }} , 
 	{ "name": "lzw_size_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "lzw_size", "role": "empty_n" }} , 
 	{ "name": "lzw_size_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "lzw_size", "role": "read" }} , 
 	{ "name": "m_axi_HP0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "AWVALID" }} , 
 	{ "name": "m_axi_HP0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "AWREADY" }} , 
 	{ "name": "m_axi_HP0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP0", "role": "AWADDR" }} , 
 	{ "name": "m_axi_HP0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "AWID" }} , 
 	{ "name": "m_axi_HP0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP0", "role": "AWLEN" }} , 
 	{ "name": "m_axi_HP0_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP0", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_HP0_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP0", "role": "AWBURST" }} , 
 	{ "name": "m_axi_HP0_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP0", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_HP0_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP0", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_HP0_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP0", "role": "AWPROT" }} , 
 	{ "name": "m_axi_HP0_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP0", "role": "AWQOS" }} , 
 	{ "name": "m_axi_HP0_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP0", "role": "AWREGION" }} , 
 	{ "name": "m_axi_HP0_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "AWUSER" }} , 
 	{ "name": "m_axi_HP0_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "WVALID" }} , 
 	{ "name": "m_axi_HP0_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "WREADY" }} , 
 	{ "name": "m_axi_HP0_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP0", "role": "WDATA" }} , 
 	{ "name": "m_axi_HP0_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP0", "role": "WSTRB" }} , 
 	{ "name": "m_axi_HP0_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "WLAST" }} , 
 	{ "name": "m_axi_HP0_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "WID" }} , 
 	{ "name": "m_axi_HP0_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "WUSER" }} , 
 	{ "name": "m_axi_HP0_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "ARVALID" }} , 
 	{ "name": "m_axi_HP0_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "ARREADY" }} , 
 	{ "name": "m_axi_HP0_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP0", "role": "ARADDR" }} , 
 	{ "name": "m_axi_HP0_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "ARID" }} , 
 	{ "name": "m_axi_HP0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP0", "role": "ARLEN" }} , 
 	{ "name": "m_axi_HP0_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP0", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_HP0_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP0", "role": "ARBURST" }} , 
 	{ "name": "m_axi_HP0_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP0", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_HP0_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP0", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_HP0_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP0", "role": "ARPROT" }} , 
 	{ "name": "m_axi_HP0_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP0", "role": "ARQOS" }} , 
 	{ "name": "m_axi_HP0_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP0", "role": "ARREGION" }} , 
 	{ "name": "m_axi_HP0_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "ARUSER" }} , 
 	{ "name": "m_axi_HP0_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "RVALID" }} , 
 	{ "name": "m_axi_HP0_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "RREADY" }} , 
 	{ "name": "m_axi_HP0_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP0", "role": "RDATA" }} , 
 	{ "name": "m_axi_HP0_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "RLAST" }} , 
 	{ "name": "m_axi_HP0_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "RID" }} , 
 	{ "name": "m_axi_HP0_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "RUSER" }} , 
 	{ "name": "m_axi_HP0_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP0", "role": "RRESP" }} , 
 	{ "name": "m_axi_HP0_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "BVALID" }} , 
 	{ "name": "m_axi_HP0_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "BREADY" }} , 
 	{ "name": "m_axi_HP0_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP0", "role": "BRESP" }} , 
 	{ "name": "m_axi_HP0_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "BID" }} , 
 	{ "name": "m_axi_HP0_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "Block_split28_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "70", "EstimateLatencyMax" : "70",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "compress_size_0", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "compress_size_0_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "lzw_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "lzw_size_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "HP0", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "HP0_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "HP0_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "HP0_blk_n_B", "Type" : "RtlSignal"}]}]}]}


set ArgLastReadFirstWriteLatency {
	Block_split28_proc {
		compress_size_0 {Type I LastRead 0 FirstWrite -1}
		lzw_size {Type I LastRead 0 FirstWrite -1}
		HP0 {Type O LastRead 3 FirstWrite 2}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "70", "Max" : "70"}
	, {"Name" : "Interval", "Min" : "70", "Max" : "70"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	compress_size_0 { ap_fifo {  { compress_size_0_dout fifo_data 0 32 }  { compress_size_0_empty_n fifo_status 0 1 }  { compress_size_0_read fifo_update 1 1 } } }
	lzw_size { ap_fifo {  { lzw_size_dout fifo_data 0 64 }  { lzw_size_empty_n fifo_status 0 1 }  { lzw_size_read fifo_update 1 1 } } }
	HP0 { m_axi {  { m_axi_HP0_AWVALID VALID 1 1 }  { m_axi_HP0_AWREADY READY 0 1 }  { m_axi_HP0_AWADDR ADDR 1 64 }  { m_axi_HP0_AWID ID 1 1 }  { m_axi_HP0_AWLEN LEN 1 32 }  { m_axi_HP0_AWSIZE SIZE 1 3 }  { m_axi_HP0_AWBURST BURST 1 2 }  { m_axi_HP0_AWLOCK LOCK 1 2 }  { m_axi_HP0_AWCACHE CACHE 1 4 }  { m_axi_HP0_AWPROT PROT 1 3 }  { m_axi_HP0_AWQOS QOS 1 4 }  { m_axi_HP0_AWREGION REGION 1 4 }  { m_axi_HP0_AWUSER USER 1 1 }  { m_axi_HP0_WVALID VALID 1 1 }  { m_axi_HP0_WREADY READY 0 1 }  { m_axi_HP0_WDATA DATA 1 32 }  { m_axi_HP0_WSTRB STRB 1 4 }  { m_axi_HP0_WLAST LAST 1 1 }  { m_axi_HP0_WID ID 1 1 }  { m_axi_HP0_WUSER USER 1 1 }  { m_axi_HP0_ARVALID VALID 1 1 }  { m_axi_HP0_ARREADY READY 0 1 }  { m_axi_HP0_ARADDR ADDR 1 64 }  { m_axi_HP0_ARID ID 1 1 }  { m_axi_HP0_ARLEN LEN 1 32 }  { m_axi_HP0_ARSIZE SIZE 1 3 }  { m_axi_HP0_ARBURST BURST 1 2 }  { m_axi_HP0_ARLOCK LOCK 1 2 }  { m_axi_HP0_ARCACHE CACHE 1 4 }  { m_axi_HP0_ARPROT PROT 1 3 }  { m_axi_HP0_ARQOS QOS 1 4 }  { m_axi_HP0_ARREGION REGION 1 4 }  { m_axi_HP0_ARUSER USER 1 1 }  { m_axi_HP0_RVALID VALID 0 1 }  { m_axi_HP0_RREADY READY 1 1 }  { m_axi_HP0_RDATA DATA 0 32 }  { m_axi_HP0_RLAST LAST 0 1 }  { m_axi_HP0_RID ID 0 1 }  { m_axi_HP0_RUSER USER 0 1 }  { m_axi_HP0_RRESP RESP 0 2 }  { m_axi_HP0_BVALID VALID 0 1 }  { m_axi_HP0_BREADY READY 1 1 }  { m_axi_HP0_BRESP RESP 0 2 }  { m_axi_HP0_BID ID 0 1 }  { m_axi_HP0_BUSER USER 0 1 } } }
}
