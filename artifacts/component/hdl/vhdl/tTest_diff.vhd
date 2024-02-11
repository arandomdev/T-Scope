-- ==============================================================
-- Generated by Vitis HLS v2023.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- ==============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tTest_diff is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    p_read : IN STD_LOGIC_VECTOR (15 downto 0);
    p_read1 : IN STD_LOGIC_VECTOR (15 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (15 downto 0) );
end;


architecture behav of tTest_diff is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv16_0 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ap_block_state1 : BOOLEAN;
    signal icmp_ln28_fu_18_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal sub_ln28_fu_24_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal sub_ln28_1_fu_30_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal select_ln28_fu_36_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_return_preg : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;


begin




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
                elsif (((ap_const_boolean_0 = ap_block_state1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_return_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_return_preg <= ap_const_lv16_0;
            else
                if (((ap_const_boolean_0 = ap_block_state1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_return_preg <= select_ln28_fu_36_p3;
                end if; 
            end if;
        end if;
    end process;


    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_CS_fsm_state1, ap_block_state1)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_block_state1)
    begin
        if ((ap_const_boolean_1 = ap_block_state1)) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg)
    begin
                ap_block_state1 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state1, ap_block_state1)
    begin
        if (((ap_const_boolean_0 = ap_block_state1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
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


    ap_ready_assign_proc : process(ap_CS_fsm_state1, ap_block_state1)
    begin
        if (((ap_const_boolean_0 = ap_block_state1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_return_assign_proc : process(ap_CS_fsm_state1, ap_block_state1, select_ln28_fu_36_p3, ap_return_preg)
    begin
        if (((ap_const_boolean_0 = ap_block_state1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_return <= select_ln28_fu_36_p3;
        else 
            ap_return <= ap_return_preg;
        end if; 
    end process;

    icmp_ln28_fu_18_p2 <= "1" when (unsigned(p_read) > unsigned(p_read1)) else "0";
    select_ln28_fu_36_p3 <= 
        sub_ln28_fu_24_p2 when (icmp_ln28_fu_18_p2(0) = '1') else 
        sub_ln28_1_fu_30_p2;
    sub_ln28_1_fu_30_p2 <= std_logic_vector(unsigned(p_read1) - unsigned(p_read));
    sub_ln28_fu_24_p2 <= std_logic_vector(unsigned(p_read) - unsigned(p_read1));
end behav;
