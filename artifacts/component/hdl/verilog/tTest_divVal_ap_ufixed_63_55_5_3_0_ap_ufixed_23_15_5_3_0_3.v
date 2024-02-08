// ==============================================================
// Generated by Vitis HLS v2023.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module tTest_divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        p_read,
        numDataA_dout,
        numDataA_num_data_valid,
        numDataA_fifo_cap,
        numDataA_empty_n,
        numDataA_read,
        numDataA_c_din,
        numDataA_c_num_data_valid,
        numDataA_c_fifo_cap,
        numDataA_c_full_n,
        numDataA_c_write,
        ap_return
);

parameter    ap_ST_fsm_state1 = 68'd1;
parameter    ap_ST_fsm_state2 = 68'd2;
parameter    ap_ST_fsm_state3 = 68'd4;
parameter    ap_ST_fsm_state4 = 68'd8;
parameter    ap_ST_fsm_state5 = 68'd16;
parameter    ap_ST_fsm_state6 = 68'd32;
parameter    ap_ST_fsm_state7 = 68'd64;
parameter    ap_ST_fsm_state8 = 68'd128;
parameter    ap_ST_fsm_state9 = 68'd256;
parameter    ap_ST_fsm_state10 = 68'd512;
parameter    ap_ST_fsm_state11 = 68'd1024;
parameter    ap_ST_fsm_state12 = 68'd2048;
parameter    ap_ST_fsm_state13 = 68'd4096;
parameter    ap_ST_fsm_state14 = 68'd8192;
parameter    ap_ST_fsm_state15 = 68'd16384;
parameter    ap_ST_fsm_state16 = 68'd32768;
parameter    ap_ST_fsm_state17 = 68'd65536;
parameter    ap_ST_fsm_state18 = 68'd131072;
parameter    ap_ST_fsm_state19 = 68'd262144;
parameter    ap_ST_fsm_state20 = 68'd524288;
parameter    ap_ST_fsm_state21 = 68'd1048576;
parameter    ap_ST_fsm_state22 = 68'd2097152;
parameter    ap_ST_fsm_state23 = 68'd4194304;
parameter    ap_ST_fsm_state24 = 68'd8388608;
parameter    ap_ST_fsm_state25 = 68'd16777216;
parameter    ap_ST_fsm_state26 = 68'd33554432;
parameter    ap_ST_fsm_state27 = 68'd67108864;
parameter    ap_ST_fsm_state28 = 68'd134217728;
parameter    ap_ST_fsm_state29 = 68'd268435456;
parameter    ap_ST_fsm_state30 = 68'd536870912;
parameter    ap_ST_fsm_state31 = 68'd1073741824;
parameter    ap_ST_fsm_state32 = 68'd2147483648;
parameter    ap_ST_fsm_state33 = 68'd4294967296;
parameter    ap_ST_fsm_state34 = 68'd8589934592;
parameter    ap_ST_fsm_state35 = 68'd17179869184;
parameter    ap_ST_fsm_state36 = 68'd34359738368;
parameter    ap_ST_fsm_state37 = 68'd68719476736;
parameter    ap_ST_fsm_state38 = 68'd137438953472;
parameter    ap_ST_fsm_state39 = 68'd274877906944;
parameter    ap_ST_fsm_state40 = 68'd549755813888;
parameter    ap_ST_fsm_state41 = 68'd1099511627776;
parameter    ap_ST_fsm_state42 = 68'd2199023255552;
parameter    ap_ST_fsm_state43 = 68'd4398046511104;
parameter    ap_ST_fsm_state44 = 68'd8796093022208;
parameter    ap_ST_fsm_state45 = 68'd17592186044416;
parameter    ap_ST_fsm_state46 = 68'd35184372088832;
parameter    ap_ST_fsm_state47 = 68'd70368744177664;
parameter    ap_ST_fsm_state48 = 68'd140737488355328;
parameter    ap_ST_fsm_state49 = 68'd281474976710656;
parameter    ap_ST_fsm_state50 = 68'd562949953421312;
parameter    ap_ST_fsm_state51 = 68'd1125899906842624;
parameter    ap_ST_fsm_state52 = 68'd2251799813685248;
parameter    ap_ST_fsm_state53 = 68'd4503599627370496;
parameter    ap_ST_fsm_state54 = 68'd9007199254740992;
parameter    ap_ST_fsm_state55 = 68'd18014398509481984;
parameter    ap_ST_fsm_state56 = 68'd36028797018963968;
parameter    ap_ST_fsm_state57 = 68'd72057594037927936;
parameter    ap_ST_fsm_state58 = 68'd144115188075855872;
parameter    ap_ST_fsm_state59 = 68'd288230376151711744;
parameter    ap_ST_fsm_state60 = 68'd576460752303423488;
parameter    ap_ST_fsm_state61 = 68'd1152921504606846976;
parameter    ap_ST_fsm_state62 = 68'd2305843009213693952;
parameter    ap_ST_fsm_state63 = 68'd4611686018427387904;
parameter    ap_ST_fsm_state64 = 68'd9223372036854775808;
parameter    ap_ST_fsm_state65 = 68'd18446744073709551616;
parameter    ap_ST_fsm_state66 = 68'd36893488147419103232;
parameter    ap_ST_fsm_state67 = 68'd73786976294838206464;
parameter    ap_ST_fsm_state68 = 68'd147573952589676412928;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [62:0] p_read;
input  [39:0] numDataA_dout;
input  [2:0] numDataA_num_data_valid;
input  [2:0] numDataA_fifo_cap;
input   numDataA_empty_n;
output   numDataA_read;
output  [39:0] numDataA_c_din;
input  [2:0] numDataA_c_num_data_valid;
input  [2:0] numDataA_c_fifo_cap;
input   numDataA_c_full_n;
output   numDataA_c_write;
output  [22:0] ap_return;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg numDataA_read;
reg numDataA_c_write;
reg[22:0] ap_return;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [67:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    numDataA_blk_n;
reg    numDataA_c_blk_n;
reg   [39:0] numDataA_read_reg_82;
reg    ap_block_state1;
wire    ap_CS_fsm_state2;
wire   [0:0] icmp_ln23_fu_63_p2;
reg   [0:0] icmp_ln23_reg_93;
wire   [22:0] trunc_ln24_fu_77_p1;
reg   [22:0] ap_phi_mux_var_i_out_0_phi_fu_56_p4;
reg   [22:0] var_i_out_0_reg_52;
wire    ap_CS_fsm_state68;
wire   [39:0] grp_fu_71_p1;
wire   [22:0] grp_fu_71_p2;
reg    grp_fu_71_ap_start;
wire    grp_fu_71_ap_done;
reg   [22:0] ap_return_preg;
reg   [67:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
wire    ap_ST_fsm_state4_blk;
wire    ap_ST_fsm_state5_blk;
wire    ap_ST_fsm_state6_blk;
wire    ap_ST_fsm_state7_blk;
wire    ap_ST_fsm_state8_blk;
wire    ap_ST_fsm_state9_blk;
wire    ap_ST_fsm_state10_blk;
wire    ap_ST_fsm_state11_blk;
wire    ap_ST_fsm_state12_blk;
wire    ap_ST_fsm_state13_blk;
wire    ap_ST_fsm_state14_blk;
wire    ap_ST_fsm_state15_blk;
wire    ap_ST_fsm_state16_blk;
wire    ap_ST_fsm_state17_blk;
wire    ap_ST_fsm_state18_blk;
wire    ap_ST_fsm_state19_blk;
wire    ap_ST_fsm_state20_blk;
wire    ap_ST_fsm_state21_blk;
wire    ap_ST_fsm_state22_blk;
wire    ap_ST_fsm_state23_blk;
wire    ap_ST_fsm_state24_blk;
wire    ap_ST_fsm_state25_blk;
wire    ap_ST_fsm_state26_blk;
wire    ap_ST_fsm_state27_blk;
wire    ap_ST_fsm_state28_blk;
wire    ap_ST_fsm_state29_blk;
wire    ap_ST_fsm_state30_blk;
wire    ap_ST_fsm_state31_blk;
wire    ap_ST_fsm_state32_blk;
wire    ap_ST_fsm_state33_blk;
wire    ap_ST_fsm_state34_blk;
wire    ap_ST_fsm_state35_blk;
wire    ap_ST_fsm_state36_blk;
wire    ap_ST_fsm_state37_blk;
wire    ap_ST_fsm_state38_blk;
wire    ap_ST_fsm_state39_blk;
wire    ap_ST_fsm_state40_blk;
wire    ap_ST_fsm_state41_blk;
wire    ap_ST_fsm_state42_blk;
wire    ap_ST_fsm_state43_blk;
wire    ap_ST_fsm_state44_blk;
wire    ap_ST_fsm_state45_blk;
wire    ap_ST_fsm_state46_blk;
wire    ap_ST_fsm_state47_blk;
wire    ap_ST_fsm_state48_blk;
wire    ap_ST_fsm_state49_blk;
wire    ap_ST_fsm_state50_blk;
wire    ap_ST_fsm_state51_blk;
wire    ap_ST_fsm_state52_blk;
wire    ap_ST_fsm_state53_blk;
wire    ap_ST_fsm_state54_blk;
wire    ap_ST_fsm_state55_blk;
wire    ap_ST_fsm_state56_blk;
wire    ap_ST_fsm_state57_blk;
wire    ap_ST_fsm_state58_blk;
wire    ap_ST_fsm_state59_blk;
wire    ap_ST_fsm_state60_blk;
wire    ap_ST_fsm_state61_blk;
wire    ap_ST_fsm_state62_blk;
wire    ap_ST_fsm_state63_blk;
wire    ap_ST_fsm_state64_blk;
wire    ap_ST_fsm_state65_blk;
wire    ap_ST_fsm_state66_blk;
wire    ap_ST_fsm_state67_blk;
wire    ap_ST_fsm_state68_blk;
wire   [62:0] grp_fu_71_p10;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 68'd1;
#0 numDataA_read_reg_82 = 40'd0;
#0 icmp_ln23_reg_93 = 1'd0;
#0 var_i_out_0_reg_52 = 23'd0;
#0 ap_return_preg = 23'd0;
end

tTest_udiv_63ns_40ns_23_67_seq_1 #(
    .ID( 1 ),
    .NUM_STAGE( 67 ),
    .din0_WIDTH( 63 ),
    .din1_WIDTH( 40 ),
    .dout_WIDTH( 23 ))
udiv_63ns_40ns_23_67_seq_1_U45(
    .clk(ap_clk),
    .reset(ap_rst),
    .start(grp_fu_71_ap_start),
    .done(grp_fu_71_ap_done),
    .din0(p_read),
    .din1(grp_fu_71_p1),
    .ce(1'b1),
    .dout(grp_fu_71_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state68)) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_return_preg <= 23'd0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state68)) begin
            ap_return_preg <= ap_phi_mux_var_i_out_0_phi_fu_56_p4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        icmp_ln23_reg_93 <= 1'd0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            icmp_ln23_reg_93 <= icmp_ln23_fu_63_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        numDataA_read_reg_82 <= 40'd0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state1) & (1'b0 == ap_block_state1))) begin
            numDataA_read_reg_82 <= numDataA_dout;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        var_i_out_0_reg_52 <= 23'd0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state68) & (icmp_ln23_reg_93 == 1'd0))) begin
            var_i_out_0_reg_52 <= trunc_ln24_fu_77_p1;
        end
    end
