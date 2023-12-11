// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XHARDWARE_ENCODING_H
#define XHARDWARE_ENCODING_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xhardware_encoding_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XHardware_encoding_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XHardware_encoding;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XHardware_encoding_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XHardware_encoding_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XHardware_encoding_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XHardware_encoding_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XHardware_encoding_Initialize(XHardware_encoding *InstancePtr, u16 DeviceId);
XHardware_encoding_Config* XHardware_encoding_LookupConfig(u16 DeviceId);
int XHardware_encoding_CfgInitialize(XHardware_encoding *InstancePtr, XHardware_encoding_Config *ConfigPtr);
#else
int XHardware_encoding_Initialize(XHardware_encoding *InstancePtr, const char* InstanceName);
int XHardware_encoding_Release(XHardware_encoding *InstancePtr);
#endif

void XHardware_encoding_Start(XHardware_encoding *InstancePtr);
u32 XHardware_encoding_IsDone(XHardware_encoding *InstancePtr);
u32 XHardware_encoding_IsIdle(XHardware_encoding *InstancePtr);
u32 XHardware_encoding_IsReady(XHardware_encoding *InstancePtr);
void XHardware_encoding_Continue(XHardware_encoding *InstancePtr);
void XHardware_encoding_EnableAutoRestart(XHardware_encoding *InstancePtr);
void XHardware_encoding_DisableAutoRestart(XHardware_encoding *InstancePtr);

void XHardware_encoding_Set_s1(XHardware_encoding *InstancePtr, u64 Data);
u64 XHardware_encoding_Get_s1(XHardware_encoding *InstancePtr);
void XHardware_encoding_Set_output_r(XHardware_encoding *InstancePtr, u64 Data);
u64 XHardware_encoding_Get_output_r(XHardware_encoding *InstancePtr);

void XHardware_encoding_InterruptGlobalEnable(XHardware_encoding *InstancePtr);
void XHardware_encoding_InterruptGlobalDisable(XHardware_encoding *InstancePtr);
void XHardware_encoding_InterruptEnable(XHardware_encoding *InstancePtr, u32 Mask);
void XHardware_encoding_InterruptDisable(XHardware_encoding *InstancePtr, u32 Mask);
void XHardware_encoding_InterruptClear(XHardware_encoding *InstancePtr, u32 Mask);
u32 XHardware_encoding_InterruptGetEnabled(XHardware_encoding *InstancePtr);
u32 XHardware_encoding_InterruptGetStatus(XHardware_encoding *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
