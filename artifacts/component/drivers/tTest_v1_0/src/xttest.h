// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XTTEST_H
#define XTTEST_H

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
#include "xttest_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u32 Control_BaseAddress;
} XTtest_Config;
#endif

typedef struct {
    u32 Control_BaseAddress;
    u32 IsReady;
} XTtest;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XTtest_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XTtest_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XTtest_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XTtest_ReadReg(BaseAddress, RegOffset) \
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
#ifdef SDT
int XTtest_Initialize(XTtest *InstancePtr, UINTPTR BaseAddress);
XTtest_Config* XTtest_LookupConfig(UINTPTR BaseAddress);
#else
int XTtest_Initialize(XTtest *InstancePtr, u16 DeviceId);
XTtest_Config* XTtest_LookupConfig(u16 DeviceId);
#endif
int XTtest_CfgInitialize(XTtest *InstancePtr, XTtest_Config *ConfigPtr);
#else
int XTtest_Initialize(XTtest *InstancePtr, const char* InstanceName);
int XTtest_Release(XTtest *InstancePtr);
#endif

void XTtest_Start(XTtest *InstancePtr);
u32 XTtest_IsDone(XTtest *InstancePtr);
u32 XTtest_IsIdle(XTtest *InstancePtr);
u32 XTtest_IsReady(XTtest *InstancePtr);
void XTtest_EnableAutoRestart(XTtest *InstancePtr);
void XTtest_DisableAutoRestart(XTtest *InstancePtr);

void XTtest_Set_C(XTtest *InstancePtr, u32 Data);
u32 XTtest_Get_C(XTtest *InstancePtr);

void XTtest_InterruptGlobalEnable(XTtest *InstancePtr);
void XTtest_InterruptGlobalDisable(XTtest *InstancePtr);
void XTtest_InterruptEnable(XTtest *InstancePtr, u32 Mask);
void XTtest_InterruptDisable(XTtest *InstancePtr, u32 Mask);
void XTtest_InterruptClear(XTtest *InstancePtr, u32 Mask);
u32 XTtest_InterruptGetEnabled(XTtest *InstancePtr);
u32 XTtest_InterruptGetStatus(XTtest *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
