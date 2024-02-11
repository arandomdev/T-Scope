
    wire dl_reset;
    wire dl_clock;
    assign dl_reset = ap_rst_n;
    assign dl_clock = ap_clk;
    wire [2:0] proc_0_data_FIFO_blk;
    wire [2:0] proc_0_data_PIPO_blk;
    wire [2:0] proc_0_start_FIFO_blk;
    wire [2:0] proc_0_TLF_FIFO_blk;
    wire [2:0] proc_0_input_sync_blk;
    wire [2:0] proc_0_output_sync_blk;
    wire [2:0] proc_dep_vld_vec_0;
    reg [2:0] proc_dep_vld_vec_0_reg;
    wire [2:0] in_chan_dep_vld_vec_0;
    wire [50:0] in_chan_dep_data_vec_0;
    wire [2:0] token_in_vec_0;
    wire [2:0] out_chan_dep_vld_vec_0;
    wire [16:0] out_chan_dep_data_0;
    wire [2:0] token_out_vec_0;
    wire dl_detect_out_0;
    wire dep_chan_vld_1_0;
    wire [16:0] dep_chan_data_1_0;
    wire token_1_0;
    wire dep_chan_vld_2_0;
    wire [16:0] dep_chan_data_2_0;
    wire token_2_0;
    wire dep_chan_vld_16_0;
    wire [16:0] dep_chan_data_16_0;
    wire token_16_0;
    wire [2:0] proc_1_data_FIFO_blk;
    wire [2:0] proc_1_data_PIPO_blk;
    wire [2:0] proc_1_start_FIFO_blk;
    wire [2:0] proc_1_TLF_FIFO_blk;
    wire [2:0] proc_1_input_sync_blk;
    wire [2:0] proc_1_output_sync_blk;
    wire [2:0] proc_dep_vld_vec_1;
    reg [2:0] proc_dep_vld_vec_1_reg;
    wire [3:0] in_chan_dep_vld_vec_1;
    wire [67:0] in_chan_dep_data_vec_1;
    wire [3:0] token_in_vec_1;
    wire [2:0] out_chan_dep_vld_vec_1;
    wire [16:0] out_chan_dep_data_1;
    wire [2:0] token_out_vec_1;
    wire dl_detect_out_1;
    wire dep_chan_vld_0_1;
    wire [16:0] dep_chan_data_0_1;
    wire token_0_1;
    wire dep_chan_vld_2_1;
    wire [16:0] dep_chan_data_2_1;
    wire token_2_1;
    wire dep_chan_vld_3_1;
    wire [16:0] dep_chan_data_3_1;
    wire token_3_1;
    wire dep_chan_vld_6_1;
    wire [16:0] dep_chan_data_6_1;
    wire token_6_1;
    wire [2:0] proc_2_data_FIFO_blk;
    wire [2:0] proc_2_data_PIPO_blk;
    wire [2:0] proc_2_start_FIFO_blk;
    wire [2:0] proc_2_TLF_FIFO_blk;
    wire [2:0] proc_2_input_sync_blk;
    wire [2:0] proc_2_output_sync_blk;
    wire [2:0] proc_dep_vld_vec_2;
    reg [2:0] proc_dep_vld_vec_2_reg;
    wire [3:0] in_chan_dep_vld_vec_2;
    wire [67:0] in_chan_dep_data_vec_2;
    wire [3:0] token_in_vec_2;
    wire [2:0] out_chan_dep_vld_vec_2;
    wire [16:0] out_chan_dep_data_2;
    wire [2:0] token_out_vec_2;
    wire dl_detect_out_2;
    wire dep_chan_vld_0_2;
    wire [16:0] dep_chan_data_0_2;
    wire token_0_2;
    wire dep_chan_vld_1_2;
    wire [16:0] dep_chan_data_1_2;
    wire token_1_2;
    wire dep_chan_vld_4_2;
    wire [16:0] dep_chan_data_4_2;
    wire token_4_2;
    wire dep_chan_vld_7_2;
    wire [16:0] dep_chan_data_7_2;
    wire token_7_2;
    wire [2:0] proc_3_data_FIFO_blk;
    wire [2:0] proc_3_data_PIPO_blk;
    wire [2:0] proc_3_start_FIFO_blk;
    wire [2:0] proc_3_TLF_FIFO_blk;
    wire [2:0] proc_3_input_sync_blk;
    wire [2:0] proc_3_output_sync_blk;
    wire [2:0] proc_dep_vld_vec_3;
    reg [2:0] proc_dep_vld_vec_3_reg;
    wire [3:0] in_chan_dep_vld_vec_3;
    wire [67:0] in_chan_dep_data_vec_3;
    wire [3:0] token_in_vec_3;
    wire [2:0] out_chan_dep_vld_vec_3;
    wire [16:0] out_chan_dep_data_3;
    wire [2:0] token_out_vec_3;
    wire dl_detect_out_3;
    wire dep_chan_vld_5_3;
    wire [16:0] dep_chan_data_5_3;
    wire token_5_3;
    wire dep_chan_vld_6_3;
    wire [16:0] dep_chan_data_6_3;
    wire token_6_3;
    wire dep_chan_vld_8_3;
    wire [16:0] dep_chan_data_8_3;
    wire token_8_3;
    wire dep_chan_vld_9_3;
    wire [16:0] dep_chan_data_9_3;
    wire token_9_3;
    wire [2:0] proc_4_data_FIFO_blk;
    wire [2:0] proc_4_data_PIPO_blk;
    wire [2:0] proc_4_start_FIFO_blk;
    wire [2:0] proc_4_TLF_FIFO_blk;
    wire [2:0] proc_4_input_sync_blk;
    wire [2:0] proc_4_output_sync_blk;
    wire [2:0] proc_dep_vld_vec_4;
    reg [2:0] proc_dep_vld_vec_4_reg;
    wire [3:0] in_chan_dep_vld_vec_4;
    wire [67:0] in_chan_dep_data_vec_4;
    wire [3:0] token_in_vec_4;
    wire [2:0] out_chan_dep_vld_vec_4;
    wire [16:0] out_chan_dep_data_4;
    wire [2:0] token_out_vec_4;
    wire dl_detect_out_4;
    wire dep_chan_vld_5_4;
    wire [16:0] dep_chan_data_5_4;
    wire token_5_4;
    wire dep_chan_vld_7_4;
    wire [16:0] dep_chan_data_7_4;
    wire token_7_4;
    wire dep_chan_vld_11_4;
    wire [16:0] dep_chan_data_11_4;
    wire token_11_4;
    wire dep_chan_vld_12_4;
    wire [16:0] dep_chan_data_12_4;
    wire token_12_4;
    wire [1:0] proc_5_data_FIFO_blk;
    wire [1:0] proc_5_data_PIPO_blk;
    wire [1:0] proc_5_start_FIFO_blk;
    wire [1:0] proc_5_TLF_FIFO_blk;
    wire [1:0] proc_5_input_sync_blk;
    wire [1:0] proc_5_output_sync_blk;
    wire [1:0] proc_dep_vld_vec_5;
    reg [1:0] proc_dep_vld_vec_5_reg;
    wire [1:0] in_chan_dep_vld_vec_5;
    wire [33:0] in_chan_dep_data_vec_5;
    wire [1:0] token_in_vec_5;
    wire [1:0] out_chan_dep_vld_vec_5;
    wire [16:0] out_chan_dep_data_5;
    wire [1:0] token_out_vec_5;
    wire dl_detect_out_5;
    wire dep_chan_vld_14_5;
    wire [16:0] dep_chan_data_14_5;
    wire token_14_5;
    wire dep_chan_vld_15_5;
    wire [16:0] dep_chan_data_15_5;
    wire token_15_5;
    wire [1:0] proc_6_data_FIFO_blk;
    wire [1:0] proc_6_data_PIPO_blk;
    wire [1:0] proc_6_start_FIFO_blk;
    wire [1:0] proc_6_TLF_FIFO_blk;
    wire [1:0] proc_6_input_sync_blk;
    wire [1:0] proc_6_output_sync_blk;
    wire [1:0] proc_dep_vld_vec_6;
    reg [1:0] proc_dep_vld_vec_6_reg;
    wire [2:0] in_chan_dep_vld_vec_6;
    wire [50:0] in_chan_dep_data_vec_6;
    wire [2:0] token_in_vec_6;
    wire [1:0] out_chan_dep_vld_vec_6;
    wire [16:0] out_chan_dep_data_6;
    wire [1:0] token_out_vec_6;
    wire dl_detect_out_6;
    wire dep_chan_vld_1_6;
    wire [16:0] dep_chan_data_1_6;
    wire token_1_6;
    wire dep_chan_vld_8_6;
    wire [16:0] dep_chan_data_8_6;
    wire token_8_6;
    wire dep_chan_vld_9_6;
    wire [16:0] dep_chan_data_9_6;
    wire token_9_6;
    wire [1:0] proc_7_data_FIFO_blk;
    wire [1:0] proc_7_data_PIPO_blk;
    wire [1:0] proc_7_start_FIFO_blk;
    wire [1:0] proc_7_TLF_FIFO_blk;
    wire [1:0] proc_7_input_sync_blk;
    wire [1:0] proc_7_output_sync_blk;
    wire [1:0] proc_dep_vld_vec_7;
    reg [1:0] proc_dep_vld_vec_7_reg;
    wire [2:0] in_chan_dep_vld_vec_7;
    wire [50:0] in_chan_dep_data_vec_7;
    wire [2:0] token_in_vec_7;
    wire [1:0] out_chan_dep_vld_vec_7;
    wire [16:0] out_chan_dep_data_7;
    wire [1:0] token_out_vec_7;
    wire dl_detect_out_7;
    wire dep_chan_vld_2_7;
    wire [16:0] dep_chan_data_2_7;
    wire token_2_7;
    wire dep_chan_vld_11_7;
    wire [16:0] dep_chan_data_11_7;
    wire token_11_7;
    wire dep_chan_vld_12_7;
    wire [16:0] dep_chan_data_12_7;
    wire token_12_7;
    wire [3:0] proc_8_data_FIFO_blk;
    wire [3:0] proc_8_data_PIPO_blk;
    wire [3:0] proc_8_start_FIFO_blk;
    wire [3:0] proc_8_TLF_FIFO_blk;
    wire [3:0] proc_8_input_sync_blk;
    wire [3:0] proc_8_output_sync_blk;
    wire [3:0] proc_dep_vld_vec_8;
    reg [3:0] proc_dep_vld_vec_8_reg;
    wire [2:0] in_chan_dep_vld_vec_8;
    wire [50:0] in_chan_dep_data_vec_8;
    wire [2:0] token_in_vec_8;
    wire [3:0] out_chan_dep_vld_vec_8;
    wire [16:0] out_chan_dep_data_8;
    wire [3:0] token_out_vec_8;
    wire dl_detect_out_8;
    wire dep_chan_vld_3_8;
    wire [16:0] dep_chan_data_3_8;
    wire token_3_8;
    wire dep_chan_vld_14_8;
    wire [16:0] dep_chan_data_14_8;
    wire token_14_8;
    wire dep_chan_vld_15_8;
    wire [16:0] dep_chan_data_15_8;
    wire token_15_8;
    wire [2:0] proc_9_data_FIFO_blk;
    wire [2:0] proc_9_data_PIPO_blk;
    wire [2:0] proc_9_start_FIFO_blk;
    wire [2:0] proc_9_TLF_FIFO_blk;
    wire [2:0] proc_9_input_sync_blk;
    wire [2:0] proc_9_output_sync_blk;
    wire [2:0] proc_dep_vld_vec_9;
    reg [2:0] proc_dep_vld_vec_9_reg;
    wire [1:0] in_chan_dep_vld_vec_9;
    wire [33:0] in_chan_dep_data_vec_9;
    wire [1:0] token_in_vec_9;
    wire [2:0] out_chan_dep_vld_vec_9;
    wire [16:0] out_chan_dep_data_9;
    wire [2:0] token_out_vec_9;
    wire dl_detect_out_9;
    wire dep_chan_vld_3_9;
    wire [16:0] dep_chan_data_3_9;
    wire token_3_9;
    wire dep_chan_vld_10_9;
    wire [16:0] dep_chan_data_10_9;
    wire token_10_9;
    wire [2:0] proc_10_data_FIFO_blk;
    wire [2:0] proc_10_data_PIPO_blk;
    wire [2:0] proc_10_start_FIFO_blk;
    wire [2:0] proc_10_TLF_FIFO_blk;
    wire [2:0] proc_10_input_sync_blk;
    wire [2:0] proc_10_output_sync_blk;
    wire [2:0] proc_dep_vld_vec_10;
    reg [2:0] proc_dep_vld_vec_10_reg;
    wire [2:0] in_chan_dep_vld_vec_10;
    wire [50:0] in_chan_dep_data_vec_10;
    wire [2:0] token_in_vec_10;
    wire [2:0] out_chan_dep_vld_vec_10;
    wire [16:0] out_chan_dep_data_10;
    wire [2:0] token_out_vec_10;
    wire dl_detect_out_10;
    wire dep_chan_vld_9_10;
    wire [16:0] dep_chan_data_9_10;
    wire token_9_10;
    wire dep_chan_vld_14_10;
    wire [16:0] dep_chan_data_14_10;
    wire token_14_10;
    wire dep_chan_vld_15_10;
    wire [16:0] dep_chan_data_15_10;
    wire token_15_10;
    wire [3:0] proc_11_data_FIFO_blk;
    wire [3:0] proc_11_data_PIPO_blk;
    wire [3:0] proc_11_start_FIFO_blk;
    wire [3:0] proc_11_TLF_FIFO_blk;
    wire [3:0] proc_11_input_sync_blk;
    wire [3:0] proc_11_output_sync_blk;
    wire [3:0] proc_dep_vld_vec_11;
    reg [3:0] proc_dep_vld_vec_11_reg;
    wire [2:0] in_chan_dep_vld_vec_11;
    wire [50:0] in_chan_dep_data_vec_11;
    wire [2:0] token_in_vec_11;
    wire [3:0] out_chan_dep_vld_vec_11;
    wire [16:0] out_chan_dep_data_11;
    wire [3:0] token_out_vec_11;
    wire dl_detect_out_11;
    wire dep_chan_vld_4_11;
    wire [16:0] dep_chan_data_4_11;
    wire token_4_11;
    wire dep_chan_vld_14_11;
    wire [16:0] dep_chan_data_14_11;
    wire token_14_11;
    wire dep_chan_vld_15_11;
    wire [16:0] dep_chan_data_15_11;
    wire token_15_11;
    wire [2:0] proc_12_data_FIFO_blk;
    wire [2:0] proc_12_data_PIPO_blk;
    wire [2:0] proc_12_start_FIFO_blk;
    wire [2:0] proc_12_TLF_FIFO_blk;
    wire [2:0] proc_12_input_sync_blk;
    wire [2:0] proc_12_output_sync_blk;
    wire [2:0] proc_dep_vld_vec_12;
    reg [2:0] proc_dep_vld_vec_12_reg;
    wire [1:0] in_chan_dep_vld_vec_12;
    wire [33:0] in_chan_dep_data_vec_12;
    wire [1:0] token_in_vec_12;
    wire [2:0] out_chan_dep_vld_vec_12;
    wire [16:0] out_chan_dep_data_12;
    wire [2:0] token_out_vec_12;
    wire dl_detect_out_12;
    wire dep_chan_vld_4_12;
    wire [16:0] dep_chan_data_4_12;
    wire token_4_12;
    wire dep_chan_vld_13_12;
    wire [16:0] dep_chan_data_13_12;
    wire token_13_12;
    wire [2:0] proc_13_data_FIFO_blk;
    wire [2:0] proc_13_data_PIPO_blk;
    wire [2:0] proc_13_start_FIFO_blk;
    wire [2:0] proc_13_TLF_FIFO_blk;
    wire [2:0] proc_13_input_sync_blk;
    wire [2:0] proc_13_output_sync_blk;
    wire [2:0] proc_dep_vld_vec_13;
    reg [2:0] proc_dep_vld_vec_13_reg;
    wire [2:0] in_chan_dep_vld_vec_13;
    wire [50:0] in_chan_dep_data_vec_13;
    wire [2:0] token_in_vec_13;
    wire [2:0] out_chan_dep_vld_vec_13;
    wire [16:0] out_chan_dep_data_13;
    wire [2:0] token_out_vec_13;
    wire dl_detect_out_13;
    wire dep_chan_vld_12_13;
    wire [16:0] dep_chan_data_12_13;
    wire token_12_13;
    wire dep_chan_vld_14_13;
    wire [16:0] dep_chan_data_14_13;
    wire token_14_13;
    wire dep_chan_vld_15_13;
    wire [16:0] dep_chan_data_15_13;
    wire token_15_13;
    wire [5:0] proc_14_data_FIFO_blk;
    wire [5:0] proc_14_data_PIPO_blk;
    wire [5:0] proc_14_start_FIFO_blk;
    wire [5:0] proc_14_TLF_FIFO_blk;
    wire [5:0] proc_14_input_sync_blk;
    wire [5:0] proc_14_output_sync_blk;
    wire [5:0] proc_dep_vld_vec_14;
    reg [5:0] proc_dep_vld_vec_14_reg;
    wire [4:0] in_chan_dep_vld_vec_14;
    wire [84:0] in_chan_dep_data_vec_14;
    wire [4:0] token_in_vec_14;
    wire [5:0] out_chan_dep_vld_vec_14;
    wire [16:0] out_chan_dep_data_14;
    wire [5:0] token_out_vec_14;
    wire dl_detect_out_14;
    wire dep_chan_vld_8_14;
    wire [16:0] dep_chan_data_8_14;
    wire token_8_14;
    wire dep_chan_vld_10_14;
    wire [16:0] dep_chan_data_10_14;
    wire token_10_14;
    wire dep_chan_vld_11_14;
    wire [16:0] dep_chan_data_11_14;
    wire token_11_14;
    wire dep_chan_vld_13_14;
    wire [16:0] dep_chan_data_13_14;
    wire token_13_14;
    wire dep_chan_vld_16_14;
    wire [16:0] dep_chan_data_16_14;
    wire token_16_14;
    wire [5:0] proc_15_data_FIFO_blk;
    wire [5:0] proc_15_data_PIPO_blk;
    wire [5:0] proc_15_start_FIFO_blk;
    wire [5:0] proc_15_TLF_FIFO_blk;
    wire [5:0] proc_15_input_sync_blk;
    wire [5:0] proc_15_output_sync_blk;
    wire [5:0] proc_dep_vld_vec_15;
    reg [5:0] proc_dep_vld_vec_15_reg;
    wire [4:0] in_chan_dep_vld_vec_15;
    wire [84:0] in_chan_dep_data_vec_15;
    wire [4:0] token_in_vec_15;
    wire [5:0] out_chan_dep_vld_vec_15;
    wire [16:0] out_chan_dep_data_15;
    wire [5:0] token_out_vec_15;
    wire dl_detect_out_15;
    wire dep_chan_vld_8_15;
    wire [16:0] dep_chan_data_8_15;
    wire token_8_15;
    wire dep_chan_vld_10_15;
    wire [16:0] dep_chan_data_10_15;
    wire token_10_15;
    wire dep_chan_vld_11_15;
    wire [16:0] dep_chan_data_11_15;
    wire token_11_15;
    wire dep_chan_vld_13_15;
    wire [16:0] dep_chan_data_13_15;
    wire token_13_15;
    wire dep_chan_vld_16_15;
    wire [16:0] dep_chan_data_16_15;
    wire token_16_15;
    wire [2:0] proc_16_data_FIFO_blk;
    wire [2:0] proc_16_data_PIPO_blk;
    wire [2:0] proc_16_start_FIFO_blk;
    wire [2:0] proc_16_TLF_FIFO_blk;
    wire [2:0] proc_16_input_sync_blk;
    wire [2:0] proc_16_output_sync_blk;
    wire [2:0] proc_dep_vld_vec_16;
    reg [2:0] proc_dep_vld_vec_16_reg;
    wire [2:0] in_chan_dep_vld_vec_16;
    wire [50:0] in_chan_dep_data_vec_16;
    wire [2:0] token_in_vec_16;
    wire [2:0] out_chan_dep_vld_vec_16;
    wire [16:0] out_chan_dep_data_16;
    wire [2:0] token_out_vec_16;
    wire dl_detect_out_16;
    wire dep_chan_vld_0_16;
    wire [16:0] dep_chan_data_0_16;
    wire token_0_16;
    wire dep_chan_vld_14_16;
    wire [16:0] dep_chan_data_14_16;
    wire token_14_16;
    wire dep_chan_vld_15_16;
    wire [16:0] dep_chan_data_15_16;
    wire token_15_16;
    wire [16:0] dl_in_vec;
    wire dl_detect_out;
    wire token_clear;
    reg [16:0] origin;

    reg ap_done_reg_0;// for module sumStream_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_0 <= 'b0;
        end
        else begin
            ap_done_reg_0 <= sumStream_U0.ap_done & ~sumStream_U0.ap_continue;
        end
    end

    reg ap_done_reg_1;// for module sumStream_4_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_1 <= 'b0;
        end
        else begin
            ap_done_reg_1 <= sumStream_4_U0.ap_done & ~sumStream_4_U0.ap_continue;
        end
    end

    reg ap_done_reg_2;// for module divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_2 <= 'b0;
        end
        else begin
            ap_done_reg_2 <= divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.ap_done & ~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.ap_continue;
        end
    end

    reg ap_done_reg_3;// for module divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_3 <= 'b0;
        end
        else begin
            ap_done_reg_3 <= divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.ap_done & ~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.ap_continue;
        end
    end

    reg ap_done_reg_4;// for module diff_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_4 <= 'b0;
        end
        else begin
            ap_done_reg_4 <= diff_U0.ap_done & ~diff_U0.ap_continue;
        end
    end

    reg ap_done_reg_5;// for module varSum_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_5 <= 'b0;
        end
        else begin
            ap_done_reg_5 <= varSum_U0.ap_done & ~varSum_U0.ap_continue;
        end
    end

    reg ap_done_reg_6;// for module varSum_5_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_6 <= 'b0;
        end
        else begin
            ap_done_reg_6 <= varSum_5_U0.ap_done & ~varSum_5_U0.ap_continue;
        end
    end

    reg ap_done_reg_7;// for module tCalc1_2_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_7 <= 'b0;
        end
        else begin
            ap_done_reg_7 <= tCalc1_2_U0.ap_done & ~tCalc1_2_U0.ap_continue;
        end
    end

    reg ap_done_reg_8;// for module tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_8 <= 'b0;
        end
        else begin
            ap_done_reg_8 <= tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.ap_done & ~tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.ap_continue;
        end
    end

    reg ap_done_reg_9;// for module tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_9 <= 'b0;
        end
        else begin
            ap_done_reg_9 <= tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0.ap_done & ~tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0.ap_continue;
        end
    end

    reg ap_done_reg_10;// for module tCalc1_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_10 <= 'b0;
        end
        else begin
            ap_done_reg_10 <= tCalc1_U0.ap_done & ~tCalc1_U0.ap_continue;
        end
    end

    reg ap_done_reg_11;// for module tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_11 <= 'b0;
        end
        else begin
            ap_done_reg_11 <= tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.ap_done & ~tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.ap_continue;
        end
    end

    reg ap_done_reg_12;// for module tCalc1_U0.tCalc1_Block_entry57_proc_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_12 <= 'b0;
        end
        else begin
            ap_done_reg_12 <= tCalc1_U0.tCalc1_Block_entry57_proc_U0.ap_done & ~tCalc1_U0.tCalc1_Block_entry57_proc_U0.ap_continue;
        end
    end

    reg ap_done_reg_13;// for module tCalc2_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_13 <= 'b0;
        end
        else begin
            ap_done_reg_13 <= tCalc2_U0.ap_done & ~tCalc2_U0.ap_continue;
        end
    end

    reg ap_done_reg_14;// for module tCalc2_U0.tCalc2_Block_entry12_proc_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_14 <= 'b0;
        end
        else begin
            ap_done_reg_14 <= tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_done & ~tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_continue;
        end
    end

    reg ap_done_reg_15;// for module Block_entry2458_proc_U0
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            ap_done_reg_15 <= 'b0;
        end
        else begin
            ap_done_reg_15 <= Block_entry2458_proc_U0.ap_done & ~Block_entry2458_proc_U0.ap_continue;
        end
    end

    // Process: entry_proc_U0
    tTest_hls_deadlock_detect_unit #(17, 0, 3, 3) tTest_hls_deadlock_detect_unit_0 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_0),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_0),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_0),
        .token_in_vec(token_in_vec_0),
        .dl_detect_in(dl_detect_out),
        .origin(origin[0]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_0),
        .out_chan_dep_data(out_chan_dep_data_0),
        .token_out_vec(token_out_vec_0),
        .dl_detect_out(dl_in_vec[0]));

    assign proc_0_data_FIFO_blk[0] = 1'b0 | (~entry_proc_U0.C_c_blk_n);
    assign proc_0_data_PIPO_blk[0] = 1'b0;
    assign proc_0_start_FIFO_blk[0] = 1'b0;
    assign proc_0_TLF_FIFO_blk[0] = 1'b0;
    assign proc_0_input_sync_blk[0] = 1'b0;
    assign proc_0_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_0[0] = dl_detect_out ? proc_dep_vld_vec_0_reg[0] : (proc_0_data_FIFO_blk[0] | proc_0_data_PIPO_blk[0] | proc_0_start_FIFO_blk[0] | proc_0_TLF_FIFO_blk[0] | proc_0_input_sync_blk[0] | proc_0_output_sync_blk[0]);
    assign proc_0_data_FIFO_blk[1] = 1'b0;
    assign proc_0_data_PIPO_blk[1] = 1'b0;
    assign proc_0_start_FIFO_blk[1] = 1'b0;
    assign proc_0_TLF_FIFO_blk[1] = 1'b0;
    assign proc_0_input_sync_blk[1] = 1'b0 | (ap_sync_entry_proc_U0_ap_ready & entry_proc_U0.ap_idle & ~ap_sync_sumStream_U0_ap_ready);
    assign proc_0_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_0[1] = dl_detect_out ? proc_dep_vld_vec_0_reg[1] : (proc_0_data_FIFO_blk[1] | proc_0_data_PIPO_blk[1] | proc_0_start_FIFO_blk[1] | proc_0_TLF_FIFO_blk[1] | proc_0_input_sync_blk[1] | proc_0_output_sync_blk[1]);
    assign proc_0_data_FIFO_blk[2] = 1'b0;
    assign proc_0_data_PIPO_blk[2] = 1'b0;
    assign proc_0_start_FIFO_blk[2] = 1'b0;
    assign proc_0_TLF_FIFO_blk[2] = 1'b0;
    assign proc_0_input_sync_blk[2] = 1'b0 | (ap_sync_entry_proc_U0_ap_ready & entry_proc_U0.ap_idle & ~ap_sync_sumStream_4_U0_ap_ready);
    assign proc_0_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_0[2] = dl_detect_out ? proc_dep_vld_vec_0_reg[2] : (proc_0_data_FIFO_blk[2] | proc_0_data_PIPO_blk[2] | proc_0_start_FIFO_blk[2] | proc_0_TLF_FIFO_blk[2] | proc_0_input_sync_blk[2] | proc_0_output_sync_blk[2]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_0_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_0_reg <= proc_dep_vld_vec_0;
        end
    end
    assign in_chan_dep_vld_vec_0[0] = dep_chan_vld_1_0;
    assign in_chan_dep_data_vec_0[16 : 0] = dep_chan_data_1_0;
    assign token_in_vec_0[0] = token_1_0;
    assign in_chan_dep_vld_vec_0[1] = dep_chan_vld_2_0;
    assign in_chan_dep_data_vec_0[33 : 17] = dep_chan_data_2_0;
    assign token_in_vec_0[1] = token_2_0;
    assign in_chan_dep_vld_vec_0[2] = dep_chan_vld_16_0;
    assign in_chan_dep_data_vec_0[50 : 34] = dep_chan_data_16_0;
    assign token_in_vec_0[2] = token_16_0;
    assign dep_chan_vld_0_16 = out_chan_dep_vld_vec_0[0];
    assign dep_chan_data_0_16 = out_chan_dep_data_0;
    assign token_0_16 = token_out_vec_0[0];
    assign dep_chan_vld_0_1 = out_chan_dep_vld_vec_0[1];
    assign dep_chan_data_0_1 = out_chan_dep_data_0;
    assign token_0_1 = token_out_vec_0[1];
    assign dep_chan_vld_0_2 = out_chan_dep_vld_vec_0[2];
    assign dep_chan_data_0_2 = out_chan_dep_data_0;
    assign token_0_2 = token_out_vec_0[2];

    // Process: sumStream_U0
    tTest_hls_deadlock_detect_unit #(17, 1, 4, 3) tTest_hls_deadlock_detect_unit_1 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_1),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_1),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_1),
        .token_in_vec(token_in_vec_1),
        .dl_detect_in(dl_detect_out),
        .origin(origin[1]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_1),
        .out_chan_dep_data(out_chan_dep_data_1),
        .token_out_vec(token_out_vec_1),
        .dl_detect_out(dl_in_vec[1]));

    assign proc_1_data_FIFO_blk[0] = 1'b0;
    assign proc_1_data_PIPO_blk[0] = 1'b0 | (~famA_U.i_full_n & sumStream_U0.ap_done & ap_done_reg_0 & ~famA_U.t_read);
    assign proc_1_start_FIFO_blk[0] = 1'b0;
    assign proc_1_TLF_FIFO_blk[0] = 1'b0;
    assign proc_1_input_sync_blk[0] = 1'b0;
    assign proc_1_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_1[0] = dl_detect_out ? proc_dep_vld_vec_1_reg[0] : (proc_1_data_FIFO_blk[0] | proc_1_data_PIPO_blk[0] | proc_1_start_FIFO_blk[0] | proc_1_TLF_FIFO_blk[0] | proc_1_input_sync_blk[0] | proc_1_output_sync_blk[0]);
    assign proc_1_data_FIFO_blk[1] = 1'b0;
    assign proc_1_data_PIPO_blk[1] = 1'b0;
    assign proc_1_start_FIFO_blk[1] = 1'b0;
    assign proc_1_TLF_FIFO_blk[1] = 1'b0;
    assign proc_1_input_sync_blk[1] = 1'b0 | (ap_sync_sumStream_U0_ap_ready & sumStream_U0.ap_idle & ~ap_sync_entry_proc_U0_ap_ready);
    assign proc_1_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_1[1] = dl_detect_out ? proc_dep_vld_vec_1_reg[1] : (proc_1_data_FIFO_blk[1] | proc_1_data_PIPO_blk[1] | proc_1_start_FIFO_blk[1] | proc_1_TLF_FIFO_blk[1] | proc_1_input_sync_blk[1] | proc_1_output_sync_blk[1]);
    assign proc_1_data_FIFO_blk[2] = 1'b0;
    assign proc_1_data_PIPO_blk[2] = 1'b0;
    assign proc_1_start_FIFO_blk[2] = 1'b0;
    assign proc_1_TLF_FIFO_blk[2] = 1'b0;
    assign proc_1_input_sync_blk[2] = 1'b0 | (ap_sync_sumStream_U0_ap_ready & sumStream_U0.ap_idle & ~ap_sync_sumStream_4_U0_ap_ready);
    assign proc_1_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_1[2] = dl_detect_out ? proc_dep_vld_vec_1_reg[2] : (proc_1_data_FIFO_blk[2] | proc_1_data_PIPO_blk[2] | proc_1_start_FIFO_blk[2] | proc_1_TLF_FIFO_blk[2] | proc_1_input_sync_blk[2] | proc_1_output_sync_blk[2]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_1_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_1_reg <= proc_dep_vld_vec_1;
        end
    end
    assign in_chan_dep_vld_vec_1[0] = dep_chan_vld_0_1;
    assign in_chan_dep_data_vec_1[16 : 0] = dep_chan_data_0_1;
    assign token_in_vec_1[0] = token_0_1;
    assign in_chan_dep_vld_vec_1[1] = dep_chan_vld_2_1;
    assign in_chan_dep_data_vec_1[33 : 17] = dep_chan_data_2_1;
    assign token_in_vec_1[1] = token_2_1;
    assign in_chan_dep_vld_vec_1[2] = dep_chan_vld_3_1;
    assign in_chan_dep_data_vec_1[50 : 34] = dep_chan_data_3_1;
    assign token_in_vec_1[2] = token_3_1;
    assign in_chan_dep_vld_vec_1[3] = dep_chan_vld_6_1;
    assign in_chan_dep_data_vec_1[67 : 51] = dep_chan_data_6_1;
    assign token_in_vec_1[3] = token_6_1;
    assign dep_chan_vld_1_6 = out_chan_dep_vld_vec_1[0];
    assign dep_chan_data_1_6 = out_chan_dep_data_1;
    assign token_1_6 = token_out_vec_1[0];
    assign dep_chan_vld_1_0 = out_chan_dep_vld_vec_1[1];
    assign dep_chan_data_1_0 = out_chan_dep_data_1;
    assign token_1_0 = token_out_vec_1[1];
    assign dep_chan_vld_1_2 = out_chan_dep_vld_vec_1[2];
    assign dep_chan_data_1_2 = out_chan_dep_data_1;
    assign token_1_2 = token_out_vec_1[2];

    // Process: sumStream_4_U0
    tTest_hls_deadlock_detect_unit #(17, 2, 4, 3) tTest_hls_deadlock_detect_unit_2 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_2),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_2),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_2),
        .token_in_vec(token_in_vec_2),
        .dl_detect_in(dl_detect_out),
        .origin(origin[2]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_2),
        .out_chan_dep_data(out_chan_dep_data_2),
        .token_out_vec(token_out_vec_2),
        .dl_detect_out(dl_in_vec[2]));

    assign proc_2_data_FIFO_blk[0] = 1'b0;
    assign proc_2_data_PIPO_blk[0] = 1'b0 | (~famB_U.i_full_n & sumStream_4_U0.ap_done & ap_done_reg_1 & ~famB_U.t_read);
    assign proc_2_start_FIFO_blk[0] = 1'b0;
    assign proc_2_TLF_FIFO_blk[0] = 1'b0;
    assign proc_2_input_sync_blk[0] = 1'b0;
    assign proc_2_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_2[0] = dl_detect_out ? proc_dep_vld_vec_2_reg[0] : (proc_2_data_FIFO_blk[0] | proc_2_data_PIPO_blk[0] | proc_2_start_FIFO_blk[0] | proc_2_TLF_FIFO_blk[0] | proc_2_input_sync_blk[0] | proc_2_output_sync_blk[0]);
    assign proc_2_data_FIFO_blk[1] = 1'b0;
    assign proc_2_data_PIPO_blk[1] = 1'b0;
    assign proc_2_start_FIFO_blk[1] = 1'b0;
    assign proc_2_TLF_FIFO_blk[1] = 1'b0;
    assign proc_2_input_sync_blk[1] = 1'b0 | (ap_sync_sumStream_4_U0_ap_ready & sumStream_4_U0.ap_idle & ~ap_sync_entry_proc_U0_ap_ready);
    assign proc_2_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_2[1] = dl_detect_out ? proc_dep_vld_vec_2_reg[1] : (proc_2_data_FIFO_blk[1] | proc_2_data_PIPO_blk[1] | proc_2_start_FIFO_blk[1] | proc_2_TLF_FIFO_blk[1] | proc_2_input_sync_blk[1] | proc_2_output_sync_blk[1]);
    assign proc_2_data_FIFO_blk[2] = 1'b0;
    assign proc_2_data_PIPO_blk[2] = 1'b0;
    assign proc_2_start_FIFO_blk[2] = 1'b0;
    assign proc_2_TLF_FIFO_blk[2] = 1'b0;
    assign proc_2_input_sync_blk[2] = 1'b0 | (ap_sync_sumStream_4_U0_ap_ready & sumStream_4_U0.ap_idle & ~ap_sync_sumStream_U0_ap_ready);
    assign proc_2_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_2[2] = dl_detect_out ? proc_dep_vld_vec_2_reg[2] : (proc_2_data_FIFO_blk[2] | proc_2_data_PIPO_blk[2] | proc_2_start_FIFO_blk[2] | proc_2_TLF_FIFO_blk[2] | proc_2_input_sync_blk[2] | proc_2_output_sync_blk[2]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_2_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_2_reg <= proc_dep_vld_vec_2;
        end
    end
    assign in_chan_dep_vld_vec_2[0] = dep_chan_vld_0_2;
    assign in_chan_dep_data_vec_2[16 : 0] = dep_chan_data_0_2;
    assign token_in_vec_2[0] = token_0_2;
    assign in_chan_dep_vld_vec_2[1] = dep_chan_vld_1_2;
    assign in_chan_dep_data_vec_2[33 : 17] = dep_chan_data_1_2;
    assign token_in_vec_2[1] = token_1_2;
    assign in_chan_dep_vld_vec_2[2] = dep_chan_vld_4_2;
    assign in_chan_dep_data_vec_2[50 : 34] = dep_chan_data_4_2;
    assign token_in_vec_2[2] = token_4_2;
    assign in_chan_dep_vld_vec_2[3] = dep_chan_vld_7_2;
    assign in_chan_dep_data_vec_2[67 : 51] = dep_chan_data_7_2;
    assign token_in_vec_2[3] = token_7_2;
    assign dep_chan_vld_2_7 = out_chan_dep_vld_vec_2[0];
    assign dep_chan_data_2_7 = out_chan_dep_data_2;
    assign token_2_7 = token_out_vec_2[0];
    assign dep_chan_vld_2_0 = out_chan_dep_vld_vec_2[1];
    assign dep_chan_data_2_0 = out_chan_dep_data_2;
    assign token_2_0 = token_out_vec_2[1];
    assign dep_chan_vld_2_1 = out_chan_dep_vld_vec_2[2];
    assign dep_chan_data_2_1 = out_chan_dep_data_2;
    assign token_2_1 = token_out_vec_2[2];

    // Process: divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0
    tTest_hls_deadlock_detect_unit #(17, 3, 4, 3) tTest_hls_deadlock_detect_unit_3 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_3),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_3),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_3),
        .token_in_vec(token_in_vec_3),
        .dl_detect_in(dl_detect_out),
        .origin(origin[3]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_3),
        .out_chan_dep_data(out_chan_dep_data_3),
        .token_out_vec(token_out_vec_3),
        .dl_detect_out(dl_in_vec[3]));

    assign proc_3_data_FIFO_blk[0] = 1'b0;
    assign proc_3_data_PIPO_blk[0] = 1'b0;
    assign proc_3_start_FIFO_blk[0] = 1'b0;
    assign proc_3_TLF_FIFO_blk[0] = 1'b0 | (~sumA_channel_U.if_empty_n & divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.ap_idle & ~sumA_channel_U.if_write) | (~numDataA_c70_channel_U.if_empty_n & divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.ap_idle & ~numDataA_c70_channel_U.if_write);
    assign proc_3_input_sync_blk[0] = 1'b0;
    assign proc_3_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_3[0] = dl_detect_out ? proc_dep_vld_vec_3_reg[0] : (proc_3_data_FIFO_blk[0] | proc_3_data_PIPO_blk[0] | proc_3_start_FIFO_blk[0] | proc_3_TLF_FIFO_blk[0] | proc_3_input_sync_blk[0] | proc_3_output_sync_blk[0]);
    assign proc_3_data_FIFO_blk[1] = 1'b0 | (~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.numDataA_c_blk_n);
    assign proc_3_data_PIPO_blk[1] = 1'b0;
    assign proc_3_start_FIFO_blk[1] = 1'b0;
    assign proc_3_TLF_FIFO_blk[1] = 1'b0;
    assign proc_3_input_sync_blk[1] = 1'b0;
    assign proc_3_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_3[1] = dl_detect_out ? proc_dep_vld_vec_3_reg[1] : (proc_3_data_FIFO_blk[1] | proc_3_data_PIPO_blk[1] | proc_3_start_FIFO_blk[1] | proc_3_TLF_FIFO_blk[1] | proc_3_input_sync_blk[1] | proc_3_output_sync_blk[1]);
    assign proc_3_data_FIFO_blk[2] = 1'b0 | (~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.numDataA_c_blk_n);
    assign proc_3_data_PIPO_blk[2] = 1'b0;
    assign proc_3_start_FIFO_blk[2] = 1'b0;
    assign proc_3_TLF_FIFO_blk[2] = 1'b0;
    assign proc_3_input_sync_blk[2] = 1'b0;
    assign proc_3_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_3[2] = dl_detect_out ? proc_dep_vld_vec_3_reg[2] : (proc_3_data_FIFO_blk[2] | proc_3_data_PIPO_blk[2] | proc_3_start_FIFO_blk[2] | proc_3_TLF_FIFO_blk[2] | proc_3_input_sync_blk[2] | proc_3_output_sync_blk[2]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_3_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_3_reg <= proc_dep_vld_vec_3;
        end
    end
    assign in_chan_dep_vld_vec_3[0] = dep_chan_vld_5_3;
    assign in_chan_dep_data_vec_3[16 : 0] = dep_chan_data_5_3;
    assign token_in_vec_3[0] = token_5_3;
    assign in_chan_dep_vld_vec_3[1] = dep_chan_vld_6_3;
    assign in_chan_dep_data_vec_3[33 : 17] = dep_chan_data_6_3;
    assign token_in_vec_3[1] = token_6_3;
    assign in_chan_dep_vld_vec_3[2] = dep_chan_vld_8_3;
    assign in_chan_dep_data_vec_3[50 : 34] = dep_chan_data_8_3;
    assign token_in_vec_3[2] = token_8_3;
    assign in_chan_dep_vld_vec_3[3] = dep_chan_vld_9_3;
    assign in_chan_dep_data_vec_3[67 : 51] = dep_chan_data_9_3;
    assign token_in_vec_3[3] = token_9_3;
    assign dep_chan_vld_3_1 = out_chan_dep_vld_vec_3[0];
    assign dep_chan_data_3_1 = out_chan_dep_data_3;
    assign token_3_1 = token_out_vec_3[0];
    assign dep_chan_vld_3_8 = out_chan_dep_vld_vec_3[1];
    assign dep_chan_data_3_8 = out_chan_dep_data_3;
    assign token_3_8 = token_out_vec_3[1];
    assign dep_chan_vld_3_9 = out_chan_dep_vld_vec_3[2];
    assign dep_chan_data_3_9 = out_chan_dep_data_3;
    assign token_3_9 = token_out_vec_3[2];

    // Process: divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0
    tTest_hls_deadlock_detect_unit #(17, 4, 4, 3) tTest_hls_deadlock_detect_unit_4 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_4),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_4),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_4),
        .token_in_vec(token_in_vec_4),
        .dl_detect_in(dl_detect_out),
        .origin(origin[4]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_4),
        .out_chan_dep_data(out_chan_dep_data_4),
        .token_out_vec(token_out_vec_4),
        .dl_detect_out(dl_in_vec[4]));

    assign proc_4_data_FIFO_blk[0] = 1'b0;
    assign proc_4_data_PIPO_blk[0] = 1'b0;
    assign proc_4_start_FIFO_blk[0] = 1'b0;
    assign proc_4_TLF_FIFO_blk[0] = 1'b0 | (~sumB_channel_U.if_empty_n & divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.ap_idle & ~sumB_channel_U.if_write) | (~numDataB_c71_channel_U.if_empty_n & divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.ap_idle & ~numDataB_c71_channel_U.if_write);
    assign proc_4_input_sync_blk[0] = 1'b0;
    assign proc_4_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_4[0] = dl_detect_out ? proc_dep_vld_vec_4_reg[0] : (proc_4_data_FIFO_blk[0] | proc_4_data_PIPO_blk[0] | proc_4_start_FIFO_blk[0] | proc_4_TLF_FIFO_blk[0] | proc_4_input_sync_blk[0] | proc_4_output_sync_blk[0]);
    assign proc_4_data_FIFO_blk[1] = 1'b0 | (~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.numDataB_c_blk_n);
    assign proc_4_data_PIPO_blk[1] = 1'b0;
    assign proc_4_start_FIFO_blk[1] = 1'b0;
    assign proc_4_TLF_FIFO_blk[1] = 1'b0;
    assign proc_4_input_sync_blk[1] = 1'b0;
    assign proc_4_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_4[1] = dl_detect_out ? proc_dep_vld_vec_4_reg[1] : (proc_4_data_FIFO_blk[1] | proc_4_data_PIPO_blk[1] | proc_4_start_FIFO_blk[1] | proc_4_TLF_FIFO_blk[1] | proc_4_input_sync_blk[1] | proc_4_output_sync_blk[1]);
    assign proc_4_data_FIFO_blk[2] = 1'b0 | (~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.numDataB_c_blk_n);
    assign proc_4_data_PIPO_blk[2] = 1'b0;
    assign proc_4_start_FIFO_blk[2] = 1'b0;
    assign proc_4_TLF_FIFO_blk[2] = 1'b0;
    assign proc_4_input_sync_blk[2] = 1'b0;
    assign proc_4_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_4[2] = dl_detect_out ? proc_dep_vld_vec_4_reg[2] : (proc_4_data_FIFO_blk[2] | proc_4_data_PIPO_blk[2] | proc_4_start_FIFO_blk[2] | proc_4_TLF_FIFO_blk[2] | proc_4_input_sync_blk[2] | proc_4_output_sync_blk[2]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_4_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_4_reg <= proc_dep_vld_vec_4;
        end
    end
    assign in_chan_dep_vld_vec_4[0] = dep_chan_vld_5_4;
    assign in_chan_dep_data_vec_4[16 : 0] = dep_chan_data_5_4;
    assign token_in_vec_4[0] = token_5_4;
    assign in_chan_dep_vld_vec_4[1] = dep_chan_vld_7_4;
    assign in_chan_dep_data_vec_4[33 : 17] = dep_chan_data_7_4;
    assign token_in_vec_4[1] = token_7_4;
    assign in_chan_dep_vld_vec_4[2] = dep_chan_vld_11_4;
    assign in_chan_dep_data_vec_4[50 : 34] = dep_chan_data_11_4;
    assign token_in_vec_4[2] = token_11_4;
    assign in_chan_dep_vld_vec_4[3] = dep_chan_vld_12_4;
    assign in_chan_dep_data_vec_4[67 : 51] = dep_chan_data_12_4;
    assign token_in_vec_4[3] = token_12_4;
    assign dep_chan_vld_4_2 = out_chan_dep_vld_vec_4[0];
    assign dep_chan_data_4_2 = out_chan_dep_data_4;
    assign token_4_2 = token_out_vec_4[0];
    assign dep_chan_vld_4_11 = out_chan_dep_vld_vec_4[1];
    assign dep_chan_data_4_11 = out_chan_dep_data_4;
    assign token_4_11 = token_out_vec_4[1];
    assign dep_chan_vld_4_12 = out_chan_dep_vld_vec_4[2];
    assign dep_chan_data_4_12 = out_chan_dep_data_4;
    assign token_4_12 = token_out_vec_4[2];

    // Process: diff_U0
    tTest_hls_deadlock_detect_unit #(17, 5, 2, 2) tTest_hls_deadlock_detect_unit_5 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_5),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_5),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_5),
        .token_in_vec(token_in_vec_5),
        .dl_detect_in(dl_detect_out),
        .origin(origin[5]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_5),
        .out_chan_dep_data(out_chan_dep_data_5),
        .token_out_vec(token_out_vec_5),
        .dl_detect_out(dl_in_vec[5]));

    assign proc_5_data_FIFO_blk[0] = 1'b0;
    assign proc_5_data_PIPO_blk[0] = 1'b0;
    assign proc_5_start_FIFO_blk[0] = 1'b0;
    assign proc_5_TLF_FIFO_blk[0] = 1'b0 | (~meanA_c72_channel_U.if_empty_n & diff_U0.ap_idle & ~meanA_c72_channel_U.if_write);
    assign proc_5_input_sync_blk[0] = 1'b0;
    assign proc_5_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_5[0] = dl_detect_out ? proc_dep_vld_vec_5_reg[0] : (proc_5_data_FIFO_blk[0] | proc_5_data_PIPO_blk[0] | proc_5_start_FIFO_blk[0] | proc_5_TLF_FIFO_blk[0] | proc_5_input_sync_blk[0] | proc_5_output_sync_blk[0]);
    assign proc_5_data_FIFO_blk[1] = 1'b0;
    assign proc_5_data_PIPO_blk[1] = 1'b0;
    assign proc_5_start_FIFO_blk[1] = 1'b0;
    assign proc_5_TLF_FIFO_blk[1] = 1'b0 | (~meanB_c73_channel_U.if_empty_n & diff_U0.ap_idle & ~meanB_c73_channel_U.if_write);
    assign proc_5_input_sync_blk[1] = 1'b0;
    assign proc_5_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_5[1] = dl_detect_out ? proc_dep_vld_vec_5_reg[1] : (proc_5_data_FIFO_blk[1] | proc_5_data_PIPO_blk[1] | proc_5_start_FIFO_blk[1] | proc_5_TLF_FIFO_blk[1] | proc_5_input_sync_blk[1] | proc_5_output_sync_blk[1]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_5_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_5_reg <= proc_dep_vld_vec_5;
        end
    end
    assign in_chan_dep_vld_vec_5[0] = dep_chan_vld_14_5;
    assign in_chan_dep_data_vec_5[16 : 0] = dep_chan_data_14_5;
    assign token_in_vec_5[0] = token_14_5;
    assign in_chan_dep_vld_vec_5[1] = dep_chan_vld_15_5;
    assign in_chan_dep_data_vec_5[33 : 17] = dep_chan_data_15_5;
    assign token_in_vec_5[1] = token_15_5;
    assign dep_chan_vld_5_3 = out_chan_dep_vld_vec_5[0];
    assign dep_chan_data_5_3 = out_chan_dep_data_5;
    assign token_5_3 = token_out_vec_5[0];
    assign dep_chan_vld_5_4 = out_chan_dep_vld_vec_5[1];
    assign dep_chan_data_5_4 = out_chan_dep_data_5;
    assign token_5_4 = token_out_vec_5[1];

    // Process: varSum_U0
    tTest_hls_deadlock_detect_unit #(17, 6, 3, 2) tTest_hls_deadlock_detect_unit_6 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_6),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_6),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_6),
        .token_in_vec(token_in_vec_6),
        .dl_detect_in(dl_detect_out),
        .origin(origin[6]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_6),
        .out_chan_dep_data(out_chan_dep_data_6),
        .token_out_vec(token_out_vec_6),
        .dl_detect_out(dl_in_vec[6]));

    assign proc_6_data_FIFO_blk[0] = 1'b0;
    assign proc_6_data_PIPO_blk[0] = 1'b0 | (~famA_U.t_empty_n & varSum_U0.ap_idle & ~famA_U.i_write);
    assign proc_6_start_FIFO_blk[0] = 1'b0;
    assign proc_6_TLF_FIFO_blk[0] = 1'b0;
    assign proc_6_input_sync_blk[0] = 1'b0;
    assign proc_6_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_6[0] = dl_detect_out ? proc_dep_vld_vec_6_reg[0] : (proc_6_data_FIFO_blk[0] | proc_6_data_PIPO_blk[0] | proc_6_start_FIFO_blk[0] | proc_6_TLF_FIFO_blk[0] | proc_6_input_sync_blk[0] | proc_6_output_sync_blk[0]);
    assign proc_6_data_FIFO_blk[1] = 1'b0;
    assign proc_6_data_PIPO_blk[1] = 1'b0;
    assign proc_6_start_FIFO_blk[1] = 1'b0;
    assign proc_6_TLF_FIFO_blk[1] = 1'b0 | (~meanA_c_channel_U.if_empty_n & varSum_U0.ap_idle & ~meanA_c_channel_U.if_write);
    assign proc_6_input_sync_blk[1] = 1'b0;
    assign proc_6_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_6[1] = dl_detect_out ? proc_dep_vld_vec_6_reg[1] : (proc_6_data_FIFO_blk[1] | proc_6_data_PIPO_blk[1] | proc_6_start_FIFO_blk[1] | proc_6_TLF_FIFO_blk[1] | proc_6_input_sync_blk[1] | proc_6_output_sync_blk[1]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_6_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_6_reg <= proc_dep_vld_vec_6;
        end
    end
    assign in_chan_dep_vld_vec_6[0] = dep_chan_vld_1_6;
    assign in_chan_dep_data_vec_6[16 : 0] = dep_chan_data_1_6;
    assign token_in_vec_6[0] = token_1_6;
    assign in_chan_dep_vld_vec_6[1] = dep_chan_vld_8_6;
    assign in_chan_dep_data_vec_6[33 : 17] = dep_chan_data_8_6;
    assign token_in_vec_6[1] = token_8_6;
    assign in_chan_dep_vld_vec_6[2] = dep_chan_vld_9_6;
    assign in_chan_dep_data_vec_6[50 : 34] = dep_chan_data_9_6;
    assign token_in_vec_6[2] = token_9_6;
    assign dep_chan_vld_6_1 = out_chan_dep_vld_vec_6[0];
    assign dep_chan_data_6_1 = out_chan_dep_data_6;
    assign token_6_1 = token_out_vec_6[0];
    assign dep_chan_vld_6_3 = out_chan_dep_vld_vec_6[1];
    assign dep_chan_data_6_3 = out_chan_dep_data_6;
    assign token_6_3 = token_out_vec_6[1];

    // Process: varSum_5_U0
    tTest_hls_deadlock_detect_unit #(17, 7, 3, 2) tTest_hls_deadlock_detect_unit_7 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_7),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_7),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_7),
        .token_in_vec(token_in_vec_7),
        .dl_detect_in(dl_detect_out),
        .origin(origin[7]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_7),
        .out_chan_dep_data(out_chan_dep_data_7),
        .token_out_vec(token_out_vec_7),
        .dl_detect_out(dl_in_vec[7]));

    assign proc_7_data_FIFO_blk[0] = 1'b0;
    assign proc_7_data_PIPO_blk[0] = 1'b0 | (~famB_U.t_empty_n & varSum_5_U0.ap_idle & ~famB_U.i_write);
    assign proc_7_start_FIFO_blk[0] = 1'b0;
    assign proc_7_TLF_FIFO_blk[0] = 1'b0;
    assign proc_7_input_sync_blk[0] = 1'b0;
    assign proc_7_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_7[0] = dl_detect_out ? proc_dep_vld_vec_7_reg[0] : (proc_7_data_FIFO_blk[0] | proc_7_data_PIPO_blk[0] | proc_7_start_FIFO_blk[0] | proc_7_TLF_FIFO_blk[0] | proc_7_input_sync_blk[0] | proc_7_output_sync_blk[0]);
    assign proc_7_data_FIFO_blk[1] = 1'b0;
    assign proc_7_data_PIPO_blk[1] = 1'b0;
    assign proc_7_start_FIFO_blk[1] = 1'b0;
    assign proc_7_TLF_FIFO_blk[1] = 1'b0 | (~meanB_c_channel_U.if_empty_n & varSum_5_U0.ap_idle & ~meanB_c_channel_U.if_write);
    assign proc_7_input_sync_blk[1] = 1'b0;
    assign proc_7_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_7[1] = dl_detect_out ? proc_dep_vld_vec_7_reg[1] : (proc_7_data_FIFO_blk[1] | proc_7_data_PIPO_blk[1] | proc_7_start_FIFO_blk[1] | proc_7_TLF_FIFO_blk[1] | proc_7_input_sync_blk[1] | proc_7_output_sync_blk[1]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_7_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_7_reg <= proc_dep_vld_vec_7;
        end
    end
    assign in_chan_dep_vld_vec_7[0] = dep_chan_vld_2_7;
    assign in_chan_dep_data_vec_7[16 : 0] = dep_chan_data_2_7;
    assign token_in_vec_7[0] = token_2_7;
    assign in_chan_dep_vld_vec_7[1] = dep_chan_vld_11_7;
    assign in_chan_dep_data_vec_7[33 : 17] = dep_chan_data_11_7;
    assign token_in_vec_7[1] = token_11_7;
    assign in_chan_dep_vld_vec_7[2] = dep_chan_vld_12_7;
    assign in_chan_dep_data_vec_7[50 : 34] = dep_chan_data_12_7;
    assign token_in_vec_7[2] = token_12_7;
    assign dep_chan_vld_7_2 = out_chan_dep_vld_vec_7[0];
    assign dep_chan_data_7_2 = out_chan_dep_data_7;
    assign token_7_2 = token_out_vec_7[0];
    assign dep_chan_vld_7_4 = out_chan_dep_vld_vec_7[1];
    assign dep_chan_data_7_4 = out_chan_dep_data_7;
    assign token_7_4 = token_out_vec_7[1];

    // Process: tCalc1_2_U0
    tTest_hls_deadlock_detect_unit #(17, 8, 3, 4) tTest_hls_deadlock_detect_unit_8 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_8),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_8),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_8),
        .token_in_vec(token_in_vec_8),
        .dl_detect_in(dl_detect_out),
        .origin(origin[8]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_8),
        .out_chan_dep_data(out_chan_dep_data_8),
        .token_out_vec(token_out_vec_8),
        .dl_detect_out(dl_in_vec[8]));

    assign proc_8_data_FIFO_blk[0] = 1'b0;
    assign proc_8_data_PIPO_blk[0] = 1'b0;
    assign proc_8_start_FIFO_blk[0] = 1'b0;
    assign proc_8_TLF_FIFO_blk[0] = 1'b0 | (~varSumA_channel_U.if_empty_n & tCalc1_2_U0.ap_idle & ~varSumA_channel_U.if_write);
    assign proc_8_input_sync_blk[0] = 1'b0;
    assign proc_8_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_8[0] = dl_detect_out ? proc_dep_vld_vec_8_reg[0] : (proc_8_data_FIFO_blk[0] | proc_8_data_PIPO_blk[0] | proc_8_start_FIFO_blk[0] | proc_8_TLF_FIFO_blk[0] | proc_8_input_sync_blk[0] | proc_8_output_sync_blk[0]);
    assign proc_8_data_FIFO_blk[1] = 1'b0 | (~tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.numDataA_blk_n);
    assign proc_8_data_PIPO_blk[1] = 1'b0;
    assign proc_8_start_FIFO_blk[1] = 1'b0;
    assign proc_8_TLF_FIFO_blk[1] = 1'b0;
    assign proc_8_input_sync_blk[1] = 1'b0;
    assign proc_8_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_8[1] = dl_detect_out ? proc_dep_vld_vec_8_reg[1] : (proc_8_data_FIFO_blk[1] | proc_8_data_PIPO_blk[1] | proc_8_start_FIFO_blk[1] | proc_8_TLF_FIFO_blk[1] | proc_8_input_sync_blk[1] | proc_8_output_sync_blk[1]);
    assign proc_8_data_FIFO_blk[2] = 1'b0;
    assign proc_8_data_PIPO_blk[2] = 1'b0;
    assign proc_8_start_FIFO_blk[2] = 1'b0;
    assign proc_8_TLF_FIFO_blk[2] = 1'b0 | (~tCalc1ResultA_U.if_full_n & tCalc1_2_U0.ap_done & ap_done_reg_7 & ~tCalc1ResultA_U.if_read);
    assign proc_8_input_sync_blk[2] = 1'b0;
    assign proc_8_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_8[2] = dl_detect_out ? proc_dep_vld_vec_8_reg[2] : (proc_8_data_FIFO_blk[2] | proc_8_data_PIPO_blk[2] | proc_8_start_FIFO_blk[2] | proc_8_TLF_FIFO_blk[2] | proc_8_input_sync_blk[2] | proc_8_output_sync_blk[2]);
    assign proc_8_data_FIFO_blk[3] = 1'b0;
    assign proc_8_data_PIPO_blk[3] = 1'b0;
    assign proc_8_start_FIFO_blk[3] = 1'b0;
    assign proc_8_TLF_FIFO_blk[3] = 1'b0 | (~tCalc1ResultA_U.if_full_n & tCalc1_2_U0.ap_done & ap_done_reg_7 & ~tCalc1ResultA_U.if_read);
    assign proc_8_input_sync_blk[3] = 1'b0;
    assign proc_8_output_sync_blk[3] = 1'b0;
    assign proc_dep_vld_vec_8[3] = dl_detect_out ? proc_dep_vld_vec_8_reg[3] : (proc_8_data_FIFO_blk[3] | proc_8_data_PIPO_blk[3] | proc_8_start_FIFO_blk[3] | proc_8_TLF_FIFO_blk[3] | proc_8_input_sync_blk[3] | proc_8_output_sync_blk[3]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_8_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_8_reg <= proc_dep_vld_vec_8;
        end
    end
    assign in_chan_dep_vld_vec_8[0] = dep_chan_vld_3_8;
    assign in_chan_dep_data_vec_8[16 : 0] = dep_chan_data_3_8;
    assign token_in_vec_8[0] = token_3_8;
    assign in_chan_dep_vld_vec_8[1] = dep_chan_vld_14_8;
    assign in_chan_dep_data_vec_8[33 : 17] = dep_chan_data_14_8;
    assign token_in_vec_8[1] = token_14_8;
    assign in_chan_dep_vld_vec_8[2] = dep_chan_vld_15_8;
    assign in_chan_dep_data_vec_8[50 : 34] = dep_chan_data_15_8;
    assign token_in_vec_8[2] = token_15_8;
    assign dep_chan_vld_8_6 = out_chan_dep_vld_vec_8[0];
    assign dep_chan_data_8_6 = out_chan_dep_data_8;
    assign token_8_6 = token_out_vec_8[0];
    assign dep_chan_vld_8_3 = out_chan_dep_vld_vec_8[1];
    assign dep_chan_data_8_3 = out_chan_dep_data_8;
    assign token_8_3 = token_out_vec_8[1];
    assign dep_chan_vld_8_14 = out_chan_dep_vld_vec_8[2];
    assign dep_chan_data_8_14 = out_chan_dep_data_8;
    assign token_8_14 = token_out_vec_8[2];
    assign dep_chan_vld_8_15 = out_chan_dep_vld_vec_8[3];
    assign dep_chan_data_8_15 = out_chan_dep_data_8;
    assign token_8_15 = token_out_vec_8[3];

    // Process: tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0
    tTest_hls_deadlock_detect_unit #(17, 9, 2, 3) tTest_hls_deadlock_detect_unit_9 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_9),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_9),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_9),
        .token_in_vec(token_in_vec_9),
        .dl_detect_in(dl_detect_out),
        .origin(origin[9]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_9),
        .out_chan_dep_data(out_chan_dep_data_9),
        .token_out_vec(token_out_vec_9),
        .dl_detect_out(dl_in_vec[9]));

    assign proc_9_data_FIFO_blk[0] = 1'b0;
    assign proc_9_data_PIPO_blk[0] = 1'b0;
    assign proc_9_start_FIFO_blk[0] = 1'b0;
    assign proc_9_TLF_FIFO_blk[0] = 1'b0 | (~varSumA_channel_U.if_empty_n & tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.ap_idle & ~varSumA_channel_U.if_write);
    assign proc_9_input_sync_blk[0] = 1'b0;
    assign proc_9_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_9[0] = dl_detect_out ? proc_dep_vld_vec_9_reg[0] : (proc_9_data_FIFO_blk[0] | proc_9_data_PIPO_blk[0] | proc_9_start_FIFO_blk[0] | proc_9_TLF_FIFO_blk[0] | proc_9_input_sync_blk[0] | proc_9_output_sync_blk[0]);
    assign proc_9_data_FIFO_blk[1] = 1'b0 | (~tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.numDataA_blk_n);
    assign proc_9_data_PIPO_blk[1] = 1'b0;
    assign proc_9_start_FIFO_blk[1] = 1'b0;
    assign proc_9_TLF_FIFO_blk[1] = 1'b0;
    assign proc_9_input_sync_blk[1] = 1'b0;
    assign proc_9_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_9[1] = dl_detect_out ? proc_dep_vld_vec_9_reg[1] : (proc_9_data_FIFO_blk[1] | proc_9_data_PIPO_blk[1] | proc_9_start_FIFO_blk[1] | proc_9_TLF_FIFO_blk[1] | proc_9_input_sync_blk[1] | proc_9_output_sync_blk[1]);
    assign proc_9_data_FIFO_blk[2] = 1'b0 | (~tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.numDataA_c_blk_n);
    assign proc_9_data_PIPO_blk[2] = 1'b0;
    assign proc_9_start_FIFO_blk[2] = 1'b0;
    assign proc_9_TLF_FIFO_blk[2] = 1'b0;
    assign proc_9_input_sync_blk[2] = 1'b0;
    assign proc_9_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_9[2] = dl_detect_out ? proc_dep_vld_vec_9_reg[2] : (proc_9_data_FIFO_blk[2] | proc_9_data_PIPO_blk[2] | proc_9_start_FIFO_blk[2] | proc_9_TLF_FIFO_blk[2] | proc_9_input_sync_blk[2] | proc_9_output_sync_blk[2]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_9_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_9_reg <= proc_dep_vld_vec_9;
        end
    end
    assign in_chan_dep_vld_vec_9[0] = dep_chan_vld_3_9;
    assign in_chan_dep_data_vec_9[16 : 0] = dep_chan_data_3_9;
    assign token_in_vec_9[0] = token_3_9;
    assign in_chan_dep_vld_vec_9[1] = dep_chan_vld_10_9;
    assign in_chan_dep_data_vec_9[33 : 17] = dep_chan_data_10_9;
    assign token_in_vec_9[1] = token_10_9;
    assign dep_chan_vld_9_6 = out_chan_dep_vld_vec_9[0];
    assign dep_chan_data_9_6 = out_chan_dep_data_9;
    assign token_9_6 = token_out_vec_9[0];
    assign dep_chan_vld_9_3 = out_chan_dep_vld_vec_9[1];
    assign dep_chan_data_9_3 = out_chan_dep_data_9;
    assign token_9_3 = token_out_vec_9[1];
    assign dep_chan_vld_9_10 = out_chan_dep_vld_vec_9[2];
    assign dep_chan_data_9_10 = out_chan_dep_data_9;
    assign token_9_10 = token_out_vec_9[2];

    // Process: tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0
    tTest_hls_deadlock_detect_unit #(17, 10, 3, 3) tTest_hls_deadlock_detect_unit_10 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_10),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_10),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_10),
        .token_in_vec(token_in_vec_10),
        .dl_detect_in(dl_detect_out),
        .origin(origin[10]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_10),
        .out_chan_dep_data(out_chan_dep_data_10),
        .token_out_vec(token_out_vec_10),
        .dl_detect_out(dl_in_vec[10]));

    assign proc_10_data_FIFO_blk[0] = 1'b0 | (~tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0.numDataA_blk_n);
    assign proc_10_data_PIPO_blk[0] = 1'b0;
    assign proc_10_start_FIFO_blk[0] = 1'b0;
    assign proc_10_TLF_FIFO_blk[0] = 1'b0 | (~tCalc1_2_U0.var_r_U.if_empty_n & tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0.ap_idle & ~tCalc1_2_U0.var_r_U.if_write);
    assign proc_10_input_sync_blk[0] = 1'b0;
    assign proc_10_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_10[0] = dl_detect_out ? proc_dep_vld_vec_10_reg[0] : (proc_10_data_FIFO_blk[0] | proc_10_data_PIPO_blk[0] | proc_10_start_FIFO_blk[0] | proc_10_TLF_FIFO_blk[0] | proc_10_input_sync_blk[0] | proc_10_output_sync_blk[0]);
    assign proc_10_data_FIFO_blk[1] = 1'b0;
    assign proc_10_data_PIPO_blk[1] = 1'b0;
    assign proc_10_start_FIFO_blk[1] = 1'b0;
    assign proc_10_TLF_FIFO_blk[1] = 1'b0 | (~tCalc1ResultA_U.if_full_n & tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0.ap_done & ap_done_reg_9 & ~tCalc1ResultA_U.if_read);
    assign proc_10_input_sync_blk[1] = 1'b0;
    assign proc_10_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_10[1] = dl_detect_out ? proc_dep_vld_vec_10_reg[1] : (proc_10_data_FIFO_blk[1] | proc_10_data_PIPO_blk[1] | proc_10_start_FIFO_blk[1] | proc_10_TLF_FIFO_blk[1] | proc_10_input_sync_blk[1] | proc_10_output_sync_blk[1]);
    assign proc_10_data_FIFO_blk[2] = 1'b0;
    assign proc_10_data_PIPO_blk[2] = 1'b0;
    assign proc_10_start_FIFO_blk[2] = 1'b0;
    assign proc_10_TLF_FIFO_blk[2] = 1'b0 | (~tCalc1ResultA_U.if_full_n & tCalc1_2_U0.tCalc1_2_Block_entry57_proc_U0.ap_done & ap_done_reg_9 & ~tCalc1ResultA_U.if_read);
    assign proc_10_input_sync_blk[2] = 1'b0;
    assign proc_10_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_10[2] = dl_detect_out ? proc_dep_vld_vec_10_reg[2] : (proc_10_data_FIFO_blk[2] | proc_10_data_PIPO_blk[2] | proc_10_start_FIFO_blk[2] | proc_10_TLF_FIFO_blk[2] | proc_10_input_sync_blk[2] | proc_10_output_sync_blk[2]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_10_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_10_reg <= proc_dep_vld_vec_10;
        end
    end
    assign in_chan_dep_vld_vec_10[0] = dep_chan_vld_9_10;
    assign in_chan_dep_data_vec_10[16 : 0] = dep_chan_data_9_10;
    assign token_in_vec_10[0] = token_9_10;
    assign in_chan_dep_vld_vec_10[1] = dep_chan_vld_14_10;
    assign in_chan_dep_data_vec_10[33 : 17] = dep_chan_data_14_10;
    assign token_in_vec_10[1] = token_14_10;
    assign in_chan_dep_vld_vec_10[2] = dep_chan_vld_15_10;
    assign in_chan_dep_data_vec_10[50 : 34] = dep_chan_data_15_10;
    assign token_in_vec_10[2] = token_15_10;
    assign dep_chan_vld_10_9 = out_chan_dep_vld_vec_10[0];
    assign dep_chan_data_10_9 = out_chan_dep_data_10;
    assign token_10_9 = token_out_vec_10[0];
    assign dep_chan_vld_10_14 = out_chan_dep_vld_vec_10[1];
    assign dep_chan_data_10_14 = out_chan_dep_data_10;
    assign token_10_14 = token_out_vec_10[1];
    assign dep_chan_vld_10_15 = out_chan_dep_vld_vec_10[2];
    assign dep_chan_data_10_15 = out_chan_dep_data_10;
    assign token_10_15 = token_out_vec_10[2];

    // Process: tCalc1_U0
    tTest_hls_deadlock_detect_unit #(17, 11, 3, 4) tTest_hls_deadlock_detect_unit_11 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_11),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_11),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_11),
        .token_in_vec(token_in_vec_11),
        .dl_detect_in(dl_detect_out),
        .origin(origin[11]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_11),
        .out_chan_dep_data(out_chan_dep_data_11),
        .token_out_vec(token_out_vec_11),
        .dl_detect_out(dl_in_vec[11]));

    assign proc_11_data_FIFO_blk[0] = 1'b0;
    assign proc_11_data_PIPO_blk[0] = 1'b0;
    assign proc_11_start_FIFO_blk[0] = 1'b0;
    assign proc_11_TLF_FIFO_blk[0] = 1'b0 | (~varSumB_channel_U.if_empty_n & tCalc1_U0.ap_idle & ~varSumB_channel_U.if_write);
    assign proc_11_input_sync_blk[0] = 1'b0;
    assign proc_11_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_11[0] = dl_detect_out ? proc_dep_vld_vec_11_reg[0] : (proc_11_data_FIFO_blk[0] | proc_11_data_PIPO_blk[0] | proc_11_start_FIFO_blk[0] | proc_11_TLF_FIFO_blk[0] | proc_11_input_sync_blk[0] | proc_11_output_sync_blk[0]);
    assign proc_11_data_FIFO_blk[1] = 1'b0 | (~tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.numDataB_blk_n);
    assign proc_11_data_PIPO_blk[1] = 1'b0;
    assign proc_11_start_FIFO_blk[1] = 1'b0;
    assign proc_11_TLF_FIFO_blk[1] = 1'b0;
    assign proc_11_input_sync_blk[1] = 1'b0;
    assign proc_11_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_11[1] = dl_detect_out ? proc_dep_vld_vec_11_reg[1] : (proc_11_data_FIFO_blk[1] | proc_11_data_PIPO_blk[1] | proc_11_start_FIFO_blk[1] | proc_11_TLF_FIFO_blk[1] | proc_11_input_sync_blk[1] | proc_11_output_sync_blk[1]);
    assign proc_11_data_FIFO_blk[2] = 1'b0;
    assign proc_11_data_PIPO_blk[2] = 1'b0;
    assign proc_11_start_FIFO_blk[2] = 1'b0;
    assign proc_11_TLF_FIFO_blk[2] = 1'b0 | (~tCalc1ResultB_U.if_full_n & tCalc1_U0.ap_done & ap_done_reg_10 & ~tCalc1ResultB_U.if_read);
    assign proc_11_input_sync_blk[2] = 1'b0;
    assign proc_11_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_11[2] = dl_detect_out ? proc_dep_vld_vec_11_reg[2] : (proc_11_data_FIFO_blk[2] | proc_11_data_PIPO_blk[2] | proc_11_start_FIFO_blk[2] | proc_11_TLF_FIFO_blk[2] | proc_11_input_sync_blk[2] | proc_11_output_sync_blk[2]);
    assign proc_11_data_FIFO_blk[3] = 1'b0;
    assign proc_11_data_PIPO_blk[3] = 1'b0;
    assign proc_11_start_FIFO_blk[3] = 1'b0;
    assign proc_11_TLF_FIFO_blk[3] = 1'b0 | (~tCalc1ResultB_U.if_full_n & tCalc1_U0.ap_done & ap_done_reg_10 & ~tCalc1ResultB_U.if_read);
    assign proc_11_input_sync_blk[3] = 1'b0;
    assign proc_11_output_sync_blk[3] = 1'b0;
    assign proc_dep_vld_vec_11[3] = dl_detect_out ? proc_dep_vld_vec_11_reg[3] : (proc_11_data_FIFO_blk[3] | proc_11_data_PIPO_blk[3] | proc_11_start_FIFO_blk[3] | proc_11_TLF_FIFO_blk[3] | proc_11_input_sync_blk[3] | proc_11_output_sync_blk[3]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_11_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_11_reg <= proc_dep_vld_vec_11;
        end
    end
    assign in_chan_dep_vld_vec_11[0] = dep_chan_vld_4_11;
    assign in_chan_dep_data_vec_11[16 : 0] = dep_chan_data_4_11;
    assign token_in_vec_11[0] = token_4_11;
    assign in_chan_dep_vld_vec_11[1] = dep_chan_vld_14_11;
    assign in_chan_dep_data_vec_11[33 : 17] = dep_chan_data_14_11;
    assign token_in_vec_11[1] = token_14_11;
    assign in_chan_dep_vld_vec_11[2] = dep_chan_vld_15_11;
    assign in_chan_dep_data_vec_11[50 : 34] = dep_chan_data_15_11;
    assign token_in_vec_11[2] = token_15_11;
    assign dep_chan_vld_11_7 = out_chan_dep_vld_vec_11[0];
    assign dep_chan_data_11_7 = out_chan_dep_data_11;
    assign token_11_7 = token_out_vec_11[0];
    assign dep_chan_vld_11_4 = out_chan_dep_vld_vec_11[1];
    assign dep_chan_data_11_4 = out_chan_dep_data_11;
    assign token_11_4 = token_out_vec_11[1];
    assign dep_chan_vld_11_14 = out_chan_dep_vld_vec_11[2];
    assign dep_chan_data_11_14 = out_chan_dep_data_11;
    assign token_11_14 = token_out_vec_11[2];
    assign dep_chan_vld_11_15 = out_chan_dep_vld_vec_11[3];
    assign dep_chan_data_11_15 = out_chan_dep_data_11;
    assign token_11_15 = token_out_vec_11[3];

    // Process: tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0
    tTest_hls_deadlock_detect_unit #(17, 12, 2, 3) tTest_hls_deadlock_detect_unit_12 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_12),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_12),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_12),
        .token_in_vec(token_in_vec_12),
        .dl_detect_in(dl_detect_out),
        .origin(origin[12]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_12),
        .out_chan_dep_data(out_chan_dep_data_12),
        .token_out_vec(token_out_vec_12),
        .dl_detect_out(dl_in_vec[12]));

    assign proc_12_data_FIFO_blk[0] = 1'b0;
    assign proc_12_data_PIPO_blk[0] = 1'b0;
    assign proc_12_start_FIFO_blk[0] = 1'b0;
    assign proc_12_TLF_FIFO_blk[0] = 1'b0 | (~varSumB_channel_U.if_empty_n & tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.ap_idle & ~varSumB_channel_U.if_write);
    assign proc_12_input_sync_blk[0] = 1'b0;
    assign proc_12_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_12[0] = dl_detect_out ? proc_dep_vld_vec_12_reg[0] : (proc_12_data_FIFO_blk[0] | proc_12_data_PIPO_blk[0] | proc_12_start_FIFO_blk[0] | proc_12_TLF_FIFO_blk[0] | proc_12_input_sync_blk[0] | proc_12_output_sync_blk[0]);
    assign proc_12_data_FIFO_blk[1] = 1'b0 | (~tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.numDataB_blk_n);
    assign proc_12_data_PIPO_blk[1] = 1'b0;
    assign proc_12_start_FIFO_blk[1] = 1'b0;
    assign proc_12_TLF_FIFO_blk[1] = 1'b0;
    assign proc_12_input_sync_blk[1] = 1'b0;
    assign proc_12_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_12[1] = dl_detect_out ? proc_dep_vld_vec_12_reg[1] : (proc_12_data_FIFO_blk[1] | proc_12_data_PIPO_blk[1] | proc_12_start_FIFO_blk[1] | proc_12_TLF_FIFO_blk[1] | proc_12_input_sync_blk[1] | proc_12_output_sync_blk[1]);
    assign proc_12_data_FIFO_blk[2] = 1'b0 | (~tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.numDataB_c_blk_n);
    assign proc_12_data_PIPO_blk[2] = 1'b0;
    assign proc_12_start_FIFO_blk[2] = 1'b0;
    assign proc_12_TLF_FIFO_blk[2] = 1'b0;
    assign proc_12_input_sync_blk[2] = 1'b0;
    assign proc_12_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_12[2] = dl_detect_out ? proc_dep_vld_vec_12_reg[2] : (proc_12_data_FIFO_blk[2] | proc_12_data_PIPO_blk[2] | proc_12_start_FIFO_blk[2] | proc_12_TLF_FIFO_blk[2] | proc_12_input_sync_blk[2] | proc_12_output_sync_blk[2]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_12_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_12_reg <= proc_dep_vld_vec_12;
        end
    end
    assign in_chan_dep_vld_vec_12[0] = dep_chan_vld_4_12;
    assign in_chan_dep_data_vec_12[16 : 0] = dep_chan_data_4_12;
    assign token_in_vec_12[0] = token_4_12;
    assign in_chan_dep_vld_vec_12[1] = dep_chan_vld_13_12;
    assign in_chan_dep_data_vec_12[33 : 17] = dep_chan_data_13_12;
    assign token_in_vec_12[1] = token_13_12;
    assign dep_chan_vld_12_7 = out_chan_dep_vld_vec_12[0];
    assign dep_chan_data_12_7 = out_chan_dep_data_12;
    assign token_12_7 = token_out_vec_12[0];
    assign dep_chan_vld_12_4 = out_chan_dep_vld_vec_12[1];
    assign dep_chan_data_12_4 = out_chan_dep_data_12;
    assign token_12_4 = token_out_vec_12[1];
    assign dep_chan_vld_12_13 = out_chan_dep_vld_vec_12[2];
    assign dep_chan_data_12_13 = out_chan_dep_data_12;
    assign token_12_13 = token_out_vec_12[2];

    // Process: tCalc1_U0.tCalc1_Block_entry57_proc_U0
    tTest_hls_deadlock_detect_unit #(17, 13, 3, 3) tTest_hls_deadlock_detect_unit_13 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_13),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_13),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_13),
        .token_in_vec(token_in_vec_13),
        .dl_detect_in(dl_detect_out),
        .origin(origin[13]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_13),
        .out_chan_dep_data(out_chan_dep_data_13),
        .token_out_vec(token_out_vec_13),
        .dl_detect_out(dl_in_vec[13]));

    assign proc_13_data_FIFO_blk[0] = 1'b0 | (~tCalc1_U0.tCalc1_Block_entry57_proc_U0.numDataB_blk_n);
    assign proc_13_data_PIPO_blk[0] = 1'b0;
    assign proc_13_start_FIFO_blk[0] = 1'b0;
    assign proc_13_TLF_FIFO_blk[0] = 1'b0 | (~tCalc1_U0.var_r_s_U.if_empty_n & tCalc1_U0.tCalc1_Block_entry57_proc_U0.ap_idle & ~tCalc1_U0.var_r_s_U.if_write);
    assign proc_13_input_sync_blk[0] = 1'b0;
    assign proc_13_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_13[0] = dl_detect_out ? proc_dep_vld_vec_13_reg[0] : (proc_13_data_FIFO_blk[0] | proc_13_data_PIPO_blk[0] | proc_13_start_FIFO_blk[0] | proc_13_TLF_FIFO_blk[0] | proc_13_input_sync_blk[0] | proc_13_output_sync_blk[0]);
    assign proc_13_data_FIFO_blk[1] = 1'b0;
    assign proc_13_data_PIPO_blk[1] = 1'b0;
    assign proc_13_start_FIFO_blk[1] = 1'b0;
    assign proc_13_TLF_FIFO_blk[1] = 1'b0 | (~tCalc1ResultB_U.if_full_n & tCalc1_U0.tCalc1_Block_entry57_proc_U0.ap_done & ap_done_reg_12 & ~tCalc1ResultB_U.if_read);
    assign proc_13_input_sync_blk[1] = 1'b0;
    assign proc_13_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_13[1] = dl_detect_out ? proc_dep_vld_vec_13_reg[1] : (proc_13_data_FIFO_blk[1] | proc_13_data_PIPO_blk[1] | proc_13_start_FIFO_blk[1] | proc_13_TLF_FIFO_blk[1] | proc_13_input_sync_blk[1] | proc_13_output_sync_blk[1]);
    assign proc_13_data_FIFO_blk[2] = 1'b0;
    assign proc_13_data_PIPO_blk[2] = 1'b0;
    assign proc_13_start_FIFO_blk[2] = 1'b0;
    assign proc_13_TLF_FIFO_blk[2] = 1'b0 | (~tCalc1ResultB_U.if_full_n & tCalc1_U0.tCalc1_Block_entry57_proc_U0.ap_done & ap_done_reg_12 & ~tCalc1ResultB_U.if_read);
    assign proc_13_input_sync_blk[2] = 1'b0;
    assign proc_13_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_13[2] = dl_detect_out ? proc_dep_vld_vec_13_reg[2] : (proc_13_data_FIFO_blk[2] | proc_13_data_PIPO_blk[2] | proc_13_start_FIFO_blk[2] | proc_13_TLF_FIFO_blk[2] | proc_13_input_sync_blk[2] | proc_13_output_sync_blk[2]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_13_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_13_reg <= proc_dep_vld_vec_13;
        end
    end
    assign in_chan_dep_vld_vec_13[0] = dep_chan_vld_12_13;
    assign in_chan_dep_data_vec_13[16 : 0] = dep_chan_data_12_13;
    assign token_in_vec_13[0] = token_12_13;
    assign in_chan_dep_vld_vec_13[1] = dep_chan_vld_14_13;
    assign in_chan_dep_data_vec_13[33 : 17] = dep_chan_data_14_13;
    assign token_in_vec_13[1] = token_14_13;
    assign in_chan_dep_vld_vec_13[2] = dep_chan_vld_15_13;
    assign in_chan_dep_data_vec_13[50 : 34] = dep_chan_data_15_13;
    assign token_in_vec_13[2] = token_15_13;
    assign dep_chan_vld_13_12 = out_chan_dep_vld_vec_13[0];
    assign dep_chan_data_13_12 = out_chan_dep_data_13;
    assign token_13_12 = token_out_vec_13[0];
    assign dep_chan_vld_13_14 = out_chan_dep_vld_vec_13[1];
    assign dep_chan_data_13_14 = out_chan_dep_data_13;
    assign token_13_14 = token_out_vec_13[1];
    assign dep_chan_vld_13_15 = out_chan_dep_vld_vec_13[2];
    assign dep_chan_data_13_15 = out_chan_dep_data_13;
    assign token_13_15 = token_out_vec_13[2];

    // Process: tCalc2_U0
    tTest_hls_deadlock_detect_unit #(17, 14, 5, 6) tTest_hls_deadlock_detect_unit_14 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_14),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_14),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_14),
        .token_in_vec(token_in_vec_14),
        .dl_detect_in(dl_detect_out),
        .origin(origin[14]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_14),
        .out_chan_dep_data(out_chan_dep_data_14),
        .token_out_vec(token_out_vec_14),
        .dl_detect_out(dl_in_vec[14]));

    assign proc_14_data_FIFO_blk[0] = 1'b0;
    assign proc_14_data_PIPO_blk[0] = 1'b0;
    assign proc_14_start_FIFO_blk[0] = 1'b0;
    assign proc_14_TLF_FIFO_blk[0] = 1'b0 | (~tCalc1ResultA_U.if_empty_n & tCalc2_U0.ap_idle & ~tCalc1ResultA_U.if_write);
    assign proc_14_input_sync_blk[0] = 1'b0;
    assign proc_14_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_14[0] = dl_detect_out ? proc_dep_vld_vec_14_reg[0] : (proc_14_data_FIFO_blk[0] | proc_14_data_PIPO_blk[0] | proc_14_start_FIFO_blk[0] | proc_14_TLF_FIFO_blk[0] | proc_14_input_sync_blk[0] | proc_14_output_sync_blk[0]);
    assign proc_14_data_FIFO_blk[1] = 1'b0;
    assign proc_14_data_PIPO_blk[1] = 1'b0;
    assign proc_14_start_FIFO_blk[1] = 1'b0;
    assign proc_14_TLF_FIFO_blk[1] = 1'b0 | (~tCalc1ResultA_U.if_empty_n & tCalc2_U0.ap_idle & ~tCalc1ResultA_U.if_write);
    assign proc_14_input_sync_blk[1] = 1'b0;
    assign proc_14_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_14[1] = dl_detect_out ? proc_dep_vld_vec_14_reg[1] : (proc_14_data_FIFO_blk[1] | proc_14_data_PIPO_blk[1] | proc_14_start_FIFO_blk[1] | proc_14_TLF_FIFO_blk[1] | proc_14_input_sync_blk[1] | proc_14_output_sync_blk[1]);
    assign proc_14_data_FIFO_blk[2] = 1'b0;
    assign proc_14_data_PIPO_blk[2] = 1'b0;
    assign proc_14_start_FIFO_blk[2] = 1'b0;
    assign proc_14_TLF_FIFO_blk[2] = 1'b0 | (~tCalc1ResultB_U.if_empty_n & tCalc2_U0.ap_idle & ~tCalc1ResultB_U.if_write);
    assign proc_14_input_sync_blk[2] = 1'b0;
    assign proc_14_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_14[2] = dl_detect_out ? proc_dep_vld_vec_14_reg[2] : (proc_14_data_FIFO_blk[2] | proc_14_data_PIPO_blk[2] | proc_14_start_FIFO_blk[2] | proc_14_TLF_FIFO_blk[2] | proc_14_input_sync_blk[2] | proc_14_output_sync_blk[2]);
    assign proc_14_data_FIFO_blk[3] = 1'b0;
    assign proc_14_data_PIPO_blk[3] = 1'b0;
    assign proc_14_start_FIFO_blk[3] = 1'b0;
    assign proc_14_TLF_FIFO_blk[3] = 1'b0 | (~tCalc1ResultB_U.if_empty_n & tCalc2_U0.ap_idle & ~tCalc1ResultB_U.if_write);
    assign proc_14_input_sync_blk[3] = 1'b0;
    assign proc_14_output_sync_blk[3] = 1'b0;
    assign proc_dep_vld_vec_14[3] = dl_detect_out ? proc_dep_vld_vec_14_reg[3] : (proc_14_data_FIFO_blk[3] | proc_14_data_PIPO_blk[3] | proc_14_start_FIFO_blk[3] | proc_14_TLF_FIFO_blk[3] | proc_14_input_sync_blk[3] | proc_14_output_sync_blk[3]);
    assign proc_14_data_FIFO_blk[4] = 1'b0;
    assign proc_14_data_PIPO_blk[4] = 1'b0;
    assign proc_14_start_FIFO_blk[4] = 1'b0;
    assign proc_14_TLF_FIFO_blk[4] = 1'b0 | (~meanDiff_U.if_empty_n & tCalc2_U0.ap_idle & ~meanDiff_U.if_write);
    assign proc_14_input_sync_blk[4] = 1'b0;
    assign proc_14_output_sync_blk[4] = 1'b0;
    assign proc_dep_vld_vec_14[4] = dl_detect_out ? proc_dep_vld_vec_14_reg[4] : (proc_14_data_FIFO_blk[4] | proc_14_data_PIPO_blk[4] | proc_14_start_FIFO_blk[4] | proc_14_TLF_FIFO_blk[4] | proc_14_input_sync_blk[4] | proc_14_output_sync_blk[4]);
    assign proc_14_data_FIFO_blk[5] = 1'b0;
    assign proc_14_data_PIPO_blk[5] = 1'b0;
    assign proc_14_start_FIFO_blk[5] = 1'b0;
    assign proc_14_TLF_FIFO_blk[5] = 1'b0 | (~t_U.if_full_n & tCalc2_U0.ap_done & ap_done_reg_13 & ~t_U.if_read);
    assign proc_14_input_sync_blk[5] = 1'b0;
    assign proc_14_output_sync_blk[5] = 1'b0;
    assign proc_dep_vld_vec_14[5] = dl_detect_out ? proc_dep_vld_vec_14_reg[5] : (proc_14_data_FIFO_blk[5] | proc_14_data_PIPO_blk[5] | proc_14_start_FIFO_blk[5] | proc_14_TLF_FIFO_blk[5] | proc_14_input_sync_blk[5] | proc_14_output_sync_blk[5]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_14_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_14_reg <= proc_dep_vld_vec_14;
        end
    end
    assign in_chan_dep_vld_vec_14[0] = dep_chan_vld_8_14;
    assign in_chan_dep_data_vec_14[16 : 0] = dep_chan_data_8_14;
    assign token_in_vec_14[0] = token_8_14;
    assign in_chan_dep_vld_vec_14[1] = dep_chan_vld_10_14;
    assign in_chan_dep_data_vec_14[33 : 17] = dep_chan_data_10_14;
    assign token_in_vec_14[1] = token_10_14;
    assign in_chan_dep_vld_vec_14[2] = dep_chan_vld_11_14;
    assign in_chan_dep_data_vec_14[50 : 34] = dep_chan_data_11_14;
    assign token_in_vec_14[2] = token_11_14;
    assign in_chan_dep_vld_vec_14[3] = dep_chan_vld_13_14;
    assign in_chan_dep_data_vec_14[67 : 51] = dep_chan_data_13_14;
    assign token_in_vec_14[3] = token_13_14;
    assign in_chan_dep_vld_vec_14[4] = dep_chan_vld_16_14;
    assign in_chan_dep_data_vec_14[84 : 68] = dep_chan_data_16_14;
    assign token_in_vec_14[4] = token_16_14;
    assign dep_chan_vld_14_8 = out_chan_dep_vld_vec_14[0];
    assign dep_chan_data_14_8 = out_chan_dep_data_14;
    assign token_14_8 = token_out_vec_14[0];
    assign dep_chan_vld_14_10 = out_chan_dep_vld_vec_14[1];
    assign dep_chan_data_14_10 = out_chan_dep_data_14;
    assign token_14_10 = token_out_vec_14[1];
    assign dep_chan_vld_14_11 = out_chan_dep_vld_vec_14[2];
    assign dep_chan_data_14_11 = out_chan_dep_data_14;
    assign token_14_11 = token_out_vec_14[2];
    assign dep_chan_vld_14_13 = out_chan_dep_vld_vec_14[3];
    assign dep_chan_data_14_13 = out_chan_dep_data_14;
    assign token_14_13 = token_out_vec_14[3];
    assign dep_chan_vld_14_5 = out_chan_dep_vld_vec_14[4];
    assign dep_chan_data_14_5 = out_chan_dep_data_14;
    assign token_14_5 = token_out_vec_14[4];
    assign dep_chan_vld_14_16 = out_chan_dep_vld_vec_14[5];
    assign dep_chan_data_14_16 = out_chan_dep_data_14;
    assign token_14_16 = token_out_vec_14[5];

    // Process: tCalc2_U0.tCalc2_Block_entry12_proc_U0
    tTest_hls_deadlock_detect_unit #(17, 15, 5, 6) tTest_hls_deadlock_detect_unit_15 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_15),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_15),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_15),
        .token_in_vec(token_in_vec_15),
        .dl_detect_in(dl_detect_out),
        .origin(origin[15]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_15),
        .out_chan_dep_data(out_chan_dep_data_15),
        .token_out_vec(token_out_vec_15),
        .dl_detect_out(dl_in_vec[15]));

    assign proc_15_data_FIFO_blk[0] = 1'b0;
    assign proc_15_data_PIPO_blk[0] = 1'b0;
    assign proc_15_start_FIFO_blk[0] = 1'b0;
    assign proc_15_TLF_FIFO_blk[0] = 1'b0 | (~tCalc1ResultB_U.if_empty_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle & ~tCalc1ResultB_U.if_write);
    assign proc_15_input_sync_blk[0] = 1'b0;
    assign proc_15_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_15[0] = dl_detect_out ? proc_dep_vld_vec_15_reg[0] : (proc_15_data_FIFO_blk[0] | proc_15_data_PIPO_blk[0] | proc_15_start_FIFO_blk[0] | proc_15_TLF_FIFO_blk[0] | proc_15_input_sync_blk[0] | proc_15_output_sync_blk[0]);
    assign proc_15_data_FIFO_blk[1] = 1'b0;
    assign proc_15_data_PIPO_blk[1] = 1'b0;
    assign proc_15_start_FIFO_blk[1] = 1'b0;
    assign proc_15_TLF_FIFO_blk[1] = 1'b0 | (~tCalc1ResultB_U.if_empty_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle & ~tCalc1ResultB_U.if_write);
    assign proc_15_input_sync_blk[1] = 1'b0;
    assign proc_15_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_15[1] = dl_detect_out ? proc_dep_vld_vec_15_reg[1] : (proc_15_data_FIFO_blk[1] | proc_15_data_PIPO_blk[1] | proc_15_start_FIFO_blk[1] | proc_15_TLF_FIFO_blk[1] | proc_15_input_sync_blk[1] | proc_15_output_sync_blk[1]);
    assign proc_15_data_FIFO_blk[2] = 1'b0;
    assign proc_15_data_PIPO_blk[2] = 1'b0;
    assign proc_15_start_FIFO_blk[2] = 1'b0;
    assign proc_15_TLF_FIFO_blk[2] = 1'b0 | (~tCalc1ResultA_U.if_empty_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle & ~tCalc1ResultA_U.if_write);
    assign proc_15_input_sync_blk[2] = 1'b0;
    assign proc_15_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_15[2] = dl_detect_out ? proc_dep_vld_vec_15_reg[2] : (proc_15_data_FIFO_blk[2] | proc_15_data_PIPO_blk[2] | proc_15_start_FIFO_blk[2] | proc_15_TLF_FIFO_blk[2] | proc_15_input_sync_blk[2] | proc_15_output_sync_blk[2]);
    assign proc_15_data_FIFO_blk[3] = 1'b0;
    assign proc_15_data_PIPO_blk[3] = 1'b0;
    assign proc_15_start_FIFO_blk[3] = 1'b0;
    assign proc_15_TLF_FIFO_blk[3] = 1'b0 | (~tCalc1ResultA_U.if_empty_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle & ~tCalc1ResultA_U.if_write);
    assign proc_15_input_sync_blk[3] = 1'b0;
    assign proc_15_output_sync_blk[3] = 1'b0;
    assign proc_dep_vld_vec_15[3] = dl_detect_out ? proc_dep_vld_vec_15_reg[3] : (proc_15_data_FIFO_blk[3] | proc_15_data_PIPO_blk[3] | proc_15_start_FIFO_blk[3] | proc_15_TLF_FIFO_blk[3] | proc_15_input_sync_blk[3] | proc_15_output_sync_blk[3]);
    assign proc_15_data_FIFO_blk[4] = 1'b0;
    assign proc_15_data_PIPO_blk[4] = 1'b0;
    assign proc_15_start_FIFO_blk[4] = 1'b0;
    assign proc_15_TLF_FIFO_blk[4] = 1'b0 | (~meanDiff_U.if_empty_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle & ~meanDiff_U.if_write);
    assign proc_15_input_sync_blk[4] = 1'b0;
    assign proc_15_output_sync_blk[4] = 1'b0;
    assign proc_dep_vld_vec_15[4] = dl_detect_out ? proc_dep_vld_vec_15_reg[4] : (proc_15_data_FIFO_blk[4] | proc_15_data_PIPO_blk[4] | proc_15_start_FIFO_blk[4] | proc_15_TLF_FIFO_blk[4] | proc_15_input_sync_blk[4] | proc_15_output_sync_blk[4]);
    assign proc_15_data_FIFO_blk[5] = 1'b0;
    assign proc_15_data_PIPO_blk[5] = 1'b0;
    assign proc_15_start_FIFO_blk[5] = 1'b0;
    assign proc_15_TLF_FIFO_blk[5] = 1'b0 | (~t_U.if_full_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_done & ap_done_reg_14 & ~t_U.if_read);
    assign proc_15_input_sync_blk[5] = 1'b0;
    assign proc_15_output_sync_blk[5] = 1'b0;
    assign proc_dep_vld_vec_15[5] = dl_detect_out ? proc_dep_vld_vec_15_reg[5] : (proc_15_data_FIFO_blk[5] | proc_15_data_PIPO_blk[5] | proc_15_start_FIFO_blk[5] | proc_15_TLF_FIFO_blk[5] | proc_15_input_sync_blk[5] | proc_15_output_sync_blk[5]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_15_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_15_reg <= proc_dep_vld_vec_15;
        end
    end
    assign in_chan_dep_vld_vec_15[0] = dep_chan_vld_8_15;
    assign in_chan_dep_data_vec_15[16 : 0] = dep_chan_data_8_15;
    assign token_in_vec_15[0] = token_8_15;
    assign in_chan_dep_vld_vec_15[1] = dep_chan_vld_10_15;
    assign in_chan_dep_data_vec_15[33 : 17] = dep_chan_data_10_15;
    assign token_in_vec_15[1] = token_10_15;
    assign in_chan_dep_vld_vec_15[2] = dep_chan_vld_11_15;
    assign in_chan_dep_data_vec_15[50 : 34] = dep_chan_data_11_15;
    assign token_in_vec_15[2] = token_11_15;
    assign in_chan_dep_vld_vec_15[3] = dep_chan_vld_13_15;
    assign in_chan_dep_data_vec_15[67 : 51] = dep_chan_data_13_15;
    assign token_in_vec_15[3] = token_13_15;
    assign in_chan_dep_vld_vec_15[4] = dep_chan_vld_16_15;
    assign in_chan_dep_data_vec_15[84 : 68] = dep_chan_data_16_15;
    assign token_in_vec_15[4] = token_16_15;
    assign dep_chan_vld_15_11 = out_chan_dep_vld_vec_15[0];
    assign dep_chan_data_15_11 = out_chan_dep_data_15;
    assign token_15_11 = token_out_vec_15[0];
    assign dep_chan_vld_15_13 = out_chan_dep_vld_vec_15[1];
    assign dep_chan_data_15_13 = out_chan_dep_data_15;
    assign token_15_13 = token_out_vec_15[1];
    assign dep_chan_vld_15_8 = out_chan_dep_vld_vec_15[2];
    assign dep_chan_data_15_8 = out_chan_dep_data_15;
    assign token_15_8 = token_out_vec_15[2];
    assign dep_chan_vld_15_10 = out_chan_dep_vld_vec_15[3];
    assign dep_chan_data_15_10 = out_chan_dep_data_15;
    assign token_15_10 = token_out_vec_15[3];
    assign dep_chan_vld_15_5 = out_chan_dep_vld_vec_15[4];
    assign dep_chan_data_15_5 = out_chan_dep_data_15;
    assign token_15_5 = token_out_vec_15[4];
    assign dep_chan_vld_15_16 = out_chan_dep_vld_vec_15[5];
    assign dep_chan_data_15_16 = out_chan_dep_data_15;
    assign token_15_16 = token_out_vec_15[5];

    // Process: Block_entry2458_proc_U0
    tTest_hls_deadlock_detect_unit #(17, 16, 3, 3) tTest_hls_deadlock_detect_unit_16 (
        .reset(dl_reset),
        .clock(dl_clock),
        .proc_dep_vld_vec(proc_dep_vld_vec_16),
        .in_chan_dep_vld_vec(in_chan_dep_vld_vec_16),
        .in_chan_dep_data_vec(in_chan_dep_data_vec_16),
        .token_in_vec(token_in_vec_16),
        .dl_detect_in(dl_detect_out),
        .origin(origin[16]),
        .token_clear(token_clear),
        .out_chan_dep_vld_vec(out_chan_dep_vld_vec_16),
        .out_chan_dep_data(out_chan_dep_data_16),
        .token_out_vec(token_out_vec_16),
        .dl_detect_out(dl_in_vec[16]));

    assign proc_16_data_FIFO_blk[0] = 1'b0;
    assign proc_16_data_PIPO_blk[0] = 1'b0;
    assign proc_16_start_FIFO_blk[0] = 1'b0;
    assign proc_16_TLF_FIFO_blk[0] = 1'b0 | (~t_U.if_empty_n & Block_entry2458_proc_U0.ap_idle & ~t_U.if_write);
    assign proc_16_input_sync_blk[0] = 1'b0;
    assign proc_16_output_sync_blk[0] = 1'b0;
    assign proc_dep_vld_vec_16[0] = dl_detect_out ? proc_dep_vld_vec_16_reg[0] : (proc_16_data_FIFO_blk[0] | proc_16_data_PIPO_blk[0] | proc_16_start_FIFO_blk[0] | proc_16_TLF_FIFO_blk[0] | proc_16_input_sync_blk[0] | proc_16_output_sync_blk[0]);
    assign proc_16_data_FIFO_blk[1] = 1'b0;
    assign proc_16_data_PIPO_blk[1] = 1'b0;
    assign proc_16_start_FIFO_blk[1] = 1'b0;
    assign proc_16_TLF_FIFO_blk[1] = 1'b0 | (~t_U.if_empty_n & Block_entry2458_proc_U0.ap_idle & ~t_U.if_write);
    assign proc_16_input_sync_blk[1] = 1'b0;
    assign proc_16_output_sync_blk[1] = 1'b0;
    assign proc_dep_vld_vec_16[1] = dl_detect_out ? proc_dep_vld_vec_16_reg[1] : (proc_16_data_FIFO_blk[1] | proc_16_data_PIPO_blk[1] | proc_16_start_FIFO_blk[1] | proc_16_TLF_FIFO_blk[1] | proc_16_input_sync_blk[1] | proc_16_output_sync_blk[1]);
    assign proc_16_data_FIFO_blk[2] = 1'b0 | (~Block_entry2458_proc_U0.C_blk_n);
    assign proc_16_data_PIPO_blk[2] = 1'b0;
    assign proc_16_start_FIFO_blk[2] = 1'b0;
    assign proc_16_TLF_FIFO_blk[2] = 1'b0;
    assign proc_16_input_sync_blk[2] = 1'b0;
    assign proc_16_output_sync_blk[2] = 1'b0;
    assign proc_dep_vld_vec_16[2] = dl_detect_out ? proc_dep_vld_vec_16_reg[2] : (proc_16_data_FIFO_blk[2] | proc_16_data_PIPO_blk[2] | proc_16_start_FIFO_blk[2] | proc_16_TLF_FIFO_blk[2] | proc_16_input_sync_blk[2] | proc_16_output_sync_blk[2]);
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            proc_dep_vld_vec_16_reg <= 'b0;
        end
        else begin
            proc_dep_vld_vec_16_reg <= proc_dep_vld_vec_16;
        end
    end
    assign in_chan_dep_vld_vec_16[0] = dep_chan_vld_0_16;
    assign in_chan_dep_data_vec_16[16 : 0] = dep_chan_data_0_16;
    assign token_in_vec_16[0] = token_0_16;
    assign in_chan_dep_vld_vec_16[1] = dep_chan_vld_14_16;
    assign in_chan_dep_data_vec_16[33 : 17] = dep_chan_data_14_16;
    assign token_in_vec_16[1] = token_14_16;
    assign in_chan_dep_vld_vec_16[2] = dep_chan_vld_15_16;
    assign in_chan_dep_data_vec_16[50 : 34] = dep_chan_data_15_16;
    assign token_in_vec_16[2] = token_15_16;
    assign dep_chan_vld_16_14 = out_chan_dep_vld_vec_16[0];
    assign dep_chan_data_16_14 = out_chan_dep_data_16;
    assign token_16_14 = token_out_vec_16[0];
    assign dep_chan_vld_16_15 = out_chan_dep_vld_vec_16[1];
    assign dep_chan_data_16_15 = out_chan_dep_data_16;
    assign token_16_15 = token_out_vec_16[1];
    assign dep_chan_vld_16_0 = out_chan_dep_vld_vec_16[2];
    assign dep_chan_data_16_0 = out_chan_dep_data_16;
    assign token_16_0 = token_out_vec_16[2];


`include "tTest_hls_deadlock_report_unit.vh"