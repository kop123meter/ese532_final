# This script segment is generated automatically by AutoPilot

set axilite_register_dict [dict create]
set port_control {
s1 { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 16
	offset_end 27
}
output_r { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 28
	offset_end 39
}
size { 
	dir O
	width 32
	depth 1
	mode ap_none
	offset 40
	offset_end 47
}
len { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 56
	offset_end 63
}
ap_start { }
ap_done { }
ap_ready { }
ap_continue { }
ap_idle { }
}
dict set axilite_register_dict control $port_control

