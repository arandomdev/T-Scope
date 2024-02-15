-- ==============================================================
-- Generated by Vitis HLS v2023.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- ==============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tTest_tCalc1_Block_entry46_proc is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    p_read : IN STD_LOGIC_VECTOR (22 downto 0);
    numDataB_dout : IN STD_LOGIC_VECTOR (39 downto 0);
    numDataB_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
    numDataB_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
    numDataB_empty_n : IN STD_LOGIC;
    numDataB_read : OUT STD_LOGIC;
    tCalc1ResultB : OUT STD_LOGIC_VECTOR (31 downto 0) );
end;


architecture behav of tTest_tCalc1_Block_entry46_proc is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000000000000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000000000000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000000000000100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000000000001000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000000000010000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000000000100000";
    constant ap_ST_fsm_state7 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000000001000000";
    constant ap_ST_fsm_state8 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000000010000000";
    constant ap_ST_fsm_state9 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000000100000000";
    constant ap_ST_fsm_state10 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000001000000000";
    constant ap_ST_fsm_state11 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000010000000000";
    constant ap_ST_fsm_state12 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000100000000000";
    constant ap_ST_fsm_state13 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000001000000000000";
    constant ap_ST_fsm_state14 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000010000000000000";
    constant ap_ST_fsm_state15 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000100000000000000";
    constant ap_ST_fsm_state16 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000001000000000000000";
    constant ap_ST_fsm_state17 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000010000000000000000";
    constant ap_ST_fsm_state18 : STD_LOGIC_VECTOR (28 downto 0) := "00000000000100000000000000000";
    constant ap_ST_fsm_state19 : STD_LOGIC_VECTOR (28 downto 0) := "00000000001000000000000000000";
    constant ap_ST_fsm_state20 : STD_LOGIC_VECTOR (28 downto 0) := "00000000010000000000000000000";
    constant ap_ST_fsm_state21 : STD_LOGIC_VECTOR (28 downto 0) := "00000000100000000000000000000";
    constant ap_ST_fsm_state22 : STD_LOGIC_VECTOR (28 downto 0) := "00000001000000000000000000000";
    constant ap_ST_fsm_state23 : STD_LOGIC_VECTOR (28 downto 0) := "00000010000000000000000000000";
    constant ap_ST_fsm_state24 : STD_LOGIC_VECTOR (28 downto 0) := "00000100000000000000000000000";
    constant ap_ST_fsm_state25 : STD_LOGIC_VECTOR (28 downto 0) := "00001000000000000000000000000";
    constant ap_ST_fsm_state26 : STD_LOGIC_VECTOR (28 downto 0) := "00010000000000000000000000000";
    constant ap_ST_fsm_state27 : STD_LOGIC_VECTOR (28 downto 0) := "00100000000000000000000000000";
    constant ap_ST_fsm_state28 : STD_LOGIC_VECTOR (28 downto 0) := "01000000000000000000000000000";
    constant ap_ST_fsm_state29 : STD_LOGIC_VECTOR (28 downto 0) := "10000000000000000000000000000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_1B : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011011";
    constant ap_const_lv32_1C : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011100";
    constant ap_const_lv14_0 : STD_LOGIC_VECTOR (13 downto 0) := "00000000000000";
    constant ap_const_lv40_0 : STD_LOGIC_VECTOR (39 downto 0) := "0000000000000000000000000000000000000000";
    constant ap_const_lv18_0 : STD_LOGIC_VECTOR (17 downto 0) := "000000000000000000";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (28 downto 0) := "00000000000000000000000000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal numDataB_blk_n : STD_LOGIC;
    signal ap_block_state1 : BOOLEAN;
    signal numDataB_read_reg_76 : STD_LOGIC_VECTOR (39 downto 0) := "0000000000000000000000000000000000000000";
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal grp_fu_54_p2 : STD_LOGIC_VECTOR (17 downto 0);
    signal udiv_ln51_reg_86 : STD_LOGIC_VECTOR (17 downto 0) := "000000000000000000";
    signal ap_CS_fsm_state28 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state28 : signal is "none";
    signal shl_ln_fu_62_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal tCalc1ResultB_preg : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    signal ap_CS_fsm_state29 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state29 : signal is "none";
    signal grp_fu_54_p0 : STD_LOGIC_VECTOR (22 downto 0);
    signal trunc_ln51_fu_59_p1 : STD_LOGIC_VECTOR (17 downto 0);
    signal grp_fu_54_ap_start : STD_LOGIC;
    signal grp_fu_54_ap_done : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (28 downto 0);
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
    signal grp_fu_54_p00 : STD_LOGIC_VECTOR (39 downto 0);
    signal ap_ce_reg : STD_LOGIC;

    component tTest_udiv_23ns_40ns_18_27_seq_1 IS
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
        din0 : IN STD_LOGIC_VECTOR (22 downto 0);
        din1 : IN STD_LOGIC_VECTOR (39 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (17 downto 0) );
    end component;



