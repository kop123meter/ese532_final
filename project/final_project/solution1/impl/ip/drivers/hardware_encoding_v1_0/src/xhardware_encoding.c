// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xhardware_encoding.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XHardware_encoding_CfgInitialize(XHardware_encoding *InstancePtr, XHardware_encoding_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XHardware_encoding_Start(XHardware_encoding *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_AP_CTRL) & 0x80;
    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XHardware_encoding_IsDone(XHardware_encoding *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XHardware_encoding_IsIdle(XHardware_encoding *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XHardware_encoding_IsReady(XHardware_encoding *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XHardware_encoding_Continue(XHardware_encoding *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_AP_CTRL) & 0x80;
    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_AP_CTRL, Data | 0x10);
}

void XHardware_encoding_EnableAutoRestart(XHardware_encoding *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XHardware_encoding_DisableAutoRestart(XHardware_encoding *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_AP_CTRL, 0);
}

void XHardware_encoding_Set_s1(XHardware_encoding *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_S1_DATA, (u32)(Data));
    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_S1_DATA + 4, (u32)(Data >> 32));
}

u64 XHardware_encoding_Get_s1(XHardware_encoding *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_S1_DATA);
    Data += (u64)XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_S1_DATA + 4) << 32;
    return Data;
}

void XHardware_encoding_Set_output_r(XHardware_encoding *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_OUTPUT_R_DATA, (u32)(Data));
    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_OUTPUT_R_DATA + 4, (u32)(Data >> 32));
}

u64 XHardware_encoding_Get_output_r(XHardware_encoding *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_OUTPUT_R_DATA);
    Data += (u64)XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_OUTPUT_R_DATA + 4) << 32;
    return Data;
}

void XHardware_encoding_InterruptGlobalEnable(XHardware_encoding *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_GIE, 1);
}

void XHardware_encoding_InterruptGlobalDisable(XHardware_encoding *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_GIE, 0);
}

void XHardware_encoding_InterruptEnable(XHardware_encoding *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_IER);
    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_IER, Register | Mask);
}

void XHardware_encoding_InterruptDisable(XHardware_encoding *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_IER);
    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_IER, Register & (~Mask));
}

void XHardware_encoding_InterruptClear(XHardware_encoding *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHardware_encoding_WriteReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_ISR, Mask);
}

u32 XHardware_encoding_InterruptGetEnabled(XHardware_encoding *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_IER);
}

u32 XHardware_encoding_InterruptGetStatus(XHardware_encoding *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHardware_encoding_ReadReg(InstancePtr->Control_BaseAddress, XHARDWARE_ENCODING_CONTROL_ADDR_ISR);
}

