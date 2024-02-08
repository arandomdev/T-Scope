// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xttest.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XTtest_CfgInitialize(XTtest *InstancePtr, XTtest_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XTtest_Start(XTtest *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTtest_ReadReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_AP_CTRL) & 0x80;
    XTtest_WriteReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XTtest_IsDone(XTtest *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTtest_ReadReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XTtest_IsIdle(XTtest *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTtest_ReadReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XTtest_IsReady(XTtest *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTtest_ReadReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XTtest_EnableAutoRestart(XTtest *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTtest_WriteReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XTtest_DisableAutoRestart(XTtest *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTtest_WriteReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_AP_CTRL, 0);
}

void XTtest_Set_C(XTtest *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTtest_WriteReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_C_DATA, Data);
}

u32 XTtest_Get_C(XTtest *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTtest_ReadReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_C_DATA);
    return Data;
}

void XTtest_InterruptGlobalEnable(XTtest *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTtest_WriteReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_GIE, 1);
}

void XTtest_InterruptGlobalDisable(XTtest *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTtest_WriteReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_GIE, 0);
}

void XTtest_InterruptEnable(XTtest *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XTtest_ReadReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_IER);
    XTtest_WriteReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_IER, Register | Mask);
}

void XTtest_InterruptDisable(XTtest *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XTtest_ReadReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_IER);
    XTtest_WriteReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_IER, Register & (~Mask));
}

void XTtest_InterruptClear(XTtest *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTtest_WriteReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_ISR, Mask);
}

u32 XTtest_InterruptGetEnabled(XTtest *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTtest_ReadReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_IER);
}

u32 XTtest_InterruptGetStatus(XTtest *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTtest_ReadReg(InstancePtr->Control_BaseAddress, XTTEST_CONTROL_ADDR_ISR);
}

