set moduleName assoc_lookup
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
set C_modelName {assoc_lookup}
set C_modelType { int 33 }
set C_modelArgList {
	{ mem_upper_key_mem int 64 regular {array 512 { 1 3 } 1 1 }  }
	{ mem_middle_key_mem int 64 regular {array 512 { 1 3 } 1 1 }  }
	{ mem_lower_key_mem int 64 regular {array 512 { 1 3 } 1 1 }  }
	{ mem_value int 12 regular {array 64 { 1 3 } 1 1 }  }
	{ key int 20 regular  }
}
set C_modelArgMapList {[ 
	{ "Name" : "mem_upper_key_mem", "interface" : "memory", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "mem_middle_key_mem", "interface" : "memory", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "mem_lower_key_mem", "interface" : "memory", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "mem_value", "interface" : "memory", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "key", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 33} ]}
# RTL Port declarations: 
set portNum 21
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ mem_upper_key_mem_address0 sc_out sc_lv 9 signal 0 } 
	{ mem_upper_key_mem_ce0 sc_out sc_logic 1 signal 0 } 
	{ mem_upper_key_mem_q0 sc_in sc_lv 64 signal 0 } 
	{ mem_middle_key_mem_address0 sc_out sc_lv 9 signal 1 } 
	{ mem_middle_key_mem_ce0 sc_out sc_logic 1 signal 1 } 
	{ mem_middle_key_mem_q0 sc_in sc_lv 64 signal 1 } 
	{ mem_lower_key_mem_address0 sc_out sc_lv 9 signal 2 } 
	{ mem_lower_key_mem_ce0 sc_out sc_logic 1 signal 2 } 
	{ mem_lower_key_mem_q0 sc_in sc_lv 64 signal 2 } 
	{ mem_value_address0 sc_out sc_lv 6 signal 3 } 
	{ mem_value_ce0 sc_out sc_logic 1 signal 3 } 
	{ mem_value_q0 sc_in sc_lv 12 signal 3 } 
	{ key sc_in sc_lv 20 signal 4 } 
	{ ap_return_0 sc_out sc_lv 1 signal -1 } 
	{ ap_return_1 sc_out sc_lv 32 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "mem_upper_key_mem_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "mem_upper_key_mem", "role": "address0" }} , 
 	{ "name": "mem_upper_key_mem_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_upper_key_mem", "role": "ce0" }} , 
 	{ "name": "mem_upper_key_mem_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_upper_key_mem", "role": "q0" }} , 
 	{ "name": "mem_middle_key_mem_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "mem_middle_key_mem", "role": "address0" }} , 
 	{ "name": "mem_middle_key_mem_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_middle_key_mem", "role": "ce0" }} , 
 	{ "name": "mem_middle_key_mem_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_middle_key_mem", "role": "q0" }} , 
 	{ "name": "mem_lower_key_mem_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "mem_lower_key_mem", "role": "address0" }} , 
 	{ "name": "mem_lower_key_mem_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_lower_key_mem", "role": "ce0" }} , 
 	{ "name": "mem_lower_key_mem_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_lower_key_mem", "role": "q0" }} , 
 	{ "name": "mem_value_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "mem_value", "role": "address0" }} , 
 	{ "name": "mem_value_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_value", "role": "ce0" }} , 
 	{ "name": "mem_value_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "mem_value", "role": "q0" }} , 
 	{ "name": "key", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "key", "role": "default" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "assoc_lookup",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2", "EstimateLatencyMax" : "4",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "mem_upper_key_mem", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "mem_middle_key_mem", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "mem_lower_key_mem", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "mem_value", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "key", "Type" : "None", "Direction" : "I"}]}]}


set ArgLastReadFirstWriteLatency {
	assoc_lookup {
		mem_upper_key_mem {Type I LastRead 0 FirstWrite -1}
		mem_middle_key_mem {Type I LastRead 0 FirstWrite -1}
		mem_lower_key_mem {Type I LastRead 0 FirstWrite -1}
		mem_value {Type I LastRead 2 FirstWrite -1}
		key {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "2", "Max" : "4"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "4"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	mem_upper_key_mem { ap_memory {  { mem_upper_key_mem_address0 mem_address 1 9 }  { mem_upper_key_mem_ce0 mem_ce 1 1 }  { mem_upper_key_mem_q0 mem_dout 0 64 } } }
	mem_middle_key_mem { ap_memory {  { mem_middle_key_mem_address0 mem_address 1 9 }  { mem_middle_key_mem_ce0 mem_ce 1 1 }  { mem_middle_key_mem_q0 mem_dout 0 64 } } }
	mem_lower_key_mem { ap_memory {  { mem_lower_key_mem_address0 mem_address 1 9 }  { mem_lower_key_mem_ce0 mem_ce 1 1 }  { mem_lower_key_mem_q0 mem_dout 0 64 } } }
	mem_value { ap_memory {  { mem_value_address0 mem_address 1 6 }  { mem_value_ce0 mem_ce 1 1 }  { mem_value_q0 mem_dout 0 12 } } }
	key { ap_none {  { key in_data 0 20 } } }
}
