set moduleName insert
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type function
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {insert}
set C_modelType { int 33 }
set C_modelArgList {
	{ hash_table_0 int 33 regular {array 32768 { 2 3 } 1 1 }  }
	{ hash_table_1 int 33 regular {array 32768 { 2 3 } 1 1 }  }
	{ mem_upper_key_mem int 64 regular {array 512 { 2 3 } 1 1 }  }
	{ mem_middle_key_mem int 64 regular {array 512 { 2 3 } 1 1 }  }
	{ mem_lower_key_mem int 64 regular {array 512 { 2 3 } 1 1 }  }
	{ mem_value int 12 regular {array 64 { 0 3 } 0 1 }  }
	{ mem_fill_read_5 int 32 regular  }
	{ mem_fill_read int 32 regular  }
	{ key int 20 regular  }
	{ value_r int 12 regular  }
}
set C_modelArgMapList {[ 
	{ "Name" : "hash_table_0", "interface" : "memory", "bitwidth" : 33, "direction" : "READWRITE"} , 
 	{ "Name" : "hash_table_1", "interface" : "memory", "bitwidth" : 33, "direction" : "READWRITE"} , 
 	{ "Name" : "mem_upper_key_mem", "interface" : "memory", "bitwidth" : 64, "direction" : "READWRITE"} , 
 	{ "Name" : "mem_middle_key_mem", "interface" : "memory", "bitwidth" : 64, "direction" : "READWRITE"} , 
 	{ "Name" : "mem_lower_key_mem", "interface" : "memory", "bitwidth" : 64, "direction" : "READWRITE"} , 
 	{ "Name" : "mem_value", "interface" : "memory", "bitwidth" : 12, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mem_fill_read_5", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "mem_fill_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "key", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "value_r", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 33} ]}
