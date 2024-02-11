// ==============================================================
// Generated by Vitis HLS v2023.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module tTest_tCalc1 (
        p_read,
        numDataB_dout,
        numDataB_empty_n,
        numDataB_read,
        tCalc1ResultB,
        ap_clk,
        ap_rst,
        p_read_ap_vld,
        ap_start,
        tCalc1ResultB_ap_vld,
        ap_done,
        ap_ready,
        ap_idle,
        ap_continue
);


input  [62:0] p_read;
input  [39:0] numDataB_dout;
input   numDataB_empty_n;
output   numDataB_read;
output  [31:0] tCalc1ResultB;
input   ap_clk;
input   ap_rst;
input   p_read_ap_vld;
input   ap_start;
output   tCalc1ResultB_ap_vld;
output   ap_done;
output   ap_ready;
output   ap_idle;
input   ap_continue;

wire    divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_start;
wire    divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_done;
wire    divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_continue;
wire    divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_idle;
wire    divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_ready;
wire    divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_numDataB_read;
wire   [39:0] divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_numDataB_c_din;
wire    divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_numDataB_c_write;
wire   [22:0] divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_return;
wire    var_r_s_full_n;
wire    tCalc1_Block_entry57_proc_U0_ap_start;
wire    tCalc1_Block_entry57_proc_U0_ap_done;
wire    tCalc1_Block_entry57_proc_U0_ap_continue;
wire    tCalc1_Block_entry57_proc_U0_ap_idle;
wire    tCalc1_Block_entry57_proc_U0_ap_ready;
wire    tCalc1_Block_entry57_proc_U0_numDataB_read;
wire   [31:0] tCalc1_Block_entry57_proc_U0_tCalc1ResultB;
wire    numDataB_c_full_n;
wire   [39:0] numDataB_c_dout;
wire   [2:0] numDataB_c_num_data_valid;
wire   [2:0] numDataB_c_fifo_cap;
wire    numDataB_c_empty_n;
wire   [22:0] var_r_s_dout;
wire   [2:0] var_r_s_num_data_valid;
wire   [2:0] var_r_s_fifo_cap;
wire    var_r_s_empty_n;

tTest_divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_s divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_start),
    .ap_done(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_done),
    .ap_continue(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_continue),
    .ap_idle(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_idle),
    .ap_ready(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_ready),
    .p_read(p_read),
    .numDataB_dout(numDataB_dout),
    .numDataB_num_data_valid(3'd0),
    .numDataB_fifo_cap(3'd0),
    .numDataB_empty_n(numDataB_empty_n),
    .numDataB_read(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_numDataB_read),
    .numDataB_c_din(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_numDataB_c_din),
    .numDataB_c_num_data_valid(numDataB_c_num_data_valid),
    .numDataB_c_fifo_cap(numDataB_c_fifo_cap),
    .numDataB_c_full_n(numDataB_c_full_n),
    .numDataB_c_write(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_numDataB_c_write),
    .ap_return(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_return)
);

tTest_tCalc1_Block_entry57_proc tCalc1_Block_entry57_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(tCalc1_Block_entry57_proc_U0_ap_start),
    .ap_done(tCalc1_Block_entry57_proc_U0_ap_done),
    .ap_continue(tCalc1_Block_entry57_proc_U0_ap_continue),
    .ap_idle(tCalc1_Block_entry57_proc_U0_ap_idle),
    .ap_ready(tCalc1_Block_entry57_proc_U0_ap_ready),
    .p_read(var_r_s_dout),
    .numDataB_dout(numDataB_c_dout),
    .numDataB_num_data_valid(numDataB_c_num_data_valid),
    .numDataB_fifo_cap(numDataB_c_fifo_cap),
    .numDataB_empty_n(numDataB_c_empty_n),
    .numDataB_read(tCalc1_Block_entry57_proc_U0_numDataB_read),
    .tCalc1ResultB(tCalc1_Block_entry57_proc_U0_tCalc1ResultB)
);

tTest_fifo_w40_d2_S_x numDataB_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_numDataB_c_din),
    .if_full_n(numDataB_c_full_n),
    .if_write(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_numDataB_c_write),
    .if_dout(numDataB_c_dout),
    .if_num_data_valid(numDataB_c_num_data_valid),
    .if_fifo_cap(numDataB_c_fifo_cap),
    .if_empty_n(numDataB_c_empty_n),
    .if_read(tCalc1_Block_entry57_proc_U0_numDataB_read)
);

tTest_fifo_w23_d2_S_x var_r_s_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_return),
    .if_full_n(var_r_s_full_n),
    .if_write(divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_done),
    .if_dout(var_r_s_dout),
    .if_num_data_valid(var_r_s_num_data_valid),
    .if_fifo_cap(var_r_s_fifo_cap),
    .if_empty_n(var_r_s_empty_n),
    .if_read(tCalc1_Block_entry57_proc_U0_ap_ready)
);

assign ap_done = tCalc1_Block_entry57_proc_U0_ap_done;

assign ap_idle = (tCalc1_Block_entry57_proc_U0_ap_idle & (var_r_s_empty_n ^ 1'b1) & divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_idle);

assign ap_ready = divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_ready;

assign divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_continue = var_r_s_full_n;

assign divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_ap_start = ap_start;

assign numDataB_read = divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0_numDataB_read;

assign tCalc1ResultB = tCalc1_Block_entry57_proc_U0_tCalc1ResultB;

assign tCalc1ResultB_ap_vld = 1'b1;

assign tCalc1_Block_entry57_proc_U0_ap_continue = ap_continue;

assign tCalc1_Block_entry57_proc_U0_ap_start = var_r_s_empty_n;

endmodule //tTest_tCalc1
