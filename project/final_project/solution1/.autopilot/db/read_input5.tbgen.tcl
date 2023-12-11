set moduleName read_input5
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
set C_modelName {read_input5}
set C_modelType { void 0 }
set C_modelArgList {
	{ HP1 int 16 regular {axi_master 0}  }
	{ input_r int 8 regular {fifo 1 volatile }  }
	{ s1 int 64 regular  }
	{ output_r int 64 regular  }
	{ output_out int 64 regular {fifo 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "HP1", "interface" : "axi_master", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "input_r", "interface" : "fifo", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "s1", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "output_r", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "output_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 63
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ start_full_n sc_in sc_logic 1 signal -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ start_out sc_out sc_logic 1 signal -1 } 
	{ start_write sc_out sc_logic 1 signal -1 } 
	{ m_axi_HP1_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP1_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_HP1_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_HP1_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_HP1_AWLEN sc_out sc_lv 32 signal 0 } 
	{ m_axi_HP1_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_HP1_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_HP1_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_HP1_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_HP1_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_HP1_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_HP1_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_HP1_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_HP1_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP1_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_HP1_WDATA sc_out sc_lv 16 signal 0 } 
	{ m_axi_HP1_WSTRB sc_out sc_lv 2 signal 0 } 
	{ m_axi_HP1_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP1_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_HP1_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_HP1_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP1_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_HP1_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_HP1_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_HP1_ARLEN sc_out sc_lv 32 signal 0 } 
	{ m_axi_HP1_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_HP1_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_HP1_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_HP1_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_HP1_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_HP1_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_HP1_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_HP1_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_HP1_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_HP1_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP1_RDATA sc_in sc_lv 16 signal 0 } 
	{ m_axi_HP1_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_HP1_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_HP1_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_HP1_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_HP1_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_HP1_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP1_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_HP1_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_HP1_BUSER sc_in sc_lv 1 signal 0 } 
	{ input_r_din sc_out sc_lv 8 signal 1 } 
	{ input_r_full_n sc_in sc_logic 1 signal 1 } 
	{ input_r_write sc_out sc_logic 1 signal 1 } 
	{ s1 sc_in sc_lv 64 signal 2 } 
	{ output_r sc_in sc_lv 64 signal 3 } 
	{ output_out_din sc_out sc_lv 64 signal 4 } 
	{ output_out_full_n sc_in sc_logic 1 signal 4 } 
	{ output_out_write sc_out sc_logic 1 signal 4 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "start_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_full_n", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "start_out", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_out", "role": "default" }} , 
 	{ "name": "start_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_write", "role": "default" }} , 
 	{ "name": "m_axi_HP1_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "AWVALID" }} , 
 	{ "name": "m_axi_HP1_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "AWREADY" }} , 
 	{ "name": "m_axi_HP1_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP1", "role": "AWADDR" }} , 
 	{ "name": "m_axi_HP1_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "AWID" }} , 
 	{ "name": "m_axi_HP1_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP1", "role": "AWLEN" }} , 
 	{ "name": "m_axi_HP1_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP1", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_HP1_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP1", "role": "AWBURST" }} , 
 	{ "name": "m_axi_HP1_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP1", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_HP1_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP1", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_HP1_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP1", "role": "AWPROT" }} , 
 	{ "name": "m_axi_HP1_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP1", "role": "AWQOS" }} , 
 	{ "name": "m_axi_HP1_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP1", "role": "AWREGION" }} , 
 	{ "name": "m_axi_HP1_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "AWUSER" }} , 
 	{ "name": "m_axi_HP1_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "WVALID" }} , 
 	{ "name": "m_axi_HP1_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "WREADY" }} , 
 	{ "name": "m_axi_HP1_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HP1", "role": "WDATA" }} , 
 	{ "name": "m_axi_HP1_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP1", "role": "WSTRB" }} , 
 	{ "name": "m_axi_HP1_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "WLAST" }} , 
 	{ "name": "m_axi_HP1_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "WID" }} , 
 	{ "name": "m_axi_HP1_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "WUSER" }} , 
 	{ "name": "m_axi_HP1_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "ARVALID" }} , 
 	{ "name": "m_axi_HP1_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "ARREADY" }} , 
 	{ "name": "m_axi_HP1_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP1", "role": "ARADDR" }} , 
 	{ "name": "m_axi_HP1_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "ARID" }} , 
 	{ "name": "m_axi_HP1_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP1", "role": "ARLEN" }} , 
 	{ "name": "m_axi_HP1_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP1", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_HP1_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP1", "role": "ARBURST" }} , 
 	{ "name": "m_axi_HP1_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP1", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_HP1_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP1", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_HP1_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HP1", "role": "ARPROT" }} , 
 	{ "name": "m_axi_HP1_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP1", "role": "ARQOS" }} , 
 	{ "name": "m_axi_HP1_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP1", "role": "ARREGION" }} , 
 	{ "name": "m_axi_HP1_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "ARUSER" }} , 
 	{ "name": "m_axi_HP1_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "RVALID" }} , 
 	{ "name": "m_axi_HP1_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "RREADY" }} , 
 	{ "name": "m_axi_HP1_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HP1", "role": "RDATA" }} , 
 	{ "name": "m_axi_HP1_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "RLAST" }} , 
 	{ "name": "m_axi_HP1_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "RID" }} , 
 	{ "name": "m_axi_HP1_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "RUSER" }} , 
 	{ "name": "m_axi_HP1_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP1", "role": "RRESP" }} , 
 	{ "name": "m_axi_HP1_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "BVALID" }} , 
 	{ "name": "m_axi_HP1_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "BREADY" }} , 
 	{ "name": "m_axi_HP1_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP1", "role": "BRESP" }} , 
 	{ "name": "m_axi_HP1_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "BID" }} , 
 	{ "name": "m_axi_HP1_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "BUSER" }} , 
 	{ "name": "input_r_din", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "input_r", "role": "din" }} , 
 	{ "name": "input_r_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "input_r", "role": "full_n" }} , 
 	{ "name": "input_r_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "input_r", "role": "write" }} , 
 	{ "name": "s1", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "s1", "role": "default" }} , 
 	{ "name": "output_r", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "output_r", "role": "default" }} , 
 	{ "name": "output_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "output_out", "role": "din" }} , 
 	{ "name": "output_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "output_out", "role": "full_n" }} , 
 	{ "name": "output_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "output_out", "role": "write" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "read_input5",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "313", "EstimateLatencyMax" : "103617",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "HP1", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "HP1_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "HP1_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "input_r", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "500", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "input_r_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "s1", "Type" : "None", "Direction" : "I"},
			{"Name" : "output_r", "Type" : "None", "Direction" : "I"},
			{"Name" : "output_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "output_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mac_muladd_8ns_8ns_8ns_15_4_1_U1", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	read_input5 {
		HP1 {Type I LastRead 148 FirstWrite -1}
		input_r {Type O LastRead -1 FirstWrite 73}
		s1 {Type I LastRead 0 FirstWrite -1}
		output_r {Type I LastRead 0 FirstWrite -1}
		output_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "313", "Max" : "103617"}
	, {"Name" : "Interval", "Min" : "313", "Max" : "103617"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	HP1 { m_axi {  { m_axi_HP1_AWVALID VALID 1 1 }  { m_axi_HP1_AWREADY READY 0 1 }  { m_axi_HP1_AWADDR ADDR 1 64 }  { m_axi_HP1_AWID ID 1 1 }  { m_axi_HP1_AWLEN LEN 1 32 }  { m_axi_HP1_AWSIZE SIZE 1 3 }  { m_axi_HP1_AWBURST BURST 1 2 }  { m_axi_HP1_AWLOCK LOCK 1 2 }  { m_axi_HP1_AWCACHE CACHE 1 4 }  { m_axi_HP1_AWPROT PROT 1 3 }  { m_axi_HP1_AWQOS QOS 1 4 }  { m_axi_HP1_AWREGION REGION 1 4 }  { m_axi_HP1_AWUSER USER 1 1 }  { m_axi_HP1_WVALID VALID 1 1 }  { m_axi_HP1_WREADY READY 0 1 }  { m_axi_HP1_WDATA DATA 1 16 }  { m_axi_HP1_WSTRB STRB 1 2 }  { m_axi_HP1_WLAST LAST 1 1 }  { m_axi_HP1_WID ID 1 1 }  { m_axi_HP1_WUSER USER 1 1 }  { m_axi_HP1_ARVALID VALID 1 1 }  { m_axi_HP1_ARREADY READY 0 1 }  { m_axi_HP1_ARADDR ADDR 1 64 }  { m_axi_HP1_ARID ID 1 1 }  { m_axi_HP1_ARLEN LEN 1 32 }  { m_axi_HP1_ARSIZE SIZE 1 3 }  { m_axi_HP1_ARBURST BURST 1 2 }  { m_axi_HP1_ARLOCK LOCK 1 2 }  { m_axi_HP1_ARCACHE CACHE 1 4 }  { m_axi_HP1_ARPROT PROT 1 3 }  { m_axi_HP1_ARQOS QOS 1 4 }  { m_axi_HP1_ARREGION REGION 1 4 }  { m_axi_HP1_ARUSER USER 1 1 }  { m_axi_HP1_RVALID VALID 0 1 }  { m_axi_HP1_RREADY READY 1 1 }  { m_axi_HP1_RDATA DATA 0 16 }  { m_axi_HP1_RLAST LAST 0 1 }  { m_axi_HP1_RID ID 0 1 }  { m_axi_HP1_RUSER USER 0 1 }  { m_axi_HP1_RRESP RESP 0 2 }  { m_axi_HP1_BVALID VALID 0 1 }  { m_axi_HP1_BREADY READY 1 1 }  { m_axi_HP1_BRESP RESP 0 2 }  { m_axi_HP1_BID ID 0 1 }  { m_axi_HP1_BUSER USER 0 1 } } }
	input_r { ap_fifo {  { input_r_din fifo_data 1 8 }  { input_r_full_n fifo_status 0 1 }  { input_r_write fifo_update 1 1 } } }
	s1 { ap_none {  { s1 in_data 0 64 } } }
	output_r { ap_none {  { output_r in_data 0 64 } } }
	output_out { ap_fifo {  { output_out_din fifo_data 1 64 }  { output_out_full_n fifo_status 0 1 }  { output_out_write fifo_update 1 1 } } }
}