end

assign ap_ST_fsm_state10_blk = 1'b0;

assign ap_ST_fsm_state11_blk = 1'b0;

assign ap_ST_fsm_state12_blk = 1'b0;

assign ap_ST_fsm_state13_blk = 1'b0;

assign ap_ST_fsm_state14_blk = 1'b0;

assign ap_ST_fsm_state15_blk = 1'b0;

assign ap_ST_fsm_state16_blk = 1'b0;

assign ap_ST_fsm_state17_blk = 1'b0;

assign ap_ST_fsm_state18_blk = 1'b0;

assign ap_ST_fsm_state19_blk = 1'b0;

always @ (*) begin
    if ((1'b1 == ap_block_state1)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state20_blk = 1'b0;

assign ap_ST_fsm_state21_blk = 1'b0;

assign ap_ST_fsm_state22_blk = 1'b0;

assign ap_ST_fsm_state23_blk = 1'b0;

assign ap_ST_fsm_state24_blk = 1'b0;

assign ap_ST_fsm_state25_blk = 1'b0;

assign ap_ST_fsm_state26_blk = 1'b0;

assign ap_ST_fsm_state27_blk = 1'b0;

assign ap_ST_fsm_state28_blk = 1'b0;

assign ap_ST_fsm_state29_blk = 1'b0;

assign ap_ST_fsm_state2_blk = 1'b0;

assign ap_ST_fsm_state30_blk = 1'b0;

assign ap_ST_fsm_state31_blk = 1'b0;

assign ap_ST_fsm_state32_blk = 1'b0;

assign ap_ST_fsm_state33_blk = 1'b0;

assign ap_ST_fsm_state34_blk = 1'b0;

assign ap_ST_fsm_state35_blk = 1'b0;

assign ap_ST_fsm_state36_blk = 1'b0;

assign ap_ST_fsm_state37_blk = 1'b0;

assign ap_ST_fsm_state38_blk = 1'b0;

assign ap_ST_fsm_state39_blk = 1'b0;

assign ap_ST_fsm_state3_blk = 1'b0;

assign ap_ST_fsm_state40_blk = 1'b0;

assign ap_ST_fsm_state41_blk = 1'b0;

assign ap_ST_fsm_state42_blk = 1'b0;

assign ap_ST_fsm_state43_blk = 1'b0;

assign ap_ST_fsm_state44_blk = 1'b0;

assign ap_ST_fsm_state45_blk = 1'b0;

assign ap_ST_fsm_state46_blk = 1'b0;

assign ap_ST_fsm_state47_blk = 1'b0;

assign ap_ST_fsm_state48_blk = 1'b0;

assign ap_ST_fsm_state49_blk = 1'b0;

assign ap_ST_fsm_state4_blk = 1'b0;

assign ap_ST_fsm_state50_blk = 1'b0;

assign ap_ST_fsm_state51_blk = 1'b0;

assign ap_ST_fsm_state52_blk = 1'b0;

assign ap_ST_fsm_state53_blk = 1'b0;

assign ap_ST_fsm_state54_blk = 1'b0;

assign ap_ST_fsm_state55_blk = 1'b0;

assign ap_ST_fsm_state56_blk = 1'b0;

assign ap_ST_fsm_state57_blk = 1'b0;

assign ap_ST_fsm_state58_blk = 1'b0;

assign ap_ST_fsm_state59_blk = 1'b0;

assign ap_ST_fsm_state5_blk = 1'b0;

assign ap_ST_fsm_state60_blk = 1'b0;

assign ap_ST_fsm_state61_blk = 1'b0;

assign ap_ST_fsm_state62_blk = 1'b0;

assign ap_ST_fsm_state63_blk = 1'b0;

assign ap_ST_fsm_state64_blk = 1'b0;

assign ap_ST_fsm_state65_blk = 1'b0;

assign ap_ST_fsm_state66_blk = 1'b0;

assign ap_ST_fsm_state67_blk = 1'b0;

assign ap_ST_fsm_state68_blk = 1'b0;

assign ap_ST_fsm_state6_blk = 1'b0;

assign ap_ST_fsm_state7_blk = 1'b0;

assign ap_ST_fsm_state8_blk = 1'b0;

assign ap_ST_fsm_state9_blk = 1'b0;

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state68)) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state68) & (icmp_ln23_reg_93 == 1'd0))) begin
        ap_phi_mux_var_i_out_0_phi_fu_56_p4 = trunc_ln24_fu_77_p1;
    end else begin
        ap_phi_mux_var_i_out_0_phi_fu_56_p4 = var_i_out_0_reg_52;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state68)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state68)) begin
        ap_return = ap_phi_mux_var_i_out_0_phi_fu_56_p4;
    end else begin
        ap_return = ap_return_preg;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (icmp_ln23_fu_63_p2 == 1'd0))) begin
        grp_fu_71_ap_start = 1'b1;
    end else begin
        grp_fu_71_ap_start = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        numDataA_blk_n = numDataA_empty_n;
    end else begin
        numDataA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        numDataA_c_blk_n = numDataA_c_full_n;
    end else begin
        numDataA_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (1'b0 == ap_block_state1))) begin
        numDataA_c_write = 1'b1;
    end else begin
        numDataA_c_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (1'b0 == ap_block_state1))) begin
        numDataA_read = 1'b1;
    end else begin
        numDataA_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (1'b0 == ap_block_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((1'b1 == ap_CS_fsm_state2) & (icmp_ln23_fu_63_p2 == 1'd1))) begin
                ap_NS_fsm = ap_ST_fsm_state68;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state8;
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state10;
        end
        ap_ST_fsm_state10 : begin
            ap_NS_fsm = ap_ST_fsm_state11;
        end
        ap_ST_fsm_state11 : begin
            ap_NS_fsm = ap_ST_fsm_state12;
        end
        ap_ST_fsm_state12 : begin
            ap_NS_fsm = ap_ST_fsm_state13;
        end
        ap_ST_fsm_state13 : begin
            ap_NS_fsm = ap_ST_fsm_state14;
        end
        ap_ST_fsm_state14 : begin
            ap_NS_fsm = ap_ST_fsm_state15;
        end
        ap_ST_fsm_state15 : begin
            ap_NS_fsm = ap_ST_fsm_state16;
        end
        ap_ST_fsm_state16 : begin
            ap_NS_fsm = ap_ST_fsm_state17;
        end
        ap_ST_fsm_state17 : begin
            ap_NS_fsm = ap_ST_fsm_state18;
        end
        ap_ST_fsm_state18 : begin
            ap_NS_fsm = ap_ST_fsm_state19;
        end
        ap_ST_fsm_state19 : begin
            ap_NS_fsm = ap_ST_fsm_state20;
        end
        ap_ST_fsm_state20 : begin
            ap_NS_fsm = ap_ST_fsm_state21;
        end
        ap_ST_fsm_state21 : begin
            ap_NS_fsm = ap_ST_fsm_state22;
        end
        ap_ST_fsm_state22 : begin
            ap_NS_fsm = ap_ST_fsm_state23;
        end
        ap_ST_fsm_state23 : begin
            ap_NS_fsm = ap_ST_fsm_state24;
        end
        ap_ST_fsm_state24 : begin
            ap_NS_fsm = ap_ST_fsm_state25;
        end
        ap_ST_fsm_state25 : begin
            ap_NS_fsm = ap_ST_fsm_state26;
        end
        ap_ST_fsm_state26 : begin
            ap_NS_fsm = ap_ST_fsm_state27;
        end
        ap_ST_fsm_state27 : begin
            ap_NS_fsm = ap_ST_fsm_state28;
        end
        ap_ST_fsm_state28 : begin
            ap_NS_fsm = ap_ST_fsm_state29;
        end
        ap_ST_fsm_state29 : begin
            ap_NS_fsm = ap_ST_fsm_state30;
        end
        ap_ST_fsm_state30 : begin
            ap_NS_fsm = ap_ST_fsm_state31;
        end
        ap_ST_fsm_state31 : begin
            ap_NS_fsm = ap_ST_fsm_state32;
        end
        ap_ST_fsm_state32 : begin
            ap_NS_fsm = ap_ST_fsm_state33;
        end
        ap_ST_fsm_state33 : begin
            ap_NS_fsm = ap_ST_fsm_state34;
        end
        ap_ST_fsm_state34 : begin
            ap_NS_fsm = ap_ST_fsm_state35;
        end
        ap_ST_fsm_state35 : begin
            ap_NS_fsm = ap_ST_fsm_state36;
        end
        ap_ST_fsm_state36 : begin
            ap_NS_fsm = ap_ST_fsm_state37;
        end
        ap_ST_fsm_state37 : begin
            ap_NS_fsm = ap_ST_fsm_state38;
        end
        ap_ST_fsm_state38 : begin
            ap_NS_fsm = ap_ST_fsm_state39;
        end
        ap_ST_fsm_state39 : begin
            ap_NS_fsm = ap_ST_fsm_state40;
        end
        ap_ST_fsm_state40 : begin
            ap_NS_fsm = ap_ST_fsm_state41;
        end
        ap_ST_fsm_state41 : begin
            ap_NS_fsm = ap_ST_fsm_state42;
        end
        ap_ST_fsm_state42 : begin
            ap_NS_fsm = ap_ST_fsm_state43;
        end
        ap_ST_fsm_state43 : begin
            ap_NS_fsm = ap_ST_fsm_state44;
        end
        ap_ST_fsm_state44 : begin
            ap_NS_fsm = ap_ST_fsm_state45;
        end
        ap_ST_fsm_state45 : begin
            ap_NS_fsm = ap_ST_fsm_state46;
        end
        ap_ST_fsm_state46 : begin
            ap_NS_fsm = ap_ST_fsm_state47;
        end
        ap_ST_fsm_state47 : begin
            ap_NS_fsm = ap_ST_fsm_state48;
        end
        ap_ST_fsm_state48 : begin
            ap_NS_fsm = ap_ST_fsm_state49;
        end
        ap_ST_fsm_state49 : begin
            ap_NS_fsm = ap_ST_fsm_state50;
        end
        ap_ST_fsm_state50 : begin
            ap_NS_fsm = ap_ST_fsm_state51;
        end
        ap_ST_fsm_state51 : begin
            ap_NS_fsm = ap_ST_fsm_state52;
        end
        ap_ST_fsm_state52 : begin
            ap_NS_fsm = ap_ST_fsm_state53;
        end
        ap_ST_fsm_state53 : begin
            ap_NS_fsm = ap_ST_fsm_state54;
        end
        ap_ST_fsm_state54 : begin
            ap_NS_fsm = ap_ST_fsm_state55;
        end
        ap_ST_fsm_state55 : begin
            ap_NS_fsm = ap_ST_fsm_state56;
        end
        ap_ST_fsm_state56 : begin
            ap_NS_fsm = ap_ST_fsm_state57;
        end
        ap_ST_fsm_state57 : begin
            ap_NS_fsm = ap_ST_fsm_state58;
        end
        ap_ST_fsm_state58 : begin
            ap_NS_fsm = ap_ST_fsm_state59;
        end
        ap_ST_fsm_state59 : begin
            ap_NS_fsm = ap_ST_fsm_state60;
        end
        ap_ST_fsm_state60 : begin
            ap_NS_fsm = ap_ST_fsm_state61;
        end
        ap_ST_fsm_state61 : begin
            ap_NS_fsm = ap_ST_fsm_state62;
        end
        ap_ST_fsm_state62 : begin
            ap_NS_fsm = ap_ST_fsm_state63;
        end
        ap_ST_fsm_state63 : begin
            ap_NS_fsm = ap_ST_fsm_state64;
        end
        ap_ST_fsm_state64 : begin
            ap_NS_fsm = ap_ST_fsm_state65;
        end
        ap_ST_fsm_state65 : begin
            ap_NS_fsm = ap_ST_fsm_state66;
        end
        ap_ST_fsm_state66 : begin
            ap_NS_fsm = ap_ST_fsm_state67;
        end
        ap_ST_fsm_state67 : begin
            ap_NS_fsm = ap_ST_fsm_state68;
        end
        ap_ST_fsm_state68 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state68 = ap_CS_fsm[32'd67];

always @ (*) begin
    ap_block_state1 = ((numDataA_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (ap_start == 1'b0) | (numDataA_c_full_n == 1'b0));
end

assign grp_fu_71_p1 = grp_fu_71_p10;

assign grp_fu_71_p10 = numDataA_read_reg_82;

assign icmp_ln23_fu_63_p2 = ((numDataA_read_reg_82 == 40'd0) ? 1'b1 : 1'b0);

assign numDataA_c_din = numDataA_dout;

assign trunc_ln24_fu_77_p1 = grp_fu_71_p2[22:0];

endmodule //tTest_divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3