# RTL Port declarations: 
set portNum 42
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ap_ce sc_in sc_logic 1 ce -1 } 
	{ hash_table_0_address0 sc_out sc_lv 15 signal 0 } 
	{ hash_table_0_ce0 sc_out sc_logic 1 signal 0 } 
	{ hash_table_0_we0 sc_out sc_logic 1 signal 0 } 
	{ hash_table_0_d0 sc_out sc_lv 33 signal 0 } 
	{ hash_table_0_q0 sc_in sc_lv 33 signal 0 } 
	{ hash_table_1_address0 sc_out sc_lv 15 signal 1 } 
	{ hash_table_1_ce0 sc_out sc_logic 1 signal 1 } 
	{ hash_table_1_we0 sc_out sc_logic 1 signal 1 } 
	{ hash_table_1_d0 sc_out sc_lv 33 signal 1 } 
	{ hash_table_1_q0 sc_in sc_lv 33 signal 1 } 
	{ mem_upper_key_mem_address0 sc_out sc_lv 9 signal 2 } 
	{ mem_upper_key_mem_ce0 sc_out sc_logic 1 signal 2 } 
	{ mem_upper_key_mem_we0 sc_out sc_logic 1 signal 2 } 
	{ mem_upper_key_mem_d0 sc_out sc_lv 64 signal 2 } 
	{ mem_upper_key_mem_q0 sc_in sc_lv 64 signal 2 } 
	{ mem_middle_key_mem_address0 sc_out sc_lv 9 signal 3 } 
	{ mem_middle_key_mem_ce0 sc_out sc_logic 1 signal 3 } 
	{ mem_middle_key_mem_we0 sc_out sc_logic 1 signal 3 } 
	{ mem_middle_key_mem_d0 sc_out sc_lv 64 signal 3 } 
	{ mem_middle_key_mem_q0 sc_in sc_lv 64 signal 3 } 
	{ mem_lower_key_mem_address0 sc_out sc_lv 9 signal 4 } 
	{ mem_lower_key_mem_ce0 sc_out sc_logic 1 signal 4 } 
	{ mem_lower_key_mem_we0 sc_out sc_logic 1 signal 4 } 
	{ mem_lower_key_mem_d0 sc_out sc_lv 64 signal 4 } 
	{ mem_lower_key_mem_q0 sc_in sc_lv 64 signal 4 } 
	{ mem_value_address0 sc_out sc_lv 6 signal 5 } 
	{ mem_value_ce0 sc_out sc_logic 1 signal 5 } 
	{ mem_value_we0 sc_out sc_logic 1 signal 5 } 
	{ mem_value_d0 sc_out sc_lv 12 signal 5 } 
	{ mem_fill_read_5 sc_in sc_lv 32 signal 6 } 
	{ mem_fill_read sc_in sc_lv 32 signal 7 } 
	{ key sc_in sc_lv 20 signal 8 } 
	{ value_r sc_in sc_lv 12 signal 9 } 
	{ ap_return_0 sc_out sc_lv 32 signal -1 } 
	{ ap_return_1 sc_out sc_lv 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ap_ce", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "ce", "bundle":{"name": "ap_ce", "role": "default" }} , 
 	{ "name": "hash_table_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "hash_table_0", "role": "address0" }} , 
 	{ "name": "hash_table_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_0", "role": "ce0" }} , 
 	{ "name": "hash_table_0_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_0", "role": "we0" }} , 
 	{ "name": "hash_table_0_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":33, "type": "signal", "bundle":{"name": "hash_table_0", "role": "d0" }} , 
 	{ "name": "hash_table_0_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":33, "type": "signal", "bundle":{"name": "hash_table_0", "role": "q0" }} , 
 	{ "name": "hash_table_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "hash_table_1", "role": "address0" }} , 
 	{ "name": "hash_table_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_1", "role": "ce0" }} , 
 	{ "name": "hash_table_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hash_table_1", "role": "we0" }} , 
 	{ "name": "hash_table_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":33, "type": "signal", "bundle":{"name": "hash_table_1", "role": "d0" }} , 
 	{ "name": "hash_table_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":33, "type": "signal", "bundle":{"name": "hash_table_1", "role": "q0" }} , 
 	{ "name": "mem_upper_key_mem_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "mem_upper_key_mem", "role": "address0" }} , 
 	{ "name": "mem_upper_key_mem_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_upper_key_mem", "role": "ce0" }} , 
 	{ "name": "mem_upper_key_mem_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_upper_key_mem", "role": "we0" }} , 
 	{ "name": "mem_upper_key_mem_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_upper_key_mem", "role": "d0" }} , 
 	{ "name": "mem_upper_key_mem_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_upper_key_mem", "role": "q0" }} , 
 	{ "name": "mem_middle_key_mem_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "mem_middle_key_mem", "role": "address0" }} , 
 	{ "name": "mem_middle_key_mem_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_middle_key_mem", "role": "ce0" }} , 
 	{ "name": "mem_middle_key_mem_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_middle_key_mem", "role": "we0" }} , 
 	{ "name": "mem_middle_key_mem_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_middle_key_mem", "role": "d0" }} , 
 	{ "name": "mem_middle_key_mem_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_middle_key_mem", "role": "q0" }} , 
 	{ "name": "mem_lower_key_mem_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "mem_lower_key_mem", "role": "address0" }} , 
 	{ "name": "mem_lower_key_mem_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_lower_key_mem", "role": "ce0" }} , 
 	{ "name": "mem_lower_key_mem_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_lower_key_mem", "role": "we0" }} , 
 	{ "name": "mem_lower_key_mem_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_lower_key_mem", "role": "d0" }} , 
 	{ "name": "mem_lower_key_mem_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_lower_key_mem", "role": "q0" }} , 
 	{ "name": "mem_value_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "mem_value", "role": "address0" }} , 
 	{ "name": "mem_value_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_value", "role": "ce0" }} , 
 	{ "name": "mem_value_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_value", "role": "we0" }} , 
 	{ "name": "mem_value_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "mem_value", "role": "d0" }} , 
 	{ "name": "mem_fill_read_5", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mem_fill_read_5", "role": "default" }} , 
 	{ "name": "mem_fill_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mem_fill_read", "role": "default" }} , 
 	{ "name": "key", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "key", "role": "default" }} , 
 	{ "name": "value_r", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "value_r", "role": "default" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "insert",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Aligned", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "2",
		"VariableLatency" : "0", "ExactLatency" : "12", "EstimateLatencyMin" : "12", "EstimateLatencyMax" : "12",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "1",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "hash_table_0", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "hash_table_1", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "mem_upper_key_mem", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "mem_middle_key_mem", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "mem_lower_key_mem", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "mem_value", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "mem_fill_read_5", "Type" : "None", "Direction" : "I"},
			{"Name" : "mem_fill_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "key", "Type" : "None", "Direction" : "I"},
			{"Name" : "value_r", "Type" : "None", "Direction" : "I"}]}]}


