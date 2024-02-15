   
    parameter PROC_NUM = 21;
    parameter ST_IDLE = 3'b000;
    parameter ST_FILTER_FAKE = 3'b001;
    parameter ST_DL_DETECTED = 3'b010;
    parameter ST_DL_REPORT = 3'b100;
   

    reg [2:0] CS_fsm;
    reg [2:0] NS_fsm;
    reg [PROC_NUM - 1:0] dl_detect_reg;
    reg [PROC_NUM - 1:0] dl_done_reg;
    reg [PROC_NUM - 1:0] origin_reg;
    reg [PROC_NUM - 1:0] dl_in_vec_reg;
    reg [31:0] dl_keep_cnt;
    integer i;
    integer fp;

    // FSM State machine
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            CS_fsm <= ST_IDLE;
        end
        else begin
            CS_fsm <= NS_fsm;
        end
    end
    always @ (CS_fsm or dl_in_vec or dl_detect_reg or dl_done_reg or dl_in_vec or origin_reg or dl_keep_cnt) begin
        case (CS_fsm)
            ST_IDLE : begin
                if (|dl_in_vec) begin
                    NS_fsm = ST_FILTER_FAKE;
                end
                else begin
                    NS_fsm = ST_IDLE;
                end
            end
            ST_FILTER_FAKE: begin
                if (dl_keep_cnt >= 32'd1000) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else if (dl_detect_reg != (dl_detect_reg & dl_in_vec)) begin
                    NS_fsm = ST_IDLE;
                end
                else begin
                    NS_fsm = ST_FILTER_FAKE;
                end
            end
            ST_DL_DETECTED: begin
                // has unreported deadlock cycle
                if (dl_detect_reg != dl_done_reg) begin
                    NS_fsm = ST_DL_REPORT;
                end
                else begin
                    NS_fsm = ST_DL_DETECTED;
                end
            end
            ST_DL_REPORT: begin
                if (|(dl_in_vec & origin_reg)) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else begin
                    NS_fsm = ST_DL_REPORT;
                end
            end
            default: NS_fsm = ST_IDLE;
        endcase
    end

    // dl_detect_reg record the procs that first detect deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_detect_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_IDLE) begin
                dl_detect_reg <= dl_in_vec;
            end
        end
    end

    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_keep_cnt <= 32'h0;
        end
        else begin
            if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg == (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= dl_keep_cnt + 32'h1;
            end
            else if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg != (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= 32'h0;
            end
        end
    end

    // dl_detect_out keeps in high after deadlock detected
    assign dl_detect_out = (|dl_detect_reg) && (CS_fsm == ST_DL_DETECTED || CS_fsm == ST_DL_REPORT);

    // dl_done_reg record the cycles has been reported
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_done_reg <= 'b0;
        end
        else begin
            if ((CS_fsm == ST_DL_REPORT) && (|(dl_in_vec & dl_detect_reg) == 'b1)) begin
                dl_done_reg <= dl_done_reg | dl_in_vec;
            end
        end
    end

    // clear token once a cycle is done
    assign token_clear = (CS_fsm == ST_DL_REPORT) ? ((|(dl_in_vec & origin_reg)) ? 'b1 : 'b0) : 'b0;

    // origin_reg record the current cycle start id
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            origin_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                origin_reg <= origin;
            end
        end
    end
   
    // origin will be valid for only one cycle
    wire [PROC_NUM*PROC_NUM - 1:0] origin_tmp;
    assign origin_tmp[PROC_NUM - 1:0] = (dl_detect_reg[0] & ~dl_done_reg[0]) ? 'b1 : 'b0;
    genvar j;
    generate
    for(j = 1;j < PROC_NUM;j = j + 1) begin: F1
        assign origin_tmp[j*PROC_NUM +: PROC_NUM] = (dl_detect_reg[j] & ~dl_done_reg[j]) ? ('b1 << j) : origin_tmp[(j - 1)*PROC_NUM +: PROC_NUM];
    end
    endgenerate
    always @ (CS_fsm or origin_tmp) begin
        if (CS_fsm == ST_DL_DETECTED) begin
            origin = origin_tmp[(PROC_NUM - 1)*PROC_NUM +: PROC_NUM];
        end
        else begin
            origin = 'b0;
        end
    end

    
    // dl_in_vec_reg record the current cycle dl_in_vec
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_in_vec_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                dl_in_vec_reg <= origin;
            end
            else if (CS_fsm == ST_DL_REPORT) begin
                dl_in_vec_reg <= dl_in_vec;
            end
        end
    end
    
    // find_df_deadlock to report the deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            find_df_deadlock <= 1'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED && dl_detect_reg == dl_done_reg) begin
                find_df_deadlock <= 1'b1;
            end
            else if (CS_fsm == ST_IDLE) begin
                find_df_deadlock <= 1'b0;
            end
        end
    end
    
    // get the first valid proc index in dl vector
    function integer proc_index(input [PROC_NUM - 1:0] dl_vec);
        begin
            proc_index = 0;
            for (i = 0; i < PROC_NUM; i = i + 1) begin
                if (dl_vec[i]) begin
                    proc_index = i;
                end
            end
        end
    endfunction

    // get the proc path based on dl vector
    function [672:0] proc_path(input [PROC_NUM - 1:0] dl_vec);
        integer index;
        begin
            index = proc_index(dl_vec);
            case (index)
                0 : begin
                    proc_path = "tTest_tTest.entry_proc38_U0";
                end
                1 : begin
                    proc_path = "tTest_tTest.sumStream_U0";
                end
                2 : begin
                    proc_path = "tTest_tTest.sumStream_4_U0";
                end
                3 : begin
                    proc_path = "tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0";
                end
                4 : begin
                    proc_path = "tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0";
                end
                5 : begin
                    proc_path = "tTest_tTest.diff_U0";
                end
                6 : begin
                    proc_path = "tTest_tTest.varSum_U0";
                end
                7 : begin
                    proc_path = "tTest_tTest.varSum_5_U0";
                end
                8 : begin
                    proc_path = "tTest_tTest.tCalc1_2_U0";
                end
                9 : begin
                    proc_path = "tTest_tTest.tCalc1_2_U0.entry_proc_U0";
                end
                10 : begin
                    proc_path = "tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0";
                end
                11 : begin
                    proc_path = "tTest_tTest.tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0";
                end
                12 : begin
                    proc_path = "tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0";
                end
                13 : begin
                    proc_path = "tTest_tTest.tCalc1_U0";
                end
                14 : begin
                    proc_path = "tTest_tTest.tCalc1_U0.entry_proc37_U0";
                end
                15 : begin
                    proc_path = "tTest_tTest.tCalc1_U0.tCalc1_Block_entry4_proc_U0";
                end
                16 : begin
                    proc_path = "tTest_tTest.tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0";
                end
                17 : begin
                    proc_path = "tTest_tTest.tCalc1_U0.tCalc1_Block_entry46_proc_U0";
                end
                18 : begin
                    proc_path = "tTest_tTest.tCalc2_U0";
                end
                19 : begin
                    proc_path = "tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0";
                end
                20 : begin
                    proc_path = "tTest_tTest.Block_entry2458_proc_U0";
                end
                default : begin
                    proc_path = "unknown";
                end
            endcase
        end
    endfunction

    // print the headlines of deadlock detection
    task print_dl_head;
        begin
            $display("\n//////////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", $time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            fp = $fopen("deadlock_db.dat", "w");
        end
    endtask

    // print the start of a cycle
    task print_cycle_start(input reg [672:0] proc_path, input integer cycle_id);
        begin
            $display("/////////////////////////");
            $display("// Dependence cycle %0d:", cycle_id);
            $display("// (1): Process: %0s", proc_path);
            $fdisplay(fp, "Dependence_Cycle_ID %0d", cycle_id);
            $fdisplay(fp, "Dependence_Process_ID 1");
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print the end of deadlock detection
    task print_dl_end(input integer num, input integer record_time);
        begin
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// Totally %0d cycles detected!", num);
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", record_time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            $fdisplay(fp, "Dependence_Cycle_Number %0d", num);
            $fclose(fp);
        end
    endtask

    // print one proc component in the cycle
    task print_cycle_proc_comp(input reg [672:0] proc_path, input integer cycle_comp_id);
        begin
            $display("// (%0d): Process: %0s", cycle_comp_id, proc_path);
            $fdisplay(fp, "Dependence_Process_ID %0d", cycle_comp_id);
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print one channel component in the cycle
    task print_cycle_chan_comp(input [PROC_NUM - 1:0] dl_vec1, input [PROC_NUM - 1:0] dl_vec2);
        reg [424:0] chan_path;
        integer index1;
        integer index2;
        begin
            index1 = proc_index(dl_vec1);
            index2 = proc_index(dl_vec2);
            case (index1)
                0 : begin
                    case(index2)
                    20: begin
                        if (~entry_proc38_U0.C_c_blk_n) begin
                            if (~C_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.C_c_U' written by process 'tTest_tTest.Block_entry2458_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.C_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~C_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.C_c_U' read by process 'tTest_tTest.Block_entry2458_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.C_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin
                        if (ap_sync_entry_proc38_U0_ap_ready & entry_proc38_U0.ap_idle & ~ap_sync_sumStream_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'tTest_tTest.sumStream_U0'");
                        end
                    end
                    2: begin
                        if (ap_sync_entry_proc38_U0_ap_ready & entry_proc38_U0.ap_idle & ~ap_sync_sumStream_4_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'tTest_tTest.sumStream_4_U0'");
                        end
                    end
                    endcase
                end
                1 : begin
                    case(index2)
                    6: begin
                        if (~famA_U.i_full_n & sumStream_U0.ap_done & ap_done_reg_0 & ~famA_U.t_read) begin
                            if (~famA_U.t_empty_n) begin
                                $display("//      Blocked by empty input PIPO 'tTest_tTest.famA_U' written by process 'tTest_tTest.varSum_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.famA_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~famA_U.i_full_n) begin
                                $display("//      Blocked by full output PIPO 'tTest_tTest.famA_U' read by process 'tTest_tTest.varSum_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.famA_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    0: begin
                        if (ap_sync_sumStream_U0_ap_ready & sumStream_U0.ap_idle & ~ap_sync_entry_proc38_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'tTest_tTest.entry_proc38_U0'");
                        end
                    end
                    2: begin
                        if (ap_sync_sumStream_U0_ap_ready & sumStream_U0.ap_idle & ~ap_sync_sumStream_4_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'tTest_tTest.sumStream_4_U0'");
                        end
                    end
                    endcase
                end
                2 : begin
                    case(index2)
                    7: begin
                        if (~famB_U.i_full_n & sumStream_4_U0.ap_done & ap_done_reg_1 & ~famB_U.t_read) begin
                            if (~famB_U.t_empty_n) begin
                                $display("//      Blocked by empty input PIPO 'tTest_tTest.famB_U' written by process 'tTest_tTest.varSum_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.famB_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~famB_U.i_full_n) begin
                                $display("//      Blocked by full output PIPO 'tTest_tTest.famB_U' read by process 'tTest_tTest.varSum_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.famB_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    0: begin
                        if (ap_sync_sumStream_4_U0_ap_ready & sumStream_4_U0.ap_idle & ~ap_sync_entry_proc38_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'tTest_tTest.entry_proc38_U0'");
                        end
                    end
                    1: begin
                        if (ap_sync_sumStream_4_U0_ap_ready & sumStream_4_U0.ap_idle & ~ap_sync_sumStream_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'tTest_tTest.sumStream_U0'");
                        end
                    end
                    endcase
                end
                3 : begin
                    case(index2)
                    1: begin
                        if (~sumA_channel_U.if_empty_n & divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.ap_idle & ~sumA_channel_U.if_write) begin
                            if (~sumA_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.sumA_channel_U' written by process 'tTest_tTest.sumStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.sumA_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~sumA_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.sumA_channel_U' read by process 'tTest_tTest.sumStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.sumA_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~numDataA_c70_channel_U.if_empty_n & divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.ap_idle & ~numDataA_c70_channel_U.if_write) begin
                            if (~numDataA_c70_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.numDataA_c70_channel_U' written by process 'tTest_tTest.sumStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataA_c70_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~numDataA_c70_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.numDataA_c70_channel_U' read by process 'tTest_tTest.sumStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataA_c70_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    8: begin
                        if (~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.numDataA_c_blk_n) begin
                            if (~numDataA_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.numDataA_c_U' written by process 'tTest_tTest.tCalc1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~numDataA_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.numDataA_c_U' read by process 'tTest_tTest.tCalc1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin
                        if (~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0.numDataA_c_blk_n) begin
                            if (~numDataA_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.numDataA_c_U' written by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~numDataA_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.numDataA_c_U' read by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                4 : begin
                    case(index2)
                    2: begin
                        if (~sumB_channel_U.if_empty_n & divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.ap_idle & ~sumB_channel_U.if_write) begin
                            if (~sumB_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.sumB_channel_U' written by process 'tTest_tTest.sumStream_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.sumB_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~sumB_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.sumB_channel_U' read by process 'tTest_tTest.sumStream_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.sumB_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~numDataB_c71_channel_U.if_empty_n & divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.ap_idle & ~numDataB_c71_channel_U.if_write) begin
                            if (~numDataB_c71_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.numDataB_c71_channel_U' written by process 'tTest_tTest.sumStream_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataB_c71_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~numDataB_c71_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.numDataB_c71_channel_U' read by process 'tTest_tTest.sumStream_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataB_c71_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin
                        if (~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.numDataB_c_blk_n) begin
                            if (~numDataB_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.numDataB_c_U' written by process 'tTest_tTest.tCalc1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~numDataB_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.numDataB_c_U' read by process 'tTest_tTest.tCalc1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    15: begin
                        if (~divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0.numDataB_c_blk_n) begin
                            if (~numDataB_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.numDataB_c_U' written by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~numDataB_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.numDataB_c_U' read by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                5 : begin
                    case(index2)
                    3: begin
                        if (~meanA_c72_channel_U.if_empty_n & diff_U0.ap_idle & ~meanA_c72_channel_U.if_write) begin
                            if (~meanA_c72_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.meanA_c72_channel_U' written by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanA_c72_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~meanA_c72_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.meanA_c72_channel_U' read by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanA_c72_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (~meanB_c73_channel_U.if_empty_n & diff_U0.ap_idle & ~meanB_c73_channel_U.if_write) begin
                            if (~meanB_c73_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.meanB_c73_channel_U' written by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanB_c73_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~meanB_c73_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.meanB_c73_channel_U' read by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanB_c73_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                6 : begin
                    case(index2)
                    1: begin
                        if (~famA_U.t_empty_n & varSum_U0.ap_idle & ~famA_U.i_write) begin
                            if (~famA_U.t_empty_n) begin
                                $display("//      Blocked by empty input PIPO 'tTest_tTest.famA_U' written by process 'tTest_tTest.sumStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.famA_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~famA_U.i_full_n) begin
                                $display("//      Blocked by full output PIPO 'tTest_tTest.famA_U' read by process 'tTest_tTest.sumStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.famA_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    3: begin
                        if (~meanA_c_channel_U.if_empty_n & varSum_U0.ap_idle & ~meanA_c_channel_U.if_write) begin
                            if (~meanA_c_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.meanA_c_channel_U' written by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanA_c_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~meanA_c_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.meanA_c_channel_U' read by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanA_c_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                7 : begin
                    case(index2)
                    2: begin
                        if (~famB_U.t_empty_n & varSum_5_U0.ap_idle & ~famB_U.i_write) begin
                            if (~famB_U.t_empty_n) begin
                                $display("//      Blocked by empty input PIPO 'tTest_tTest.famB_U' written by process 'tTest_tTest.sumStream_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.famB_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~famB_U.i_full_n) begin
                                $display("//      Blocked by full output PIPO 'tTest_tTest.famB_U' read by process 'tTest_tTest.sumStream_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.famB_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (~meanB_c_channel_U.if_empty_n & varSum_5_U0.ap_idle & ~meanB_c_channel_U.if_write) begin
                            if (~meanB_c_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.meanB_c_channel_U' written by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanB_c_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~meanB_c_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.meanB_c_channel_U' read by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanB_c_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                8 : begin
                    case(index2)
                    6: begin
                        if (~varSumA_channel_U.if_empty_n & tCalc1_2_U0.ap_idle & ~varSumA_channel_U.if_write) begin
                            if (~varSumA_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.varSumA_channel_U' written by process 'tTest_tTest.varSum_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.varSumA_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~varSumA_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.varSumA_channel_U' read by process 'tTest_tTest.varSum_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.varSumA_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    3: begin
                        if (~tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0.numDataA_blk_n) begin
                            if (~numDataA_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.numDataA_c_U' written by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~numDataA_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.numDataA_c_U' read by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    18: begin
                        if (~tCalc1ResultA_U.if_full_n & tCalc1_2_U0.ap_done & ap_done_reg_7 & ~tCalc1ResultA_U.if_read) begin
                            if (~tCalc1ResultA_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultA_U' written by process 'tTest_tTest.tCalc2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultA_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultA_U' read by process 'tTest_tTest.tCalc2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    19: begin
                        if (~tCalc1ResultA_U.if_full_n & tCalc1_2_U0.ap_done & ap_done_reg_7 & ~tCalc1ResultA_U.if_read) begin
                            if (~tCalc1ResultA_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultA_U' written by process 'tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultA_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultA_U' read by process 'tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                9 : begin
                    case(index2)
                    6: begin
                        if (~varSumA_channel_U.if_empty_n & tCalc1_2_U0.entry_proc_U0.ap_idle & ~varSumA_channel_U.if_write) begin
                            if (~varSumA_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.varSumA_channel_U' written by process 'tTest_tTest.varSum_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.varSumA_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~varSumA_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.varSumA_channel_U' read by process 'tTest_tTest.varSum_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.varSumA_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    11: begin
                        if (~tCalc1_2_U0.entry_proc_U0.varSumA_c_blk_n) begin
                            if (~tCalc1_2_U0.varSumA_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_2_U0.varSumA_c_U' written by process 'tTest_tTest.tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.varSumA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_2_U0.varSumA_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_2_U0.varSumA_c_U' read by process 'tTest_tTest.tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.varSumA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin
                        if (tCalc1_2_U0.ap_sync_entry_proc_U0_ap_ready & tCalc1_2_U0.entry_proc_U0.ap_idle & ~tCalc1_2_U0.ap_sync_tCalc1_2_Block_entry4_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0'");
                        end
                    end
                    endcase
                end
                10 : begin
                    case(index2)
                    3: begin
                        if (~tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0.numDataA_blk_n) begin
                            if (~numDataA_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.numDataA_c_U' written by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~numDataA_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.numDataA_c_U' read by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin
                        if (~tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0.numDataA_c_blk_n) begin
                            if (~tCalc1_2_U0.numDataA_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_2_U0.numDataA_c_U' written by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_2_U0.numDataA_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_2_U0.numDataA_c_U' read by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    9: begin
                        if (tCalc1_2_U0.ap_sync_tCalc1_2_Block_entry4_proc_U0_ap_ready & tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0.ap_idle & ~tCalc1_2_U0.ap_sync_entry_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'tTest_tTest.tCalc1_2_U0.entry_proc_U0'");
                        end
                    end
                    endcase
                end
                11 : begin
                    case(index2)
                    9: begin
                        if (~tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.varSumA_blk_n) begin
                            if (~tCalc1_2_U0.varSumA_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_2_U0.varSumA_c_U' written by process 'tTest_tTest.tCalc1_2_U0.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.varSumA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_2_U0.varSumA_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_2_U0.varSumA_c_U' read by process 'tTest_tTest.tCalc1_2_U0.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.varSumA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin
                        if (~tCalc1_2_U0.add_ln50_loc_i_channel_U.if_empty_n & tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0.ap_idle & ~tCalc1_2_U0.add_ln50_loc_i_channel_U.if_write) begin
                            if (~tCalc1_2_U0.add_ln50_loc_i_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_2_U0.add_ln50_loc_i_channel_U' written by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.add_ln50_loc_i_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_2_U0.add_ln50_loc_i_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_2_U0.add_ln50_loc_i_channel_U' read by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.add_ln50_loc_i_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                12 : begin
                    case(index2)
                    11: begin
                        if (~tCalc1_2_U0.var_r_U.if_empty_n & tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0.ap_idle & ~tCalc1_2_U0.var_r_U.if_write) begin
                            if (~tCalc1_2_U0.var_r_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_2_U0.var_r_U' written by process 'tTest_tTest.tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.var_r_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_2_U0.var_r_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_2_U0.var_r_U' read by process 'tTest_tTest.tCalc1_2_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.var_r_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin
                        if (~tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0.numDataA_blk_n) begin
                            if (~tCalc1_2_U0.numDataA_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_2_U0.numDataA_c_U' written by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_2_U0.numDataA_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_2_U0.numDataA_c_U' read by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_2_U0.numDataA_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    18: begin
                        if (~tCalc1ResultA_U.if_full_n & tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0.ap_done & ap_done_reg_10 & ~tCalc1ResultA_U.if_read) begin
                            if (~tCalc1ResultA_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultA_U' written by process 'tTest_tTest.tCalc2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultA_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultA_U' read by process 'tTest_tTest.tCalc2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    19: begin
                        if (~tCalc1ResultA_U.if_full_n & tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0.ap_done & ap_done_reg_10 & ~tCalc1ResultA_U.if_read) begin
                            if (~tCalc1ResultA_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultA_U' written by process 'tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultA_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultA_U' read by process 'tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                13 : begin
                    case(index2)
                    7: begin
                        if (~varSumB_channel_U.if_empty_n & tCalc1_U0.ap_idle & ~varSumB_channel_U.if_write) begin
                            if (~varSumB_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.varSumB_channel_U' written by process 'tTest_tTest.varSum_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.varSumB_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~varSumB_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.varSumB_channel_U' read by process 'tTest_tTest.varSum_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.varSumB_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (~tCalc1_U0.tCalc1_Block_entry4_proc_U0.numDataB_blk_n) begin
                            if (~numDataB_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.numDataB_c_U' written by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~numDataB_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.numDataB_c_U' read by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    18: begin
                        if (~tCalc1ResultB_U.if_full_n & tCalc1_U0.ap_done & ap_done_reg_11 & ~tCalc1ResultB_U.if_read) begin
                            if (~tCalc1ResultB_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultB_U' written by process 'tTest_tTest.tCalc2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultB_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultB_U' read by process 'tTest_tTest.tCalc2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    19: begin
                        if (~tCalc1ResultB_U.if_full_n & tCalc1_U0.ap_done & ap_done_reg_11 & ~tCalc1ResultB_U.if_read) begin
                            if (~tCalc1ResultB_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultB_U' written by process 'tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultB_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultB_U' read by process 'tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                14 : begin
                    case(index2)
                    7: begin
                        if (~varSumB_channel_U.if_empty_n & tCalc1_U0.entry_proc37_U0.ap_idle & ~varSumB_channel_U.if_write) begin
                            if (~varSumB_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.varSumB_channel_U' written by process 'tTest_tTest.varSum_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.varSumB_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~varSumB_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.varSumB_channel_U' read by process 'tTest_tTest.varSum_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.varSumB_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    16: begin
                        if (~tCalc1_U0.entry_proc37_U0.varSumB_c_blk_n) begin
                            if (~tCalc1_U0.varSumB_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_U0.varSumB_c_U' written by process 'tTest_tTest.tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.varSumB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_U0.varSumB_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_U0.varSumB_c_U' read by process 'tTest_tTest.tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.varSumB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    15: begin
                        if (tCalc1_U0.ap_sync_entry_proc37_U0_ap_ready & tCalc1_U0.entry_proc37_U0.ap_idle & ~tCalc1_U0.ap_sync_tCalc1_Block_entry4_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry4_proc_U0'");
                        end
                    end
                    endcase
                end
                15 : begin
                    case(index2)
                    4: begin
                        if (~tCalc1_U0.tCalc1_Block_entry4_proc_U0.numDataB_blk_n) begin
                            if (~numDataB_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.numDataB_c_U' written by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~numDataB_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.numDataB_c_U' read by process 'tTest_tTest.divVal_ap_uint_47_ap_ufixed_16_8_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    17: begin
                        if (~tCalc1_U0.tCalc1_Block_entry4_proc_U0.numDataB_c_blk_n) begin
                            if (~tCalc1_U0.numDataB_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_U0.numDataB_c_U' written by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_U0.numDataB_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_U0.numDataB_c_U' read by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    14: begin
                        if (tCalc1_U0.ap_sync_tCalc1_Block_entry4_proc_U0_ap_ready & tCalc1_U0.tCalc1_Block_entry4_proc_U0.ap_idle & ~tCalc1_U0.ap_sync_entry_proc37_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'tTest_tTest.tCalc1_U0.entry_proc37_U0'");
                        end
                    end
                    endcase
                end
                16 : begin
                    case(index2)
                    14: begin
                        if (~tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.varSumB_blk_n) begin
                            if (~tCalc1_U0.varSumB_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_U0.varSumB_c_U' written by process 'tTest_tTest.tCalc1_U0.entry_proc37_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.varSumB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_U0.varSumB_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_U0.varSumB_c_U' read by process 'tTest_tTest.tCalc1_U0.entry_proc37_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.varSumB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    15: begin
                        if (~tCalc1_U0.add_ln50_loc_i_channel_U.if_empty_n & tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0.ap_idle & ~tCalc1_U0.add_ln50_loc_i_channel_U.if_write) begin
                            if (~tCalc1_U0.add_ln50_loc_i_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_U0.add_ln50_loc_i_channel_U' written by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.add_ln50_loc_i_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_U0.add_ln50_loc_i_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_U0.add_ln50_loc_i_channel_U' read by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.add_ln50_loc_i_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                17 : begin
                    case(index2)
                    16: begin
                        if (~tCalc1_U0.var_r_s_U.if_empty_n & tCalc1_U0.tCalc1_Block_entry46_proc_U0.ap_idle & ~tCalc1_U0.var_r_s_U.if_write) begin
                            if (~tCalc1_U0.var_r_s_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_U0.var_r_s_U' written by process 'tTest_tTest.tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.var_r_s_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_U0.var_r_s_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_U0.var_r_s_U' read by process 'tTest_tTest.tCalc1_U0.divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.var_r_s_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    15: begin
                        if (~tCalc1_U0.tCalc1_Block_entry46_proc_U0.numDataB_blk_n) begin
                            if (~tCalc1_U0.numDataB_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1_U0.numDataB_c_U' written by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1_U0.numDataB_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1_U0.numDataB_c_U' read by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1_U0.numDataB_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    18: begin
                        if (~tCalc1ResultB_U.if_full_n & tCalc1_U0.tCalc1_Block_entry46_proc_U0.ap_done & ap_done_reg_14 & ~tCalc1ResultB_U.if_read) begin
                            if (~tCalc1ResultB_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultB_U' written by process 'tTest_tTest.tCalc2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultB_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultB_U' read by process 'tTest_tTest.tCalc2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    19: begin
                        if (~tCalc1ResultB_U.if_full_n & tCalc1_U0.tCalc1_Block_entry46_proc_U0.ap_done & ap_done_reg_14 & ~tCalc1ResultB_U.if_read) begin
                            if (~tCalc1ResultB_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultB_U' written by process 'tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultB_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultB_U' read by process 'tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                18 : begin
                    case(index2)
                    8: begin
                        if (~tCalc1ResultA_U.if_empty_n & tCalc2_U0.ap_idle & ~tCalc1ResultA_U.if_write) begin
                            if (~tCalc1ResultA_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultA_U' written by process 'tTest_tTest.tCalc1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultA_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultA_U' read by process 'tTest_tTest.tCalc1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin
                        if (~tCalc1ResultA_U.if_empty_n & tCalc2_U0.ap_idle & ~tCalc1ResultA_U.if_write) begin
                            if (~tCalc1ResultA_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultA_U' written by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultA_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultA_U' read by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin
                        if (~tCalc1ResultB_U.if_empty_n & tCalc2_U0.ap_idle & ~tCalc1ResultB_U.if_write) begin
                            if (~tCalc1ResultB_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultB_U' written by process 'tTest_tTest.tCalc1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultB_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultB_U' read by process 'tTest_tTest.tCalc1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    17: begin
                        if (~tCalc1ResultB_U.if_empty_n & tCalc2_U0.ap_idle & ~tCalc1ResultB_U.if_write) begin
                            if (~tCalc1ResultB_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultB_U' written by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultB_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultB_U' read by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    5: begin
                        if (~meanDiff_U.if_empty_n & tCalc2_U0.ap_idle & ~meanDiff_U.if_write) begin
                            if (~meanDiff_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.meanDiff_U' written by process 'tTest_tTest.diff_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanDiff_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~meanDiff_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.meanDiff_U' read by process 'tTest_tTest.diff_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanDiff_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    20: begin
                        if (~t_U.if_full_n & tCalc2_U0.ap_done & ap_done_reg_15 & ~t_U.if_read) begin
                            if (~t_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.t_U' written by process 'tTest_tTest.Block_entry2458_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.t_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~t_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.t_U' read by process 'tTest_tTest.Block_entry2458_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.t_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                19 : begin
                    case(index2)
                    13: begin
                        if (~tCalc1ResultB_U.if_empty_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle & ~tCalc1ResultB_U.if_write) begin
                            if (~tCalc1ResultB_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultB_U' written by process 'tTest_tTest.tCalc1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultB_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultB_U' read by process 'tTest_tTest.tCalc1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    17: begin
                        if (~tCalc1ResultB_U.if_empty_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle & ~tCalc1ResultB_U.if_write) begin
                            if (~tCalc1ResultB_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultB_U' written by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultB_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultB_U' read by process 'tTest_tTest.tCalc1_U0.tCalc1_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultB_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    8: begin
                        if (~tCalc1ResultA_U.if_empty_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle & ~tCalc1ResultA_U.if_write) begin
                            if (~tCalc1ResultA_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultA_U' written by process 'tTest_tTest.tCalc1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultA_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultA_U' read by process 'tTest_tTest.tCalc1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin
                        if (~tCalc1ResultA_U.if_empty_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle & ~tCalc1ResultA_U.if_write) begin
                            if (~tCalc1ResultA_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.tCalc1ResultA_U' written by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~tCalc1ResultA_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.tCalc1ResultA_U' read by process 'tTest_tTest.tCalc1_2_U0.tCalc1_2_Block_entry46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.tCalc1ResultA_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    5: begin
                        if (~meanDiff_U.if_empty_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_idle & ~meanDiff_U.if_write) begin
                            if (~meanDiff_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.meanDiff_U' written by process 'tTest_tTest.diff_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanDiff_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~meanDiff_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.meanDiff_U' read by process 'tTest_tTest.diff_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.meanDiff_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    20: begin
                        if (~t_U.if_full_n & tCalc2_U0.tCalc2_Block_entry12_proc_U0.ap_done & ap_done_reg_16 & ~t_U.if_read) begin
                            if (~t_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.t_U' written by process 'tTest_tTest.Block_entry2458_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.t_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~t_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.t_U' read by process 'tTest_tTest.Block_entry2458_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.t_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                20 : begin
                    case(index2)
                    18: begin
                        if (~t_U.if_empty_n & Block_entry2458_proc_U0.ap_idle & ~t_U.if_write) begin
                            if (~t_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.t_U' written by process 'tTest_tTest.tCalc2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.t_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~t_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.t_U' read by process 'tTest_tTest.tCalc2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.t_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    19: begin
                        if (~t_U.if_empty_n & Block_entry2458_proc_U0.ap_idle & ~t_U.if_write) begin
                            if (~t_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.t_U' written by process 'tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.t_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~t_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.t_U' read by process 'tTest_tTest.tCalc2_U0.tCalc2_Block_entry12_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.t_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    0: begin
                        if (~Block_entry2458_proc_U0.C_blk_n) begin
                            if (~C_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'tTest_tTest.C_c_U' written by process 'tTest_tTest.entry_proc38_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.C_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~C_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'tTest_tTest.C_c_U' read by process 'tTest_tTest.entry_proc38_U0'");
                                $fdisplay(fp, "Dependence_Channel_path tTest_tTest.C_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
            endcase
        end
    endtask

    // report
    initial begin : report_deadlock
        integer cycle_id;
        integer cycle_comp_id;
        integer record_time;
        wait (dl_reset == 1);
        cycle_id = 1;
        record_time = 0;
        while (1) begin
            @ (negedge dl_clock);
            case (CS_fsm)
                ST_DL_DETECTED: begin
                    cycle_comp_id = 2;
                    if (dl_detect_reg != dl_done_reg) begin
                        if (dl_done_reg == 'b0) begin
                            print_dl_head;
                            record_time = $time;
                        end
                        print_cycle_start(proc_path(origin), cycle_id);
                        cycle_id = cycle_id + 1;
                    end
                    else begin
                        print_dl_end((cycle_id - 1),record_time);
                        @(negedge dl_clock);
                        @(negedge dl_clock);
                        $finish;
                    end
                end
                ST_DL_REPORT: begin
                    if ((|(dl_in_vec)) & ~(|(dl_in_vec & origin_reg))) begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                        print_cycle_proc_comp(proc_path(dl_in_vec), cycle_comp_id);
                        cycle_comp_id = cycle_comp_id + 1;
                    end
                    else begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                    end
                end
            endcase
        end
    end
 
