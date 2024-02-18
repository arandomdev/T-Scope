// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xttest.h"

extern XTtest_Config XTtest_ConfigTable[];

#ifdef SDT
XTtest_Config *XTtest_LookupConfig(UINTPTR BaseAddress) {
	XTtest_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XTtest_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XTtest_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XTtest_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XTtest_Initialize(XTtest *InstancePtr, UINTPTR BaseAddress) {
	XTtest_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XTtest_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XTtest_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XTtest_Config *XTtest_LookupConfig(u16 DeviceId) {
	XTtest_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XTTEST_NUM_INSTANCES; Index++) {
		if (XTtest_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XTtest_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XTtest_Initialize(XTtest *InstancePtr, u16 DeviceId) {
	XTtest_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XTtest_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XTtest_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

