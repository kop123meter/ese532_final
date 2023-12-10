set moduleName hardware_encoding_entry7
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 1
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {hardware_encoding.entry7}
set C_modelType { void 0 }
set C_modelArgList {
	{ s1 int 64 regular  }
	{ output_r int 64 regular  }
	{ lzw_size int 64 regular  }
	{ input_size int 64 regular  }
	{ s1_out int 64 regular {fifo 1}  }
	{ output_out int 64 regular {fifo 1}  }
	{ lzw_size_out int 64 regular {fifo 1}  }
	{ input_size_out int 64 regular {fifo 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "s1", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "output_r", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "lzw_size", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "input_size", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "s1_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} , 
 	{ "Name" : "output_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} , 
 	{ "Name" : "lzw_size_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} , 
 	{ "Name" : "input_size_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 26
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
	{ s1 sc_in sc_lv 64 signal 0 } 
	{ output_r sc_in sc_lv 64 signal 1 } 
	{ lzw_size sc_in sc_lv 64 signal 2 } 
	{ input_size sc_in sc_lv 64 signal 3 } 
	{ s1_out_din sc_out sc_lv 64 signal 4 } 
	{ s1_out_full_n sc_in sc_logic 1 signal 4 } 
	{ s1_out_write sc_out sc_logic 1 signal 4 } 
	{ output_out_din sc_out sc_lv 64 signal 5 } 
	{ output_out_full_n sc_in sc_logic 1 signal 5 } 
	{ output_out_write sc_out sc_logic 1 signal 5 } 
	{ lzw_size_out_din sc_out sc_lv 64 signal 6 } 
	{ lzw_size_out_full_n sc_in sc_logic 1 signal 6 } 
	{ lzw_size_out_write sc_out sc_logic 1 signal 6 } 
	{ input_size_out_din sc_out sc_lv 64 signal 7 } 
	{ input_size_out_full_n sc_in sc_logic 1 signal 7 } 
	{ input_size_out_write sc_out sc_logic 1 signal 7 } 
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
 	{ "name": "s1", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "s1", "role": "default" }} , 
 	{ "name": "output_r", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "output_r", "role": "default" }} , 
 	{ "name": "lzw_size", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "lzw_size", "role": "default" }} , 
 	{ "name": "input_size", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "input_size", "role": "default" }} , 
 	{ "name": "s1_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "s1_out", "role": "din" }} , 
 	{ "name": "s1_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "s1_out", "role": "full_n" }} , 
 	{ "name": "s1_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "s1_out", "role": "write" }} , 
 	{ "name": "output_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "output_out", "role": "din" }} , 
 	{ "name": "output_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "output_out", "role": "full_n" }} , 
 	{ "name": "output_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "output_out", "role": "write" }} , 
 	{ "name": "lzw_size_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "lzw_size_out", "role": "din" }} , 
 	{ "name": "lzw_size_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "lzw_size_out", "role": "full_n" }} , 
 	{ "name": "lzw_size_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "lzw_size_out", "role": "write" }} , 
 	{ "name": "input_size_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "input_size_out", "role": "din" }} , 
 	{ "name": "input_size_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "input_size_out", "role": "full_n" }} , 
 	{ "name": "input_size_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "input_size_out", "role": "write" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "hardware_encoding_entry7",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "0", "EstimateLatencyMin" : "0", "EstimateLatencyMax" : "0",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "s1", "Type" : "None", "Direction" : "I"},
			{"Name" : "output_r", "Type" : "None", "Direction" : "I"},
			{"Name" : "lzw_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "input_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "s1_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "s1_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "output_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "output_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "lzw_size_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "lzw_size_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "input_size_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "input_size_out_blk_n", "Type" : "RtlSignal"}]}]}]}


set ArgLastReadFirstWriteLatency {
	hardware_encoding_entry7 {
		s1 {Type I LastRead 0 FirstWrite -1}
		output_r {Type I LastRead 0 FirstWrite -1}
		lzw_size {Type I LastRead 0 FirstWrite -1}
		input_size {Type I LastRead 0 FirstWrite -1}
		s1_out {Type O LastRead -1 FirstWrite 0}
		output_out {Type O LastRead -1 FirstWrite 0}
		lzw_size_out {Type O LastRead -1 FirstWrite 0}
		input_size_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	s1 { ap_none {  { s1 in_data 0 64 } } }
	output_r { ap_none {  { output_r in_data 0 64 } } }
	lzw_size { ap_none {  { lzw_size in_data 0 64 } } }
	input_size { ap_none {  { input_size in_data 0 64 } } }
	s1_out { ap_fifo {  { s1_out_din fifo_data 1 64 }  { s1_out_full_n fifo_status 0 1 }  { s1_out_write fifo_update 1 1 } } }
	output_out { ap_fifo {  { output_out_din fifo_data 1 64 }  { output_out_full_n fifo_status 0 1 }  { output_out_write fifo_update 1 1 } } }
	lzw_size_out { ap_fifo {  { lzw_size_out_din fifo_data 1 64 }  { lzw_size_out_full_n fifo_status 0 1 }  { lzw_size_out_write fifo_update 1 1 } } }
	input_size_out { ap_fifo {  { input_size_out_din fifo_data 1 64 }  { input_size_out_full_n fifo_status 0 1 }  { input_size_out_write fifo_update 1 1 } } }
}
