set moduleName hardware_encoding
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type dataflow
set FunctionProtocol ap_ctrl_chain
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {hardware_encoding}
set C_modelType { void 0 }
set C_modelArgList {
	{ HP1 int 32 regular {axi_master 0}  }
	{ HP3 int 16 regular {axi_master 1}  }
	{ HP0 int 32 regular {axi_master 1}  }
	{ s1 int 64 regular {axi_slave 0}  }
	{ output_r int 64 regular {axi_slave 0}  }
	{ lzw_size int 64 regular {axi_slave 0}  }
	{ input_size int 64 regular {axi_slave 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "HP1", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "s1","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "s1","bundle": "control"},"direction": "READONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]},{"cName": "input_size","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "input_size","bundle": "control"},"direction": "READONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "HP3", "interface" : "axi_master", "bitwidth" : 16, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "output","cData": "short","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "output_r","bundle": "control"},"direction": "WRITEONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "HP0", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "lzw_size","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "lzw_size","bundle": "control"},"direction": "WRITEONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "s1", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":27}} , 
 	{ "Name" : "output_r", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":28}, "offset_end" : {"in":39}} , 
 	{ "Name" : "lzw_size", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":40}, "offset_end" : {"in":51}} , 
 	{ "Name" : "input_size", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":52}, "offset_end" : {"in":63}} ]}
# RTL Port declarations: 
set portNum 155
set portList { 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_control_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_BRESP sc_out sc_lv 2 signal -1 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
	{ m_axi_HP1_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP1_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_HP1_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_HP1_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_HP1_AWLEN sc_out sc_lv 8 signal 0 } 
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
	{ m_axi_HP1_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_HP1_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_HP1_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP1_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_HP1_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_HP1_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP1_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_HP1_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_HP1_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_HP1_ARLEN sc_out sc_lv 8 signal 0 } 
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
	{ m_axi_HP1_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_HP1_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_HP1_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_HP1_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_HP1_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_HP1_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_HP1_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_HP1_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_HP1_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_HP1_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_HP3_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP3_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_HP3_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_HP3_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_HP3_AWLEN sc_out sc_lv 8 signal 1 } 
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
	{ m_axi_HP3_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_HP3_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_HP3_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP3_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_HP3_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_HP3_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP3_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_HP3_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_HP3_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_HP3_ARLEN sc_out sc_lv 8 signal 1 } 
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
	{ m_axi_HP3_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_HP3_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_HP3_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_HP3_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_HP3_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_HP3_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_HP3_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_HP3_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_HP3_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_HP3_BUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_HP0_AWVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_HP0_AWREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_HP0_AWADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_HP0_AWID sc_out sc_lv 1 signal 2 } 
	{ m_axi_HP0_AWLEN sc_out sc_lv 8 signal 2 } 
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
	{ m_axi_HP0_ARLEN sc_out sc_lv 8 signal 2 } 
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
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"hardware_encoding","role":"start","value":"0","valid_bit":"0"},{"name":"hardware_encoding","role":"continue","value":"0","valid_bit":"4"},{"name":"hardware_encoding","role":"auto_start","value":"0","valid_bit":"7"},{"name":"s1","role":"data","value":"16"},{"name":"output_r","role":"data","value":"28"},{"name":"lzw_size","role":"data","value":"40"},{"name":"input_size","role":"data","value":"52"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"hardware_encoding","role":"start","value":"0","valid_bit":"0"},{"name":"hardware_encoding","role":"done","value":"0","valid_bit":"1"},{"name":"hardware_encoding","role":"idle","value":"0","valid_bit":"2"},{"name":"hardware_encoding","role":"ready","value":"0","valid_bit":"3"},{"name":"hardware_encoding","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_control_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARVALID" } },
	{ "name": "s_axi_control_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARREADY" } },
	{ "name": "s_axi_control_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RVALID" } },
	{ "name": "s_axi_control_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RREADY" } },
	{ "name": "s_axi_control_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "RDATA" } },
	{ "name": "s_axi_control_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "RRESP" } },
	{ "name": "s_axi_control_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BVALID" } },
	{ "name": "s_axi_control_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BREADY" } },
	{ "name": "s_axi_control_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "m_axi_HP1_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "AWVALID" }} , 
 	{ "name": "m_axi_HP1_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "AWREADY" }} , 
 	{ "name": "m_axi_HP1_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP1", "role": "AWADDR" }} , 
 	{ "name": "m_axi_HP1_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "AWID" }} , 
 	{ "name": "m_axi_HP1_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HP1", "role": "AWLEN" }} , 
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
 	{ "name": "m_axi_HP1_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP1", "role": "WDATA" }} , 
 	{ "name": "m_axi_HP1_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP1", "role": "WSTRB" }} , 
 	{ "name": "m_axi_HP1_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "WLAST" }} , 
 	{ "name": "m_axi_HP1_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "WID" }} , 
 	{ "name": "m_axi_HP1_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "WUSER" }} , 
 	{ "name": "m_axi_HP1_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "ARVALID" }} , 
 	{ "name": "m_axi_HP1_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "ARREADY" }} , 
 	{ "name": "m_axi_HP1_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP1", "role": "ARADDR" }} , 
 	{ "name": "m_axi_HP1_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "ARID" }} , 
 	{ "name": "m_axi_HP1_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HP1", "role": "ARLEN" }} , 
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
 	{ "name": "m_axi_HP1_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP1", "role": "RDATA" }} , 
 	{ "name": "m_axi_HP1_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "RLAST" }} , 
 	{ "name": "m_axi_HP1_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "RID" }} , 
 	{ "name": "m_axi_HP1_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "RUSER" }} , 
 	{ "name": "m_axi_HP1_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP1", "role": "RRESP" }} , 
 	{ "name": "m_axi_HP1_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "BVALID" }} , 
 	{ "name": "m_axi_HP1_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "BREADY" }} , 
 	{ "name": "m_axi_HP1_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP1", "role": "BRESP" }} , 
 	{ "name": "m_axi_HP1_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "BID" }} , 
 	{ "name": "m_axi_HP1_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP1", "role": "BUSER" }} , 
 	{ "name": "m_axi_HP3_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "AWVALID" }} , 
 	{ "name": "m_axi_HP3_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "AWREADY" }} , 
 	{ "name": "m_axi_HP3_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP3", "role": "AWADDR" }} , 
 	{ "name": "m_axi_HP3_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "AWID" }} , 
 	{ "name": "m_axi_HP3_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HP3", "role": "AWLEN" }} , 
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
 	{ "name": "m_axi_HP3_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP3", "role": "WDATA" }} , 
 	{ "name": "m_axi_HP3_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "HP3", "role": "WSTRB" }} , 
 	{ "name": "m_axi_HP3_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "WLAST" }} , 
 	{ "name": "m_axi_HP3_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "WID" }} , 
 	{ "name": "m_axi_HP3_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "WUSER" }} , 
 	{ "name": "m_axi_HP3_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "ARVALID" }} , 
 	{ "name": "m_axi_HP3_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "ARREADY" }} , 
 	{ "name": "m_axi_HP3_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP3", "role": "ARADDR" }} , 
 	{ "name": "m_axi_HP3_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "ARID" }} , 
 	{ "name": "m_axi_HP3_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HP3", "role": "ARLEN" }} , 
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
 	{ "name": "m_axi_HP3_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "HP3", "role": "RDATA" }} , 
 	{ "name": "m_axi_HP3_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "RLAST" }} , 
 	{ "name": "m_axi_HP3_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "RID" }} , 
 	{ "name": "m_axi_HP3_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "RUSER" }} , 
 	{ "name": "m_axi_HP3_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP3", "role": "RRESP" }} , 
 	{ "name": "m_axi_HP3_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "BVALID" }} , 
 	{ "name": "m_axi_HP3_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "BREADY" }} , 
 	{ "name": "m_axi_HP3_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HP3", "role": "BRESP" }} , 
 	{ "name": "m_axi_HP3_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "BID" }} , 
 	{ "name": "m_axi_HP3_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP3", "role": "BUSER" }} , 
 	{ "name": "m_axi_HP0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "AWVALID" }} , 
 	{ "name": "m_axi_HP0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "AWREADY" }} , 
 	{ "name": "m_axi_HP0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "HP0", "role": "AWADDR" }} , 
 	{ "name": "m_axi_HP0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HP0", "role": "AWID" }} , 
 	{ "name": "m_axi_HP0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HP0", "role": "AWLEN" }} , 
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
 	{ "name": "m_axi_HP0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HP0", "role": "ARLEN" }} , 
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
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27"],
		"CDFG" : "hardware_encoding",
		"Protocol" : "ap_ctrl_chain",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "5", "Name" : "hardware_encoding_entry7_U0"},
			{"ID" : "6", "Name" : "read_input_U0"}],
		"OutputProcess" : [
			{"ID" : "15", "Name" : "write_output_U0"},
			{"ID" : "16", "Name" : "Block_split28_proc_U0"}],
		"Port" : [
			{"Name" : "HP1", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "read_input_U0", "Port" : "HP1"}]},
			{"Name" : "HP3", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "15", "SubInstance" : "write_output_U0", "Port" : "HP3"}]},
			{"Name" : "HP0", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "16", "SubInstance" : "Block_split28_proc_U0", "Port" : "HP0"}]},
			{"Name" : "s1", "Type" : "None", "Direction" : "I"},
			{"Name" : "output_r", "Type" : "None", "Direction" : "I"},
			{"Name" : "lzw_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "input_size", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.control_s_axi_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.HP1_m_axi_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.HP3_m_axi_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.HP0_m_axi_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.hardware_encoding_entry7_U0", "Parent" : "0",
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
			{"Name" : "s1_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "6", "DependentChan" : "17", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "s1_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "output_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "15", "DependentChan" : "18", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "output_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "lzw_size_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "16", "DependentChan" : "19", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "lzw_size_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "input_size_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "6", "DependentChan" : "20", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "input_size_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.read_input_U0", "Parent" : "0",
		"CDFG" : "read_input",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
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
			{"Name" : "input_r", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "7", "DependentChan" : "21", "DependentChanDepth" : "75", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "input_r_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "inputsize", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "7", "DependentChan" : "22", "DependentChanDepth" : "75", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "inputsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "s1", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "5", "DependentChan" : "17", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "s1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "input_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "5", "DependentChan" : "20", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "input_size_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.computing_U0", "Parent" : "0", "Child" : ["8", "9", "10", "11", "12", "13", "14"],
		"CDFG" : "computing",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"StartSource" : "6",
		"StartFifo" : "start_for_computing_U0_U",
		"Port" : [
			{"Name" : "input_2", "Type" : "Vld", "Direction" : "O", "DependentProc" : "15", "DependentChan" : "23", "DependentChanDepth" : "2", "DependentChanType" : "1"},
			{"Name" : "input_r", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "6", "DependentChan" : "21", "DependentChanDepth" : "75", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "input_r_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "output_r", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "15", "DependentChan" : "24", "DependentChanDepth" : "75", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "output_r_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "inputsize", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "6", "DependentChan" : "22", "DependentChanDepth" : "75", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "inputsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "compress_size_0_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "16", "DependentChan" : "25", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "compress_size_0_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.computing_U0.hash_table_0_U", "Parent" : "7"},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.computing_U0.hash_table_1_U", "Parent" : "7"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.computing_U0.my_assoc_mem_upper_key_mem_U", "Parent" : "7"},
	{"ID" : "11", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.computing_U0.my_assoc_mem_middle_key_mem_U", "Parent" : "7"},
	{"ID" : "12", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.computing_U0.my_assoc_mem_lower_key_mem_U", "Parent" : "7"},
	{"ID" : "13", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.computing_U0.my_assoc_mem_value_U", "Parent" : "7"},
	{"ID" : "14", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.computing_U0.grp_assoc_lookup_fu_432", "Parent" : "7",
		"CDFG" : "assoc_lookup",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Aligned", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "2", "EstimateLatencyMin" : "2", "EstimateLatencyMax" : "2",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "1",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "mem_upper_key_mem", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "mem_middle_key_mem", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "mem_lower_key_mem", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "mem_value", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "key", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "15", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.write_output_U0", "Parent" : "0",
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
			{"Name" : "output_stream", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "24", "DependentChanDepth" : "75", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "output_stream_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "HP3", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "HP3_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "HP3_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "HP3_blk_n_B", "Type" : "RtlSignal"}]},
			{"Name" : "compress_size", "Type" : "None", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "23", "DependentChanDepth" : "2", "DependentChanType" : "1"},
			{"Name" : "output_r", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "5", "DependentChan" : "18", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "output_r_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "16", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Block_split28_proc_U0", "Parent" : "0",
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
		"StartSource" : "5",
		"StartFifo" : "start_for_Block_split28_proc_U0_U",
		"Port" : [
			{"Name" : "compress_size_0", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "25", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "compress_size_0_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "lzw_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "5", "DependentChan" : "19", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "lzw_size_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "HP0", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "HP0_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "HP0_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "HP0_blk_n_B", "Type" : "RtlSignal"}]}]},
	{"ID" : "17", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.s1_c_U", "Parent" : "0"},
	{"ID" : "18", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.output_c_U", "Parent" : "0"},
	{"ID" : "19", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.lzw_size_c_U", "Parent" : "0"},
	{"ID" : "20", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.input_size_c_U", "Parent" : "0"},
	{"ID" : "21", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.input_stream_U", "Parent" : "0"},
	{"ID" : "22", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.inputsize_stream_U", "Parent" : "0"},
	{"ID" : "23", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.p_channel_U", "Parent" : "0"},
	{"ID" : "24", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.output_stream_U", "Parent" : "0"},
	{"ID" : "25", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compress_size_0_c_U", "Parent" : "0"},
	{"ID" : "26", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.start_for_Block_split28_proc_U0_U", "Parent" : "0"},
	{"ID" : "27", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.start_for_computing_U0_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	hardware_encoding {
		HP1 {Type I LastRead 144 FirstWrite -1}
		HP3 {Type O LastRead 3 FirstWrite 4}
		HP0 {Type O LastRead 3 FirstWrite 2}
		s1 {Type I LastRead 0 FirstWrite -1}
		output_r {Type I LastRead 0 FirstWrite -1}
		lzw_size {Type I LastRead 0 FirstWrite -1}
		input_size {Type I LastRead 0 FirstWrite -1}}
	hardware_encoding_entry7 {
		s1 {Type I LastRead 0 FirstWrite -1}
		output_r {Type I LastRead 0 FirstWrite -1}
		lzw_size {Type I LastRead 0 FirstWrite -1}
		input_size {Type I LastRead 0 FirstWrite -1}
		s1_out {Type O LastRead -1 FirstWrite 0}
		output_out {Type O LastRead -1 FirstWrite 0}
		lzw_size_out {Type O LastRead -1 FirstWrite 0}
		input_size_out {Type O LastRead -1 FirstWrite 0}}
	read_input {
		HP1 {Type I LastRead 144 FirstWrite -1}
		input_r {Type O LastRead -1 FirstWrite 145}
		inputsize {Type O LastRead -1 FirstWrite 72}
		s1 {Type I LastRead 0 FirstWrite -1}
		input_size {Type I LastRead 0 FirstWrite -1}}
	computing {
		input_2 {Type O LastRead -1 FirstWrite 22}
		input_r {Type I LastRead 6 FirstWrite -1}
		output_r {Type O LastRead -1 FirstWrite 21}
		inputsize {Type I LastRead 4 FirstWrite -1}
		compress_size_0_out {Type O LastRead -1 FirstWrite 22}}
	assoc_lookup {
		mem_upper_key_mem {Type I LastRead 0 FirstWrite -1}
		mem_middle_key_mem {Type I LastRead 0 FirstWrite -1}
		mem_lower_key_mem {Type I LastRead 0 FirstWrite -1}
		mem_value {Type I LastRead 1 FirstWrite -1}
		key {Type I LastRead 0 FirstWrite -1}}
	write_output {
		output_stream {Type I LastRead 3 FirstWrite -1}
		HP3 {Type O LastRead 3 FirstWrite 4}
		compress_size {Type I LastRead 0 FirstWrite -1}
		output_r {Type I LastRead 0 FirstWrite -1}}
	Block_split28_proc {
		compress_size_0 {Type I LastRead 0 FirstWrite -1}
		lzw_size {Type I LastRead 0 FirstWrite -1}
		HP0 {Type O LastRead 3 FirstWrite 2}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	HP1 { m_axi {  { m_axi_HP1_AWVALID VALID 1 1 }  { m_axi_HP1_AWREADY READY 0 1 }  { m_axi_HP1_AWADDR ADDR 1 64 }  { m_axi_HP1_AWID ID 1 1 }  { m_axi_HP1_AWLEN LEN 1 8 }  { m_axi_HP1_AWSIZE SIZE 1 3 }  { m_axi_HP1_AWBURST BURST 1 2 }  { m_axi_HP1_AWLOCK LOCK 1 2 }  { m_axi_HP1_AWCACHE CACHE 1 4 }  { m_axi_HP1_AWPROT PROT 1 3 }  { m_axi_HP1_AWQOS QOS 1 4 }  { m_axi_HP1_AWREGION REGION 1 4 }  { m_axi_HP1_AWUSER USER 1 1 }  { m_axi_HP1_WVALID VALID 1 1 }  { m_axi_HP1_WREADY READY 0 1 }  { m_axi_HP1_WDATA DATA 1 32 }  { m_axi_HP1_WSTRB STRB 1 4 }  { m_axi_HP1_WLAST LAST 1 1 }  { m_axi_HP1_WID ID 1 1 }  { m_axi_HP1_WUSER USER 1 1 }  { m_axi_HP1_ARVALID VALID 1 1 }  { m_axi_HP1_ARREADY READY 0 1 }  { m_axi_HP1_ARADDR ADDR 1 64 }  { m_axi_HP1_ARID ID 1 1 }  { m_axi_HP1_ARLEN LEN 1 8 }  { m_axi_HP1_ARSIZE SIZE 1 3 }  { m_axi_HP1_ARBURST BURST 1 2 }  { m_axi_HP1_ARLOCK LOCK 1 2 }  { m_axi_HP1_ARCACHE CACHE 1 4 }  { m_axi_HP1_ARPROT PROT 1 3 }  { m_axi_HP1_ARQOS QOS 1 4 }  { m_axi_HP1_ARREGION REGION 1 4 }  { m_axi_HP1_ARUSER USER 1 1 }  { m_axi_HP1_RVALID VALID 0 1 }  { m_axi_HP1_RREADY READY 1 1 }  { m_axi_HP1_RDATA DATA 0 32 }  { m_axi_HP1_RLAST LAST 0 1 }  { m_axi_HP1_RID ID 0 1 }  { m_axi_HP1_RUSER USER 0 1 }  { m_axi_HP1_RRESP RESP 0 2 }  { m_axi_HP1_BVALID VALID 0 1 }  { m_axi_HP1_BREADY READY 1 1 }  { m_axi_HP1_BRESP RESP 0 2 }  { m_axi_HP1_BID ID 0 1 }  { m_axi_HP1_BUSER USER 0 1 } } }
	HP3 { m_axi {  { m_axi_HP3_AWVALID VALID 1 1 }  { m_axi_HP3_AWREADY READY 0 1 }  { m_axi_HP3_AWADDR ADDR 1 64 }  { m_axi_HP3_AWID ID 1 1 }  { m_axi_HP3_AWLEN LEN 1 8 }  { m_axi_HP3_AWSIZE SIZE 1 3 }  { m_axi_HP3_AWBURST BURST 1 2 }  { m_axi_HP3_AWLOCK LOCK 1 2 }  { m_axi_HP3_AWCACHE CACHE 1 4 }  { m_axi_HP3_AWPROT PROT 1 3 }  { m_axi_HP3_AWQOS QOS 1 4 }  { m_axi_HP3_AWREGION REGION 1 4 }  { m_axi_HP3_AWUSER USER 1 1 }  { m_axi_HP3_WVALID VALID 1 1 }  { m_axi_HP3_WREADY READY 0 1 }  { m_axi_HP3_WDATA DATA 1 32 }  { m_axi_HP3_WSTRB STRB 1 4 }  { m_axi_HP3_WLAST LAST 1 1 }  { m_axi_HP3_WID ID 1 1 }  { m_axi_HP3_WUSER USER 1 1 }  { m_axi_HP3_ARVALID VALID 1 1 }  { m_axi_HP3_ARREADY READY 0 1 }  { m_axi_HP3_ARADDR ADDR 1 64 }  { m_axi_HP3_ARID ID 1 1 }  { m_axi_HP3_ARLEN LEN 1 8 }  { m_axi_HP3_ARSIZE SIZE 1 3 }  { m_axi_HP3_ARBURST BURST 1 2 }  { m_axi_HP3_ARLOCK LOCK 1 2 }  { m_axi_HP3_ARCACHE CACHE 1 4 }  { m_axi_HP3_ARPROT PROT 1 3 }  { m_axi_HP3_ARQOS QOS 1 4 }  { m_axi_HP3_ARREGION REGION 1 4 }  { m_axi_HP3_ARUSER USER 1 1 }  { m_axi_HP3_RVALID VALID 0 1 }  { m_axi_HP3_RREADY READY 1 1 }  { m_axi_HP3_RDATA DATA 0 32 }  { m_axi_HP3_RLAST LAST 0 1 }  { m_axi_HP3_RID ID 0 1 }  { m_axi_HP3_RUSER USER 0 1 }  { m_axi_HP3_RRESP RESP 0 2 }  { m_axi_HP3_BVALID VALID 0 1 }  { m_axi_HP3_BREADY READY 1 1 }  { m_axi_HP3_BRESP RESP 0 2 }  { m_axi_HP3_BID ID 0 1 }  { m_axi_HP3_BUSER USER 0 1 } } }
	HP0 { m_axi {  { m_axi_HP0_AWVALID VALID 1 1 }  { m_axi_HP0_AWREADY READY 0 1 }  { m_axi_HP0_AWADDR ADDR 1 64 }  { m_axi_HP0_AWID ID 1 1 }  { m_axi_HP0_AWLEN LEN 1 8 }  { m_axi_HP0_AWSIZE SIZE 1 3 }  { m_axi_HP0_AWBURST BURST 1 2 }  { m_axi_HP0_AWLOCK LOCK 1 2 }  { m_axi_HP0_AWCACHE CACHE 1 4 }  { m_axi_HP0_AWPROT PROT 1 3 }  { m_axi_HP0_AWQOS QOS 1 4 }  { m_axi_HP0_AWREGION REGION 1 4 }  { m_axi_HP0_AWUSER USER 1 1 }  { m_axi_HP0_WVALID VALID 1 1 }  { m_axi_HP0_WREADY READY 0 1 }  { m_axi_HP0_WDATA DATA 1 32 }  { m_axi_HP0_WSTRB STRB 1 4 }  { m_axi_HP0_WLAST LAST 1 1 }  { m_axi_HP0_WID ID 1 1 }  { m_axi_HP0_WUSER USER 1 1 }  { m_axi_HP0_ARVALID VALID 1 1 }  { m_axi_HP0_ARREADY READY 0 1 }  { m_axi_HP0_ARADDR ADDR 1 64 }  { m_axi_HP0_ARID ID 1 1 }  { m_axi_HP0_ARLEN LEN 1 8 }  { m_axi_HP0_ARSIZE SIZE 1 3 }  { m_axi_HP0_ARBURST BURST 1 2 }  { m_axi_HP0_ARLOCK LOCK 1 2 }  { m_axi_HP0_ARCACHE CACHE 1 4 }  { m_axi_HP0_ARPROT PROT 1 3 }  { m_axi_HP0_ARQOS QOS 1 4 }  { m_axi_HP0_ARREGION REGION 1 4 }  { m_axi_HP0_ARUSER USER 1 1 }  { m_axi_HP0_RVALID VALID 0 1 }  { m_axi_HP0_RREADY READY 1 1 }  { m_axi_HP0_RDATA DATA 0 32 }  { m_axi_HP0_RLAST LAST 0 1 }  { m_axi_HP0_RID ID 0 1 }  { m_axi_HP0_RUSER USER 0 1 }  { m_axi_HP0_RRESP RESP 0 2 }  { m_axi_HP0_BVALID VALID 0 1 }  { m_axi_HP0_BREADY READY 1 1 }  { m_axi_HP0_BRESP RESP 0 2 }  { m_axi_HP0_BID ID 0 1 }  { m_axi_HP0_BUSER USER 0 1 } } }
}

set busDeadlockParameterList { 
	{ HP1 { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 } } \
	{ HP3 { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 } } \
	{ HP0 { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 } } \
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ HP1 64 }
	{ HP3 64 }
	{ HP0 64 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ HP1 64 }
	{ HP3 64 }
	{ HP0 64 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