begin
    udiv_23ns_40ns_18_27_seq_1_U72 : component tTest_udiv_23ns_40ns_18_27_seq_1
    generic map (
        ID => 1,
        NUM_STAGE => 27,
        din0_WIDTH => 23,
        din1_WIDTH => 40,
        dout_WIDTH => 18)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        start => grp_fu_54_ap_start,
        done => grp_fu_54_ap_done,
        din0 => grp_fu_54_p0,
        din1 => numDataB_read_reg_76,
        ce => ap_const_logic_1,
        dout => grp_fu_54_p2);





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
                elsif ((ap_const_logic_1 = ap_CS_fsm_state29)) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    numDataB_read_reg_76_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                numDataB_read_reg_76 <= ap_const_lv40_0;
            else
                if (((ap_const_boolean_0 = ap_block_state1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    numDataB_read_reg_76 <= numDataB_dout;
                end if; 
            end if;
        end if;
    end process;


    tCalc1ResultB_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                tCalc1ResultB_preg(14) <= '0';
                tCalc1ResultB_preg(15) <= '0';
                tCalc1ResultB_preg(16) <= '0';
                tCalc1ResultB_preg(17) <= '0';
                tCalc1ResultB_preg(18) <= '0';
                tCalc1ResultB_preg(19) <= '0';
                tCalc1ResultB_preg(20) <= '0';
                tCalc1ResultB_preg(21) <= '0';
                tCalc1ResultB_preg(22) <= '0';
                tCalc1ResultB_preg(23) <= '0';
                tCalc1ResultB_preg(24) <= '0';
                tCalc1ResultB_preg(25) <= '0';
                tCalc1ResultB_preg(26) <= '0';
                tCalc1ResultB_preg(27) <= '0';
                tCalc1ResultB_preg(28) <= '0';
                tCalc1ResultB_preg(29) <= '0';
                tCalc1ResultB_preg(30) <= '0';
                tCalc1ResultB_preg(31) <= '0';
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state29)) then 
                                        tCalc1ResultB_preg(31 downto 14) <= shl_ln_fu_62_p3(31 downto 14);
                end if; 
            end if;
        end if;
    end process;


    udiv_ln51_reg_86_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                udiv_ln51_reg_86 <= ap_const_lv18_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state28)) then 
                    udiv_ln51_reg_86 <= grp_fu_54_p2;
                end if; 
            end if;
        end if;
    end process;

    tCalc1ResultB_preg(13 downto 0) <= "00000000000000";

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_CS_fsm_state1, ap_block_state1)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_const_boolean_0 = ap_block_state1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
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
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state28 <= ap_CS_fsm(27);
    ap_CS_fsm_state29 <= ap_CS_fsm(28);
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
    ap_ST_fsm_state3_blk <= ap_const_logic_0;
    ap_ST_fsm_state4_blk <= ap_const_logic_0;
    ap_ST_fsm_state5_blk <= ap_const_logic_0;
    ap_ST_fsm_state6_blk <= ap_const_logic_0;
    ap_ST_fsm_state7_blk <= ap_const_logic_0;
    ap_ST_fsm_state8_blk <= ap_const_logic_0;
    ap_ST_fsm_state9_blk <= ap_const_logic_0;

    ap_block_state1_assign_proc : process(ap_start, ap_done_reg, numDataB_empty_n)
    begin
                ap_block_state1 <= ((numDataB_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state29)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state29)) then 
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


    ap_ready_assign_proc : process(ap_CS_fsm_state29)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state29)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    grp_fu_54_ap_start_assign_proc : process(ap_CS_fsm_state2)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            grp_fu_54_ap_start <= ap_const_logic_1;
        else 
            grp_fu_54_ap_start <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_54_p0 <= grp_fu_54_p00(23 - 1 downto 0);
    grp_fu_54_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(p_read),40));

    numDataB_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, numDataB_empty_n)
    begin
        if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            numDataB_blk_n <= numDataB_empty_n;
        else 
            numDataB_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    numDataB_read_assign_proc : process(ap_CS_fsm_state1, ap_block_state1)
    begin
        if (((ap_const_boolean_0 = ap_block_state1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            numDataB_read <= ap_const_logic_1;
        else 
            numDataB_read <= ap_const_logic_0;
        end if; 
    end process;

    shl_ln_fu_62_p3 <= (trunc_ln51_fu_59_p1 & ap_const_lv14_0);

    tCalc1ResultB_assign_proc : process(shl_ln_fu_62_p3, tCalc1ResultB_preg, ap_CS_fsm_state29)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state29)) then 
            tCalc1ResultB <= shl_ln_fu_62_p3;
        else 
            tCalc1ResultB <= tCalc1ResultB_preg;
        end if; 
    end process;

    trunc_ln51_fu_59_p1 <= udiv_ln51_reg_86(18 - 1 downto 0);
end behav;
