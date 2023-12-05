// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xhardware_encoding.h"

extern XHardware_encoding_Config XHardware_encoding_ConfigTable[];

XHardware_encoding_Config *XHardware_encoding_LookupConfig(u16 DeviceId) {
	XHardware_encoding_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XHARDWARE_ENCODING_NUM_INSTANCES; Index++) {
		if (XHardware_encoding_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XHardware_encoding_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XHardware_encoding_Initialize(XHardware_encoding *InstancePtr, u16 DeviceId) {
	XHardware_encoding_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XHardware_encoding_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XHardware_encoding_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