set ArgLastReadFirstWriteLatency {
	insert {
		hash_table_0 {Type IO LastRead 10 FirstWrite 11}
		hash_table_1 {Type IO LastRead 10 FirstWrite 11}
		mem_upper_key_mem {Type IO LastRead 11 FirstWrite 12}
		mem_middle_key_mem {Type IO LastRead 11 FirstWrite 12}
		mem_lower_key_mem {Type IO LastRead 11 FirstWrite 12}
		mem_value {Type O LastRead -1 FirstWrite 11}
		mem_fill_read_5 {Type I LastRead 1 FirstWrite -1}
		mem_fill_read {Type I LastRead 1 FirstWrite -1}
		key {Type I LastRead 0 FirstWrite -1}
		value_r {Type I LastRead 1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "12", "Max" : "12"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "2"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	hash_table_0 { ap_memory {  { hash_table_0_address0 mem_address 1 15 }  { hash_table_0_ce0 mem_ce 1 1 }  { hash_table_0_we0 mem_we 1 1 }  { hash_table_0_d0 mem_din 1 33 }  { hash_table_0_q0 mem_dout 0 33 } } }
	hash_table_1 { ap_memory {  { hash_table_1_address0 mem_address 1 15 }  { hash_table_1_ce0 mem_ce 1 1 }  { hash_table_1_we0 mem_we 1 1 }  { hash_table_1_d0 mem_din 1 33 }  { hash_table_1_q0 mem_dout 0 33 } } }
	mem_upper_key_mem { ap_memory {  { mem_upper_key_mem_address0 mem_address 1 9 }  { mem_upper_key_mem_ce0 mem_ce 1 1 }  { mem_upper_key_mem_we0 mem_we 1 1 }  { mem_upper_key_mem_d0 mem_din 1 64 }  { mem_upper_key_mem_q0 mem_dout 0 64 } } }
	mem_middle_key_mem { ap_memory {  { mem_middle_key_mem_address0 mem_address 1 9 }  { mem_middle_key_mem_ce0 mem_ce 1 1 }  { mem_middle_key_mem_we0 mem_we 1 1 }  { mem_middle_key_mem_d0 mem_din 1 64 }  { mem_middle_key_mem_q0 mem_dout 0 64 } } }
	mem_lower_key_mem { ap_memory {  { mem_lower_key_mem_address0 mem_address 1 9 }  { mem_lower_key_mem_ce0 mem_ce 1 1 }  { mem_lower_key_mem_we0 mem_we 1 1 }  { mem_lower_key_mem_d0 mem_din 1 64 }  { mem_lower_key_mem_q0 mem_dout 0 64 } } }
	mem_value { ap_memory {  { mem_value_address0 mem_address 1 6 }  { mem_value_ce0 mem_ce 1 1 }  { mem_value_we0 mem_we 1 1 }  { mem_value_d0 mem_din 1 12 } } }
	mem_fill_read_5 { ap_none {  { mem_fill_read_5 in_data 0 32 } } }
	mem_fill_read { ap_none {  { mem_fill_read in_data 0 32 } } }
	key { ap_none {  { key in_data 0 20 } } }
	value_r { ap_none {  { value_r in_data 0 12 } } }
}
