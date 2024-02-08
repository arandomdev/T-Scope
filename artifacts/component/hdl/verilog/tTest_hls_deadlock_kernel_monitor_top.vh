
wire kernel_monitor_reset;
wire kernel_monitor_clock;
wire kernel_monitor_report;
assign kernel_monitor_reset = ~ap_rst_n;
assign kernel_monitor_clock = ap_clk;
assign kernel_monitor_report = 1'b0;
wire [1:0] axis_block_sigs;
wire [19:0] inst_idle_sigs;
wire [16:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~sumStream_U0.A_TDATA_blk_n;
assign axis_block_sigs[1] = ~sumStream_4_U0.B_TDATA_blk_n;

assign inst_idle_sigs[0] = entry_proc_U0.ap_idle;
assign inst_block_sigs[0] = (entry_proc_U0.ap_done & ~entry_proc_U0.ap_continue) | ~entry_proc_U0.C_c_blk_n;
assign inst_idle_sigs[1] = sumStream_U0.ap_idle;
assign inst_block_sigs[1] = (sumStream_U0.ap_done & ~sumStream_U0.ap_continue);
assign inst_idle_sigs[2] = sumStream_4_U0.ap_idle;
assign inst_block_sigs[2] = (sumStream_4_U0.ap_done & ~sumStream_4_U0.ap_continue);
assign inst_idle_sigs[3] = divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.ap_idle;
assign inst_block_sigs[3] = (divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.ap_done & ~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.ap_continue) | ~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.numDataA_c_blk_n;
assign inst_idle_sigs[4] = divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.ap_idle;
assign inst_block_sigs[4] = (divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.ap_done & ~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.ap_continue) | ~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.numDataB_c_blk_n;
assign inst_idle_sigs[5] = diff_U0.ap_idle;
assign inst_block_sigs[5] = (diff_U0.ap_done & ~diff_U0.ap_continue);
assign inst_idle_sigs[6] = varSum_U0.ap_idle;
assign inst_block_sigs[6] = (varSum_U0.ap_done & ~varSum_U0.ap_continue);
assign inst_idle_sigs[7] = varSum_5_U0.ap_idle;
assign inst_block_sigs[7] = (varSum_5_U0.ap_done & ~varSum_5_U0.ap_continue);
assign inst_idle_sigs[8] = tCalc1_2_U0.ap_idle;
assign inst_block_sigs[8] = (tCalc1_2_U0.ap_done & ~tCalc1_2_U0.ap_continue) | ~tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.numDataA_blk_n;
assign inst_idle_sigs[9] = tCalc1_U0.ap_idle;
assign inst_block_sigs[9] = (tCalc1_U0.ap_done & ~tCalc1_U0.ap_continue) | ~tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.numDataB_blk_n;
assign inst_idle_sigs[10] = tCalc2_U0.ap_idle;
assign inst_block_sigs[10] = (tCalc2_U0.ap_done & ~tCalc2_U0.ap_continue);
assign inst_idle_sigs[11] = Block_entry2458_proc_U0.ap_idle;
assign inst_block_sigs[11] = (Block_entry2458_proc_U0.ap_done & ~Block_entry2458_proc_U0.ap_continue) | ~Block_entry2458_proc_U0.C_blk_n;
assign inst_idle_sigs[12] = tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.ap_idle;
assign inst_block_sigs[12] = (tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.ap_done & ~tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.ap_continue);
assign inst_idle_sigs[13] = tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0.ap_idle;
assign inst_block_sigs[13] = (tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0.ap_done & ~tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0.ap_continue);
assign inst_idle_sigs[14] = tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.ap_idle;
assign inst_block_sigs[14] = (tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.ap_done & ~tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.ap_continue);
assign inst_idle_sigs[15] = tCalc1_U0.tCalc1_Block_entry57_proc_U0.ap_idle;
assign inst_block_sigs[15] = (tCalc1_U0.tCalc1_Block_entry57_proc_U0.ap_done & ~tCalc1_U0.tCalc1_Block_entry57_proc_U0.ap_continue);
assign inst_idle_sigs[16] = tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle;
assign inst_block_sigs[16] = (tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_done & ~tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_continue);

assign inst_idle_sigs[17] = 1'b0;
assign inst_idle_sigs[18] = sumStream_U0.ap_idle;
assign inst_idle_sigs[19] = sumStream_4_U0.ap_idle;

tTest_hls_deadlock_idx0_monitor tTest_hls_deadlock_idx0_monitor_U (
    .clock(kernel_monitor_clock),
    .reset(kernel_monitor_reset),
    .axis_block_sigs(axis_block_sigs),
    .inst_idle_sigs(inst_idle_sigs),
    .inst_block_sigs(inst_block_sigs),
    .block(kernel_block)
);


always @ (kernel_block or kernel_monitor_reset) begin
    if (kernel_block == 1'b1 && kernel_monitor_reset == 1'b0) begin
        find_kernel_block = 1'b1;
    end
    else begin
        find_kernel_block = 1'b0;
    end
end
