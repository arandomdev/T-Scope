// ==============================================================
// Generated by Vitis HLS v2023.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module tTest_varSum_5 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        famB_address0,
        famB_ce0,
        famB_q0,
        p_read,
        ap_return
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output  [7:0] famB_address0;
output   famB_ce0;
input  [31:0] famB_q0;
input  [15:0] p_read;
output  [62:0] ap_return;

reg ap_idle;
reg famB_ce0;
reg[62:0] ap_return;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_idle_pp0;
reg    ap_done_reg;
reg    ap_block_state1_pp0_stage0_iter0;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln36_fu_108_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] icmp_ln36_reg_232;
reg   [0:0] icmp_ln36_reg_232_pp0_iter1_reg;
reg   [0:0] icmp_ln36_reg_232_pp0_iter2_reg;
wire   [16:0] tmp1_fu_136_p2;
reg   [16:0] tmp1_reg_236;
reg   [23:0] lshr_ln_reg_246;
reg   [31:0] famB_load_reg_251;
reg   [53:0] tmp_1_reg_266;
wire   [31:0] zext_ln39_fu_142_p1;
wire    ap_block_pp0_stage0;
reg   [62:0] tmpSum_fu_60;
wire   [62:0] tmpSum_1_fu_203_p2;
reg   [62:0] ap_sig_allocacmp_tmpSum_load_1;
wire    ap_loop_init;
reg    ap_loop_init_pp0_iter1_reg;
reg    ap_loop_init_pp0_iter2_reg;
reg    ap_loop_init_pp0_iter3_reg;
reg   [8:0] i_fu_64;
wire   [8:0] add_ln36_fu_114_p2;
reg   [8:0] ap_sig_allocacmp_i_1;
wire   [31:0] grp_fu_87_p0;
wire   [23:0] grp_fu_87_p1;
wire   [7:0] trunc_ln38_fu_120_p1;
wire   [15:0] shl_ln_fu_124_p3;
wire   [16:0] zext_ln38_1_fu_132_p1;
wire   [16:0] zext_ln38_fu_91_p1;
wire  signed [16:0] mul_ln39_fu_155_p0;
wire  signed [31:0] sext_ln39_fu_152_p1;
wire  signed [16:0] mul_ln39_fu_155_p1;
wire   [31:0] mul_ln39_fu_155_p2;
wire   [55:0] grp_fu_87_p2;
wire   [55:0] and_ln_fu_192_p3;
wire   [62:0] zext_ln40_fu_199_p1;
reg    grp_fu_87_ce;
reg   [62:0] ap_return_preg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg    ap_loop_exit_ready_pp0_iter2_reg;
reg    ap_loop_exit_ready_pp0_iter3_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire   [55:0] grp_fu_87_p00;
wire   [55:0] grp_fu_87_p10;
reg    ap_condition_148;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 ap_done_reg = 1'b0;
#0 icmp_ln36_reg_232 = 1'd0;
#0 icmp_ln36_reg_232_pp0_iter1_reg = 1'd0;
#0 icmp_ln36_reg_232_pp0_iter2_reg = 1'd0;
#0 tmp1_reg_236 = 17'd0;
#0 lshr_ln_reg_246 = 24'd0;
#0 famB_load_reg_251 = 32'd0;
#0 tmp_1_reg_266 = 54'd0;
#0 tmpSum_fu_60 = 63'd0;
#0 ap_loop_init_pp0_iter1_reg = 1'b0;
#0 ap_loop_init_pp0_iter2_reg = 1'b0;
#0 ap_loop_init_pp0_iter3_reg = 1'b0;
#0 i_fu_64 = 9'd0;
#0 ap_return_preg = 63'd0;
#0 ap_loop_exit_ready_pp0_iter1_reg = 1'b0;
#0 ap_loop_exit_ready_pp0_iter2_reg = 1'b0;
#0 ap_loop_exit_ready_pp0_iter3_reg = 1'b0;
end

tTest_mul_32ns_24ns_56_2_1 #(
    .ID( 1 ),
    .NUM_STAGE( 2 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 24 ),
    .dout_WIDTH( 56 ))
mul_32ns_24ns_56_2_1_U41(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_87_p0),
    .din1(grp_fu_87_p1),
    .ce(grp_fu_87_ce),
    .dout(grp_fu_87_p2)
);

tTest_mul_17s_17s_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 17 ),
    .din1_WIDTH( 17 ),
    .dout_WIDTH( 32 ))
mul_17s_17s_32_1_1_U42(
    .din0(mul_ln39_fu_155_p0),
    .din1(mul_ln39_fu_155_p1),
    .dout(mul_ln39_fu_155_p2)
);

