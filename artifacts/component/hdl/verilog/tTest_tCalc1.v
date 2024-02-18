// ==============================================================
// Generated by Vitis HLS v2023.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module tTest_tCalc1 (
        varSum,
        numData,
        out_r,
        ap_clk,
        ap_rst,
        numData_ap_vld,
        varSum_ap_vld,
        out_r_ap_vld,
        ap_start,
        ap_done,
        ap_ready,
        ap_idle,
        ap_continue
);


input  [62:0] varSum;
input  [39:0] numData;
output  [63:0] out_r;
input   ap_clk;
input   ap_rst;
input   numData_ap_vld;
input   varSum_ap_vld;
output   out_r_ap_vld;
input   ap_start;
output   ap_done;
output   ap_ready;
output   ap_idle;
input   ap_continue;

wire    tCalc1_Block_entry5_proc_U0_ap_start;
wire    tCalc1_Block_entry5_proc_U0_ap_done;
wire    tCalc1_Block_entry5_proc_U0_ap_continue;
wire    tCalc1_Block_entry5_proc_U0_ap_idle;
wire    tCalc1_Block_entry5_proc_U0_ap_ready;
wire   [63:0] tCalc1_Block_entry5_proc_U0_out_r;
wire    tCalc1_Block_entry5_proc_U0_out_r_ap_vld;

tTest_tCalc1_Block_entry5_proc tCalc1_Block_entry5_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(tCalc1_Block_entry5_proc_U0_ap_start),
    .ap_done(tCalc1_Block_entry5_proc_U0_ap_done),
    .ap_continue(tCalc1_Block_entry5_proc_U0_ap_continue),
    .ap_idle(tCalc1_Block_entry5_proc_U0_ap_idle),
    .ap_ready(tCalc1_Block_entry5_proc_U0_ap_ready),
    .numData(numData),
    .varSum(varSum),
    .out_r(tCalc1_Block_entry5_proc_U0_out_r),
    .out_r_ap_vld(tCalc1_Block_entry5_proc_U0_out_r_ap_vld)
);

assign ap_done = tCalc1_Block_entry5_proc_U0_ap_done;

assign ap_idle = tCalc1_Block_entry5_proc_U0_ap_idle;

assign ap_ready = tCalc1_Block_entry5_proc_U0_ap_ready;

assign out_r = tCalc1_Block_entry5_proc_U0_out_r;

assign out_r_ap_vld = tCalc1_Block_entry5_proc_U0_out_r_ap_vld;

assign tCalc1_Block_entry5_proc_U0_ap_continue = ap_continue;

assign tCalc1_Block_entry5_proc_U0_ap_start = ap_start;

endmodule //tTest_tCalc1
