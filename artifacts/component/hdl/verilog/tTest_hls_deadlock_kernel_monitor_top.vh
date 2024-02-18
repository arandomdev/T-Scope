
wire kernel_monitor_reset;
wire kernel_monitor_clock;
wire kernel_monitor_report;
assign kernel_monitor_reset = ~ap_rst_n;
assign kernel_monitor_clock = ap_clk;
assign kernel_monitor_report = 1'b0;
wire [1:0] axis_block_sigs;
wire [9:0] inst_idle_sigs;
wire [6:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~sumStream_U0.A_TDATA_blk_n;
assign axis_block_sigs[1] = ~sumStream_1_U0.B_TDATA_blk_n;

assign inst_idle_sigs[0] = entry_proc_U0.ap_idle;
assign inst_block_sigs[0] = (entry_proc_U0.ap_done & ~entry_proc_U0.ap_continue) | ~entry_proc_U0.C_c_blk_n;
assign inst_idle_sigs[1] = sumStream_U0.ap_idle;
assign inst_block_sigs[1] = (sumStream_U0.ap_done & ~sumStream_U0.ap_continue);
assign inst_idle_sigs[2] = sumStream_1_U0.ap_idle;
assign inst_block_sigs[2] = (sumStream_1_U0.ap_done & ~sumStream_1_U0.ap_continue);
assign inst_idle_sigs[3] = Block_entry2347_proc6_U0.ap_idle;
assign inst_block_sigs[3] = (Block_entry2347_proc6_U0.ap_done & ~Block_entry2347_proc6_U0.ap_continue) | ~Block_entry2347_proc6_U0.C_blk_n;
assign inst_idle_sigs[4] = Block_entry2347_proc6_U0.grp_tCalc1_fu_164.tCalc1_Block_entry5_proc_U0.ap_idle;
assign inst_block_sigs[4] = (Block_entry2347_proc6_U0.grp_tCalc1_fu_164.tCalc1_Block_entry5_proc_U0.ap_done & ~Block_entry2347_proc6_U0.grp_tCalc1_fu_164.tCalc1_Block_entry5_proc_U0.ap_continue);
assign inst_idle_sigs[5] = Block_entry2347_proc6_U0.grp_tCalc1_fu_171.tCalc1_Block_entry5_proc_U0.ap_idle;
assign inst_block_sigs[5] = (Block_entry2347_proc6_U0.grp_tCalc1_fu_171.tCalc1_Block_entry5_proc_U0.ap_done & ~Block_entry2347_proc6_U0.grp_tCalc1_fu_171.tCalc1_Block_entry5_proc_U0.ap_continue);
assign inst_idle_sigs[6] = Block_entry2347_proc6_U0.grp_tCalc2_fu_178.tCalc2_Block_entry21_proc_U0.ap_idle;
assign inst_block_sigs[6] = (Block_entry2347_proc6_U0.grp_tCalc2_fu_178.tCalc2_Block_entry21_proc_U0.ap_done & ~Block_entry2347_proc6_U0.grp_tCalc2_fu_178.tCalc2_Block_entry21_proc_U0.ap_continue);

assign inst_idle_sigs[7] = 1'b0;
assign inst_idle_sigs[8] = sumStream_U0.ap_idle;
assign inst_idle_sigs[9] = sumStream_1_U0.ap_idle;

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
