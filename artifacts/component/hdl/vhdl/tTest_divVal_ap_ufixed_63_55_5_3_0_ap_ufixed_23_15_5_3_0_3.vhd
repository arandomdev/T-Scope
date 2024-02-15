-- ==============================================================
-- Generated by Vitis HLS v2023.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- ==============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tTest_divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3 is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    varSumA_dout : IN STD_LOGIC_VECTOR (62 downto 0);
    varSumA_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
    varSumA_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
    varSumA_empty_n : IN STD_LOGIC;
    varSumA_read : OUT STD_LOGIC;
    p_read : IN STD_LOGIC_VECTOR (39 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (22 downto 0) );
end;


architecture behav of tTest_divVal_ap_ufixed_63_55_5_3_0_ap_ufixed_23_15_5_3_0_3 is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000000000001000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000000000010000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000000000100000";
    constant ap_ST_fsm_state7 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000000001000000";
    constant ap_ST_fsm_state8 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000000010000000";
    constant ap_ST_fsm_state9 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000000100000000";
    constant ap_ST_fsm_state10 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000001000000000";
    constant ap_ST_fsm_state11 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000010000000000";
    constant ap_ST_fsm_state12 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000100000000000";
    constant ap_ST_fsm_state13 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000001000000000000";
    constant ap_ST_fsm_state14 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000010000000000000";
    constant ap_ST_fsm_state15 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000100000000000000";
    constant ap_ST_fsm_state16 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000001000000000000000";
    constant ap_ST_fsm_state17 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000010000000000000000";
    constant ap_ST_fsm_state18 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000100000000000000000";
    constant ap_ST_fsm_state19 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000001000000000000000000";
    constant ap_ST_fsm_state20 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000010000000000000000000";
    constant ap_ST_fsm_state21 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000100000000000000000000";
    constant ap_ST_fsm_state22 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000001000000000000000000000";
    constant ap_ST_fsm_state23 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000010000000000000000000000";
    constant ap_ST_fsm_state24 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000100000000000000000000000";
    constant ap_ST_fsm_state25 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000001000000000000000000000000";
    constant ap_ST_fsm_state26 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000010000000000000000000000000";
    constant ap_ST_fsm_state27 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000100000000000000000000000000";
    constant ap_ST_fsm_state28 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000001000000000000000000000000000";
    constant ap_ST_fsm_state29 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000010000000000000000000000000000";
    constant ap_ST_fsm_state30 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000100000000000000000000000000000";
    constant ap_ST_fsm_state31 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000001000000000000000000000000000000";
    constant ap_ST_fsm_state32 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000010000000000000000000000000000000";
    constant ap_ST_fsm_state33 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000100000000000000000000000000000000";
    constant ap_ST_fsm_state34 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000001000000000000000000000000000000000";
    constant ap_ST_fsm_state35 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000010000000000000000000000000000000000";
    constant ap_ST_fsm_state36 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000100000000000000000000000000000000000";
    constant ap_ST_fsm_state37 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000001000000000000000000000000000000000000";
    constant ap_ST_fsm_state38 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000010000000000000000000000000000000000000";
    constant ap_ST_fsm_state39 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000100000000000000000000000000000000000000";
    constant ap_ST_fsm_state40 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000001000000000000000000000000000000000000000";
    constant ap_ST_fsm_state41 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000010000000000000000000000000000000000000000";
    constant ap_ST_fsm_state42 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000100000000000000000000000000000000000000000";
    constant ap_ST_fsm_state43 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000001000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state44 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000010000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state45 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000100000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state46 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000001000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state47 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000010000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state48 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000100000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state49 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000001000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state50 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000010000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state51 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000100000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state52 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000001000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state53 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000010000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state54 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000100000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state55 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000001000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state56 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000010000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state57 : STD_LOGIC_VECTOR (67 downto 0) := "00000000000100000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state58 : STD_LOGIC_VECTOR (67 downto 0) := "00000000001000000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state59 : STD_LOGIC_VECTOR (67 downto 0) := "00000000010000000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state60 : STD_LOGIC_VECTOR (67 downto 0) := "00000000100000000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state61 : STD_LOGIC_VECTOR (67 downto 0) := "00000001000000000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state62 : STD_LOGIC_VECTOR (67 downto 0) := "00000010000000000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state63 : STD_LOGIC_VECTOR (67 downto 0) := "00000100000000000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state64 : STD_LOGIC_VECTOR (67 downto 0) := "00001000000000000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state65 : STD_LOGIC_VECTOR (67 downto 0) := "00010000000000000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state66 : STD_LOGIC_VECTOR (67 downto 0) := "00100000000000000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state67 : STD_LOGIC_VECTOR (67 downto 0) := "01000000000000000000000000000000000000000000000000000000000000000000";
    constant ap_ST_fsm_state68 : STD_LOGIC_VECTOR (67 downto 0) := "10000000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_43 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001000011";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv40_0 : STD_LOGIC_VECTOR (39 downto 0) := "0000000000000000000000000000000000000000";
    constant ap_const_lv23_0 : STD_LOGIC_VECTOR (22 downto 0) := "00000000000000000000000";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv63_0 : STD_LOGIC_VECTOR (62 downto 0) := "000000000000000000000000000000000000000000000000000000000000000";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (67 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal varSumA_blk_n : STD_LOGIC;
    signal ap_block_state1 : BOOLEAN;
    signal varSumA_read_reg_75 : STD_LOGIC_VECTOR (62 downto 0) := "000000000000000000000000000000000000000000000000000000000000000";
    signal icmp_ln23_fu_51_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln23_reg_80 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal trunc_ln24_fu_65_p1 : STD_LOGIC_VECTOR (22 downto 0);
    signal ap_phi_mux_var_i_out_0_phi_fu_44_p4 : STD_LOGIC_VECTOR (22 downto 0);
    signal var_i_out_0_reg_40 : STD_LOGIC_VECTOR (22 downto 0) := "00000000000000000000000";
    signal ap_CS_fsm_state68 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state68 : signal is "none";
    signal grp_fu_60_p1 : STD_LOGIC_VECTOR (39 downto 0);
    signal grp_fu_60_p2 : STD_LOGIC_VECTOR (22 downto 0);
    signal grp_fu_60_ap_start : STD_LOGIC;
    signal grp_fu_60_ap_done : STD_LOGIC;
    signal ap_return_preg : STD_LOGIC_VECTOR (22 downto 0) := "00000000000000000000000";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (67 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal ap_ST_fsm_state5_blk : STD_LOGIC;
    signal ap_ST_fsm_state6_blk : STD_LOGIC;
    signal ap_ST_fsm_state7_blk : STD_LOGIC;
    signal ap_ST_fsm_state8_blk : STD_LOGIC;
    signal ap_ST_fsm_state9_blk : STD_LOGIC;
    signal ap_ST_fsm_state10_blk : STD_LOGIC;
    signal ap_ST_fsm_state11_blk : STD_LOGIC;
    signal ap_ST_fsm_state12_blk : STD_LOGIC;
    signal ap_ST_fsm_state13_blk : STD_LOGIC;
    signal ap_ST_fsm_state14_blk : STD_LOGIC;
    signal ap_ST_fsm_state15_blk : STD_LOGIC;
    signal ap_ST_fsm_state16_blk : STD_LOGIC;
    signal ap_ST_fsm_state17_blk : STD_LOGIC;
    signal ap_ST_fsm_state18_blk : STD_LOGIC;
    signal ap_ST_fsm_state19_blk : STD_LOGIC;
    signal ap_ST_fsm_state20_blk : STD_LOGIC;
    signal ap_ST_fsm_state21_blk : STD_LOGIC;
    signal ap_ST_fsm_state22_blk : STD_LOGIC;
    signal ap_ST_fsm_state23_blk : STD_LOGIC;
    signal ap_ST_fsm_state24_blk : STD_LOGIC;
    signal ap_ST_fsm_state25_blk : STD_LOGIC;
    signal ap_ST_fsm_state26_blk : STD_LOGIC;
    signal ap_ST_fsm_state27_blk : STD_LOGIC;
    signal ap_ST_fsm_state28_blk : STD_LOGIC;
    signal ap_ST_fsm_state29_blk : STD_LOGIC;
    signal ap_ST_fsm_state30_blk : STD_LOGIC;
    signal ap_ST_fsm_state31_blk : STD_LOGIC;
    signal ap_ST_fsm_state32_blk : STD_LOGIC;
    signal ap_ST_fsm_state33_blk : STD_LOGIC;
    signal ap_ST_fsm_state34_blk : STD_LOGIC;
    signal ap_ST_fsm_state35_blk : STD_LOGIC;
    signal ap_ST_fsm_state36_blk : STD_LOGIC;
    signal ap_ST_fsm_state37_blk : STD_LOGIC;
    signal ap_ST_fsm_state38_blk : STD_LOGIC;
    signal ap_ST_fsm_state39_blk : STD_LOGIC;
    signal ap_ST_fsm_state40_blk : STD_LOGIC;
    signal ap_ST_fsm_state41_blk : STD_LOGIC;
    signal ap_ST_fsm_state42_blk : STD_LOGIC;
    signal ap_ST_fsm_state43_blk : STD_LOGIC;
    signal ap_ST_fsm_state44_blk : STD_LOGIC;
    signal ap_ST_fsm_state45_blk : STD_LOGIC;
    signal ap_ST_fsm_state46_blk : STD_LOGIC;
    signal ap_ST_fsm_state47_blk : STD_LOGIC;
    signal ap_ST_fsm_state48_blk : STD_LOGIC;
    signal ap_ST_fsm_state49_blk : STD_LOGIC;
    signal ap_ST_fsm_state50_blk : STD_LOGIC;
    signal ap_ST_fsm_state51_blk : STD_LOGIC;
    signal ap_ST_fsm_state52_blk : STD_LOGIC;
    signal ap_ST_fsm_state53_blk : STD_LOGIC;
    signal ap_ST_fsm_state54_blk : STD_LOGIC;
    signal ap_ST_fsm_state55_blk : STD_LOGIC;
    signal ap_ST_fsm_state56_blk : STD_LOGIC;
    signal ap_ST_fsm_state57_blk : STD_LOGIC;
    signal ap_ST_fsm_state58_blk : STD_LOGIC;
    signal ap_ST_fsm_state59_blk : STD_LOGIC;
    signal ap_ST_fsm_state60_blk : STD_LOGIC;
    signal ap_ST_fsm_state61_blk : STD_LOGIC;
    signal ap_ST_fsm_state62_blk : STD_LOGIC;
    signal ap_ST_fsm_state63_blk : STD_LOGIC;
    signal ap_ST_fsm_state64_blk : STD_LOGIC;
    signal ap_ST_fsm_state65_blk : STD_LOGIC;
    signal ap_ST_fsm_state66_blk : STD_LOGIC;
    signal ap_ST_fsm_state67_blk : STD_LOGIC;
    signal ap_ST_fsm_state68_blk : STD_LOGIC;
    signal grp_fu_60_p10 : STD_LOGIC_VECTOR (62 downto 0);
    signal ap_ce_reg : STD_LOGIC;

    component tTest_udiv_63ns_40ns_23_67_seq_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (62 downto 0);
        din1 : IN STD_LOGIC_VECTOR (39 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (22 downto 0) );
    end component;



begin
    udiv_63ns_40ns_23_67_seq_1_U49 : component tTest_udiv_63ns_40ns_23_67_seq_1
    generic map (
        ID => 1,
        NUM_STAGE => 67,
        din0_WIDTH => 63,
        din1_WIDTH => 40,
        dout_WIDTH => 23)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        start => grp_fu_60_ap_start,
        done => grp_fu_60_ap_done,
        din0 => varSumA_read_reg_75,
        din1 => grp_fu_60_p1,
        ce => ap_const_logic_1,
        dout => grp_fu_60_p2);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state68)) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_return_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_return_preg <= ap_const_lv23_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state68)) then 
                    ap_return_preg <= ap_phi_mux_var_i_out_0_phi_fu_44_p4;
                end if; 
            end if;
        end if;
    end process;


    icmp_ln23_reg_80_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                icmp_ln23_reg_80 <= ap_const_lv1_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_const_boolean_0 = ap_block_state1))) then 
                    icmp_ln23_reg_80 <= icmp_ln23_fu_51_p2;
                end if; 
            end if;
        end if;
    end process;


    varSumA_read_reg_75_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                varSumA_read_reg_75 <= ap_const_lv63_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_const_boolean_0 = ap_block_state1))) then 
                    varSumA_read_reg_75 <= varSumA_dout;
                end if; 
            end if;
        end if;
    end process;


    var_i_out_0_reg_40_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                var_i_out_0_reg_40 <= ap_const_lv23_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_state68) and (icmp_ln23_reg_80 = ap_const_lv1_0))) then 
                    var_i_out_0_reg_40 <= trunc_ln24_fu_65_p1;
                end if; 
            end if;
        end if;
    end process;


    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_CS_fsm_state1, ap_block_state1, icmp_ln23_fu_51_p2)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state1) and (icmp_ln23_fu_51_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state68;
                elsif (((ap_const_logic_1 = ap_CS_fsm_state1) and (icmp_ln23_fu_51_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state5;
            when ap_ST_fsm_state5 => 
                ap_NS_fsm <= ap_ST_fsm_state6;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when ap_ST_fsm_state7 => 
                ap_NS_fsm <= ap_ST_fsm_state8;
            when ap_ST_fsm_state8 => 
                ap_NS_fsm <= ap_ST_fsm_state9;
            when ap_ST_fsm_state9 => 
                ap_NS_fsm <= ap_ST_fsm_state10;
            when ap_ST_fsm_state10 => 
                ap_NS_fsm <= ap_ST_fsm_state11;
            when ap_ST_fsm_state11 => 
                ap_NS_fsm <= ap_ST_fsm_state12;
            when ap_ST_fsm_state12 => 
                ap_NS_fsm <= ap_ST_fsm_state13;
            when ap_ST_fsm_state13 => 
                ap_NS_fsm <= ap_ST_fsm_state14;
            when ap_ST_fsm_state14 => 
                ap_NS_fsm <= ap_ST_fsm_state15;
            when ap_ST_fsm_state15 => 
                ap_NS_fsm <= ap_ST_fsm_state16;
            when ap_ST_fsm_state16 => 
                ap_NS_fsm <= ap_ST_fsm_state17;
            when ap_ST_fsm_state17 => 
                ap_NS_fsm <= ap_ST_fsm_state18;
            when ap_ST_fsm_state18 => 
                ap_NS_fsm <= ap_ST_fsm_state19;
            when ap_ST_fsm_state19 => 
                ap_NS_fsm <= ap_ST_fsm_state20;
            when ap_ST_fsm_state20 => 
                ap_NS_fsm <= ap_ST_fsm_state21;
            when ap_ST_fsm_state21 => 
                ap_NS_fsm <= ap_ST_fsm_state22;
            when ap_ST_fsm_state22 => 
                ap_NS_fsm <= ap_ST_fsm_state23;
            when ap_ST_fsm_state23 => 
                ap_NS_fsm <= ap_ST_fsm_state24;
            when ap_ST_fsm_state24 => 
                ap_NS_fsm <= ap_ST_fsm_state25;
            when ap_ST_fsm_state25 => 
                ap_NS_fsm <= ap_ST_fsm_state26;
            when ap_ST_fsm_state26 => 
                ap_NS_fsm <= ap_ST_fsm_state27;
            when ap_ST_fsm_state27 => 
                ap_NS_fsm <= ap_ST_fsm_state28;
            when ap_ST_fsm_state28 => 
                ap_NS_fsm <= ap_ST_fsm_state29;
            when ap_ST_fsm_state29 => 
                ap_NS_fsm <= ap_ST_fsm_state30;
            when ap_ST_fsm_state30 => 
                ap_NS_fsm <= ap_ST_fsm_state31;
            when ap_ST_fsm_state31 => 
                ap_NS_fsm <= ap_ST_fsm_state32;
            when ap_ST_fsm_state32 => 
                ap_NS_fsm <= ap_ST_fsm_state33;
            when ap_ST_fsm_state33 => 
                ap_NS_fsm <= ap_ST_fsm_state34;
            when ap_ST_fsm_state34 => 
                ap_NS_fsm <= ap_ST_fsm_state35;
            when ap_ST_fsm_state35 => 
                ap_NS_fsm <= ap_ST_fsm_state36;
            when ap_ST_fsm_state36 => 
                ap_NS_fsm <= ap_ST_fsm_state37;
            when ap_ST_fsm_state37 => 
                ap_NS_fsm <= ap_ST_fsm_state38;
            when ap_ST_fsm_state38 => 
                ap_NS_fsm <= ap_ST_fsm_state39;
            when ap_ST_fsm_state39 => 
                ap_NS_fsm <= ap_ST_fsm_state40;
            when ap_ST_fsm_state40 => 
                ap_NS_fsm <= ap_ST_fsm_state41;
            when ap_ST_fsm_state41 => 
                ap_NS_fsm <= ap_ST_fsm_state42;
            when ap_ST_fsm_state42 => 
                ap_NS_fsm <= ap_ST_fsm_state43;
            when ap_ST_fsm_state43 => 
                ap_NS_fsm <= ap_ST_fsm_state44;
            when ap_ST_fsm_state44 => 
                ap_NS_fsm <= ap_ST_fsm_state45;
            when ap_ST_fsm_state45 => 
                ap_NS_fsm <= ap_ST_fsm_state46;
            when ap_ST_fsm_state46 => 
                ap_NS_fsm <= ap_ST_fsm_state47;
            when ap_ST_fsm_state47 => 
                ap_NS_fsm <= ap_ST_fsm_state48;
            when ap_ST_fsm_state48 => 
                ap_NS_fsm <= ap_ST_fsm_state49;
            when ap_ST_fsm_state49 => 
                ap_NS_fsm <= ap_ST_fsm_state50;
            when ap_ST_fsm_state50 => 
                ap_NS_fsm <= ap_ST_fsm_state51;
            when ap_ST_fsm_state51 => 
                ap_NS_fsm <= ap_ST_fsm_state52;
            when ap_ST_fsm_state52 => 
                ap_NS_fsm <= ap_ST_fsm_state53;
            when ap_ST_fsm_state53 => 
                ap_NS_fsm <= ap_ST_fsm_state54;
            when ap_ST_fsm_state54 => 
                ap_NS_fsm <= ap_ST_fsm_state55;
            when ap_ST_fsm_state55 => 
                ap_NS_fsm <= ap_ST_fsm_state56;
            when ap_ST_fsm_state56 => 
                ap_NS_fsm <= ap_ST_fsm_state57;
            when ap_ST_fsm_state57 => 
                ap_NS_fsm <= ap_ST_fsm_state58;
            when ap_ST_fsm_state58 => 
                ap_NS_fsm <= ap_ST_fsm_state59;
            when ap_ST_fsm_state59 => 
                ap_NS_fsm <= ap_ST_fsm_state60;
            when ap_ST_fsm_state60 => 
                ap_NS_fsm <= ap_ST_fsm_state61;
            when ap_ST_fsm_state61 => 
                ap_NS_fsm <= ap_ST_fsm_state62;
            when ap_ST_fsm_state62 => 
                ap_NS_fsm <= ap_ST_fsm_state63;
            when ap_ST_fsm_state63 => 
                ap_NS_fsm <= ap_ST_fsm_state64;
            when ap_ST_fsm_state64 => 
                ap_NS_fsm <= ap_ST_fsm_state65;
            when ap_ST_fsm_state65 => 
                ap_NS_fsm <= ap_ST_fsm_state66;
            when ap_ST_fsm_state66 => 
                ap_NS_fsm <= ap_ST_fsm_state67;
            when ap_ST_fsm_state67 => 
                ap_NS_fsm <= ap_ST_fsm_state68;
            when ap_ST_fsm_state68 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state68 <= ap_CS_fsm(67);
    ap_ST_fsm_state10_blk <= ap_const_logic_0;
    ap_ST_fsm_state11_blk <= ap_const_logic_0;
    ap_ST_fsm_state12_blk <= ap_const_logic_0;
    ap_ST_fsm_state13_blk <= ap_const_logic_0;
    ap_ST_fsm_state14_blk <= ap_const_logic_0;
    ap_ST_fsm_state15_blk <= ap_const_logic_0;
    ap_ST_fsm_state16_blk <= ap_const_logic_0;
    ap_ST_fsm_state17_blk <= ap_const_logic_0;
    ap_ST_fsm_state18_blk <= ap_const_logic_0;
    ap_ST_fsm_state19_blk <= ap_const_logic_0;

    ap_ST_fsm_state1_blk_assign_proc : process(ap_block_state1)
    begin
        if ((ap_const_boolean_1 = ap_block_state1)) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state20_blk <= ap_const_logic_0;
    ap_ST_fsm_state21_blk <= ap_const_logic_0;
    ap_ST_fsm_state22_blk <= ap_const_logic_0;
    ap_ST_fsm_state23_blk <= ap_const_logic_0;
    ap_ST_fsm_state24_blk <= ap_const_logic_0;
    ap_ST_fsm_state25_blk <= ap_const_logic_0;
    ap_ST_fsm_state26_blk <= ap_const_logic_0;
    ap_ST_fsm_state27_blk <= ap_const_logic_0;
    ap_ST_fsm_state28_blk <= ap_const_logic_0;
    ap_ST_fsm_state29_blk <= ap_const_logic_0;
    ap_ST_fsm_state2_blk <= ap_const_logic_0;
    ap_ST_fsm_state30_blk <= ap_const_logic_0;
    ap_ST_fsm_state31_blk <= ap_const_logic_0;
    ap_ST_fsm_state32_blk <= ap_const_logic_0;
    ap_ST_fsm_state33_blk <= ap_const_logic_0;
    ap_ST_fsm_state34_blk <= ap_const_logic_0;
    ap_ST_fsm_state35_blk <= ap_const_logic_0;
    ap_ST_fsm_state36_blk <= ap_const_logic_0;
    ap_ST_fsm_state37_blk <= ap_const_logic_0;
    ap_ST_fsm_state38_blk <= ap_const_logic_0;
    ap_ST_fsm_state39_blk <= ap_const_logic_0;
    ap_ST_fsm_state3_blk <= ap_const_logic_0;
    ap_ST_fsm_state40_blk <= ap_const_logic_0;
    ap_ST_fsm_state41_blk <= ap_const_logic_0;
    ap_ST_fsm_state42_blk <= ap_const_logic_0;
    ap_ST_fsm_state43_blk <= ap_const_logic_0;
    ap_ST_fsm_state44_blk <= ap_const_logic_0;
    ap_ST_fsm_state45_blk <= ap_const_logic_0;
    ap_ST_fsm_state46_blk <= ap_const_logic_0;
    ap_ST_fsm_state47_blk <= ap_const_logic_0;
    ap_ST_fsm_state48_blk <= ap_const_logic_0;
    ap_ST_fsm_state49_blk <= ap_const_logic_0;
    ap_ST_fsm_state4_blk <= ap_const_logic_0;
    ap_ST_fsm_state50_blk <= ap_const_logic_0;
    ap_ST_fsm_state51_blk <= ap_const_logic_0;
    ap_ST_fsm_state52_blk <= ap_const_logic_0;
    ap_ST_fsm_state53_blk <= ap_const_logic_0;
    ap_ST_fsm_state54_blk <= ap_const_logic_0;
    ap_ST_fsm_state55_blk <= ap_const_logic_0;
    ap_ST_fsm_state56_blk <= ap_const_logic_0;
    ap_ST_fsm_state57_blk <= ap_const_logic_0;
    ap_ST_fsm_state58_blk <= ap_const_logic_0;
    ap_ST_fsm_state59_blk <= ap_const_logic_0;
    ap_ST_fsm_state5_blk <= ap_const_logic_0;
    ap_ST_fsm_state60_blk <= ap_const_logic_0;
    ap_ST_fsm_state61_blk <= ap_const_logic_0;
    ap_ST_fsm_state62_blk <= ap_const_logic_0;
    ap_ST_fsm_state63_blk <= ap_const_logic_0;
    ap_ST_fsm_state64_blk <= ap_const_logic_0;
    ap_ST_fsm_state65_blk <= ap_const_logic_0;
    ap_ST_fsm_state66_blk <= ap_const_logic_0;
    ap_ST_fsm_state67_blk <= ap_const_logic_0;
    ap_ST_fsm_state68_blk <= ap_const_logic_0;
    ap_ST_fsm_state6_blk <= ap_const_logic_0;
    ap_ST_fsm_state7_blk <= ap_const_logic_0;
    ap_ST_fsm_state8_blk <= ap_const_logic_0;
    ap_ST_fsm_state9_blk <= ap_const_logic_0;

    ap_block_state1_assign_proc : process(ap_start, ap_done_reg, varSumA_empty_n)
    begin
                ap_block_state1 <= ((varSumA_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state68)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state68)) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_phi_mux_var_i_out_0_phi_fu_44_p4_assign_proc : process(icmp_ln23_reg_80, trunc_ln24_fu_65_p1, var_i_out_0_reg_40, ap_CS_fsm_state68)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state68) and (icmp_ln23_reg_80 = ap_const_lv1_0))) then 
            ap_phi_mux_var_i_out_0_phi_fu_44_p4 <= trunc_ln24_fu_65_p1;
        else 
            ap_phi_mux_var_i_out_0_phi_fu_44_p4 <= var_i_out_0_reg_40;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state68)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state68)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_return_assign_proc : process(ap_phi_mux_var_i_out_0_phi_fu_44_p4, ap_CS_fsm_state68, ap_return_preg)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state68)) then 
            ap_return <= ap_phi_mux_var_i_out_0_phi_fu_44_p4;
        else 
            ap_return <= ap_return_preg;
        end if; 
    end process;


    grp_fu_60_ap_start_assign_proc : process(ap_CS_fsm_state2)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            grp_fu_60_ap_start <= ap_const_logic_1;
        else 
            grp_fu_60_ap_start <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_60_p1 <= grp_fu_60_p10(40 - 1 downto 0);
    grp_fu_60_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(p_read),63));
    icmp_ln23_fu_51_p2 <= "1" when (p_read = ap_const_lv40_0) else "0";
    trunc_ln24_fu_65_p1 <= grp_fu_60_p2(23 - 1 downto 0);

    varSumA_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, varSumA_empty_n)
    begin
        if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            varSumA_blk_n <= varSumA_empty_n;
        else 
            varSumA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    varSumA_read_assign_proc : process(ap_CS_fsm_state1, ap_block_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_const_boolean_0 = ap_block_state1))) then 
            varSumA_read <= ap_const_logic_1;
        else 
            varSumA_read <= ap_const_logic_0;
        end if; 
    end process;

end behav;