tTest_flow_control_loop_pipe flow_control_loop_pipe_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int),
    .ap_continue(ap_continue)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter3_reg == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_loop_exit_ready_pp0_iter1_reg <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_loop_exit_ready_pp0_iter2_reg <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_loop_exit_ready_pp0_iter2_reg <= ap_loop_exit_ready_pp0_iter1_reg;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_loop_exit_ready_pp0_iter3_reg <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_11001)) begin
            ap_loop_exit_ready_pp0_iter3_reg <= ap_loop_exit_ready_pp0_iter2_reg;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_loop_init_pp0_iter1_reg <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_loop_init_pp0_iter1_reg <= ap_loop_init;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_loop_init_pp0_iter2_reg <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_loop_init_pp0_iter2_reg <= ap_loop_init_pp0_iter1_reg;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_loop_init_pp0_iter3_reg <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_11001)) begin
            ap_loop_init_pp0_iter3_reg <= ap_loop_init_pp0_iter2_reg;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_return_preg <= 63'd0;
    end else begin
        if (((icmp_ln36_reg_232_pp0_iter2_reg == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
            ap_return_preg <= ap_sig_allocacmp_tmpSum_load_1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        famB_load_reg_251 <= 32'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            famB_load_reg_251 <= famB_q0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        i_fu_64 <= 9'd0;
    end else begin
        if ((1'b1 == ap_condition_148)) begin
            if ((icmp_ln36_fu_108_p2 == 1'd0)) begin
                i_fu_64 <= add_ln36_fu_114_p2;
            end else if ((ap_loop_init == 1'b1)) begin
                i_fu_64 <= 9'd0;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        icmp_ln36_reg_232 <= 1'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            icmp_ln36_reg_232 <= icmp_ln36_fu_108_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        icmp_ln36_reg_232_pp0_iter1_reg <= 1'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            icmp_ln36_reg_232_pp0_iter1_reg <= icmp_ln36_reg_232;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        icmp_ln36_reg_232_pp0_iter2_reg <= 1'd0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_11001)) begin
            icmp_ln36_reg_232_pp0_iter2_reg <= icmp_ln36_reg_232_pp0_iter1_reg;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        lshr_ln_reg_246 <= 24'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            lshr_ln_reg_246 <= {{mul_ln39_fu_155_p2[31:8]}};
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        tmp1_reg_236 <= 17'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            tmp1_reg_236 <= tmp1_fu_136_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        tmpSum_fu_60 <= 63'd0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_11001)) begin
            if (((ap_enable_reg_pp0_iter3 == 1'b1) & (ap_loop_init_pp0_iter3_reg == 1'b1))) begin
                tmpSum_fu_60 <= 63'd0;
            end else if ((ap_enable_reg_pp0_iter4 == 1'b1)) begin
                tmpSum_fu_60 <= tmpSum_1_fu_203_p2;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        tmp_1_reg_266 <= 54'd0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_11001)) begin
            tmp_1_reg_266 <= {{grp_fu_87_p2[55:2]}};
        end
    end
end

always @ (*) begin
    if (((icmp_ln36_fu_108_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_start_int == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter3_reg == 1'b1))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_idle_pp0 == 1'b1) & (ap_start_int == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_start_int == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln36_reg_232_pp0_iter2_reg == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_return = ap_sig_allocacmp_tmpSum_load_1;
    end else begin
        ap_return = ap_return_preg;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_start_int == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_i_1 = 9'd0;
    end else begin
        ap_sig_allocacmp_i_1 = i_fu_64;
    end
end

always @ (*) begin
    if ((1'b0 == ap_block_pp0_stage0)) begin
        if (((ap_enable_reg_pp0_iter3 == 1'b1) & (ap_loop_init_pp0_iter3_reg == 1'b1))) begin
            ap_sig_allocacmp_tmpSum_load_1 = 63'd0;
        end else if ((ap_enable_reg_pp0_iter4 == 1'b1)) begin
            ap_sig_allocacmp_tmpSum_load_1 = tmpSum_1_fu_203_p2;
        end else begin
            ap_sig_allocacmp_tmpSum_load_1 = tmpSum_fu_60;
        end
    end else begin
        ap_sig_allocacmp_tmpSum_load_1 = tmpSum_fu_60;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start_int == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        famB_ce0 = 1'b1;
    end else begin
        famB_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        grp_fu_87_ce = 1'b1;
    end else begin
        grp_fu_87_ce = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln36_fu_114_p2 = (ap_sig_allocacmp_i_1 + 9'd1);

assign and_ln_fu_192_p3 = {{tmp_1_reg_266}, {2'd0}};

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_start_int == 1'b1) & (1'b1 == ap_block_state1_pp0_stage0_iter0)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_start_int == 1'b1) & (1'b1 == ap_block_state1_pp0_stage0_iter0)));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (ap_done_reg == 1'b1);
end

always @ (*) begin
    ap_condition_148 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_start_int == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign famB_address0 = zext_ln39_fu_142_p1;

assign grp_fu_87_p0 = grp_fu_87_p00;

assign grp_fu_87_p00 = famB_load_reg_251;

assign grp_fu_87_p1 = grp_fu_87_p10;

assign grp_fu_87_p10 = lshr_ln_reg_246;

assign icmp_ln36_fu_108_p2 = ((ap_sig_allocacmp_i_1 == 9'd256) ? 1'b1 : 1'b0);

assign mul_ln39_fu_155_p0 = sext_ln39_fu_152_p1;

assign mul_ln39_fu_155_p1 = sext_ln39_fu_152_p1;

assign sext_ln39_fu_152_p1 = $signed(tmp1_reg_236);

assign shl_ln_fu_124_p3 = {{trunc_ln38_fu_120_p1}, {8'd0}};

assign tmp1_fu_136_p2 = (zext_ln38_1_fu_132_p1 - zext_ln38_fu_91_p1);

assign tmpSum_1_fu_203_p2 = (zext_ln40_fu_199_p1 + tmpSum_fu_60);

assign trunc_ln38_fu_120_p1 = ap_sig_allocacmp_i_1[7:0];

assign zext_ln38_1_fu_132_p1 = shl_ln_fu_124_p3;

assign zext_ln38_fu_91_p1 = p_read;

assign zext_ln39_fu_142_p1 = trunc_ln38_fu_120_p1;

assign zext_ln40_fu_199_p1 = and_ln_fu_192_p3;

endmodule //tTest_varSum_5