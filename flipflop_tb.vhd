------------------------------------------------------------------------------
--revision:    12.1.2020 *Created: 	test bench file
--								 *Added: 	libraries
--												entity TB
--												architecture behavior of TB
--												flipflop component
--												instantiation of T flipflop
--
--					23.1.2020 *Added: 	clock signal generation process
--												I/O testing process
--												reset process
--												instantiation of D flipflop
--												instantiation of JK flipflop
--
--							  *Modified: I/O testing process
--							  *Tested:	simulated flipflops with reset
--
--					24.1.2020 *Tested:	simulated flipflops without reset
--
--authors:	   Mirko Lindroth
--project: 	   flipflop_tb.vhd
--Description: testbench for flipflop.vhd
------------------------------------------------------------------------------

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--entity
entity TB is
	generic(TB_RST_EN	:boolean	:=false);
end TB;

--architecture
architecture behavior of TB is

signal	TDK_in_sig		:std_logic	:='0';
signal	J_in_sig			:std_logic	:='0';

signal	T_Q				:std_logic	:='0';
signal	T_Qnot			:std_logic	:='0';

signal	D_Q				:std_logic	:='0';
signal	D_Qnot			:std_logic	:='0';

signal	JK_Q				:std_logic	:='0';
signal	JK_Qnot			:std_logic	:='0';

signal	clk				:std_logic	:='0';
signal	reset_sig		:std_logic	:='0';


--component
component flipflop
	generic(
		Tff_EN		:boolean		:=false;
		Dff_EN		:boolean		:=false;
		JKff_EN		:boolean		:=false;
		RESET_EN		:boolean		:=false
		);
	port(
		TDK_in		:in std_logic	:='0';
		J_in			:in std_logic	:='0';
		Q				:out std_logic	:='0';
		Qnot			:out std_logic	:='0';
		clk			:in std_logic	:='0';
		reset			:in std_logic	:='0'
		);
end component;


begin

	--testing flipflops with reset
	TB_RST_EN_gen: if TB_RST_EN=true generate
		--T flipflop
		Tff_rst_en_test: flipflop
			generic map(
				Tff_EN=>true,
				Dff_EN=>false,
				JKff_EN=>false,
				RESET_EN=>true
				)
			port map(
				TDK_in=>TDK_in_sig,
				J_in=>J_in_sig,
				Q=>T_Q,
				Qnot=>T_Qnot,
				clk=>clk,
				reset=>reset_sig
				);
				
		--D flipflop
		D_rst_en_test: flipflop
			generic map(
				Tff_EN=>false,
				Dff_EN=>true,
				JKff_EN=>false,
				RESET_EN=>true
				)
			port map(
				TDK_in=>TDK_in_sig,
				J_in=>J_in_sig,
				Q=>D_Q,
				Qnot=>D_Qnot,
				clk=>clk,
				reset=>reset_sig
				);
		
		--JK flipflop
		JK_rst_en_test: flipflop
			generic map(
				Tff_EN=>false,
				Dff_EN=>false,
				JKff_EN=>true,
				RESET_EN=>true
				)
			port map(
				TDK_in=>TDK_in_sig,
				J_in=>J_in_sig,
				Q=>JK_Q,
				Qnot=>JK_Qnot,
				clk=>clk,
				reset=>reset_sig
				);
	end generate;
	
	--testing flipflops without reset
	TB_RST_DIS_gen: if TB_RST_EN=false generate
		--T flipflop
		Tff_rst_dis_test: flipflop
			generic map(
				Tff_EN=>true,
				Dff_EN=>false,
				JKff_EN=>false,
				RESET_EN=>false
				)
			port map(
				TDK_in=>TDK_in_sig,
				J_in=>J_in_sig,
				Q=>T_Q,
				Qnot=>T_Qnot,
				clk=>clk,
				reset=>reset_sig
				);
				
		--D flipflop
		D_rst_dis_test: flipflop
			generic map(
				Tff_EN=>false,
				Dff_EN=>true,
				JKff_EN=>false,
				RESET_EN=>false
				)
			port map(
				TDK_in=>TDK_in_sig,
				J_in=>J_in_sig,
				Q=>D_Q,
				Qnot=>D_Qnot,
				clk=>clk,
				reset=>reset_sig
				);
		
		--JK flipflop
		JK_rst_dis_test: flipflop
			generic map(
				Tff_EN=>false,
				Dff_EN=>false,
				JKff_EN=>true,
				RESET_EN=>false
				)
			port map(
				TDK_in=>TDK_in_sig,
				J_in=>J_in_sig,
				Q=>JK_Q,
				Qnot=>JK_Qnot,
				clk=>clk,
				reset=>reset_sig
				);
	end generate;


	--clock signal generation
	clk_signal_proc: process
	begin
		if(clk='1') then	
			wait for 5 ns;
		else					
			wait for 5 ns;
		end if;
		clk<=not clk;		--invert clock signal
	end process;

	--I/O test process
	IO_rst_en_proc: process
	begin
		wait for 10 ns;
		TDK_in_sig<='1';
		J_in_sig<='1';
		
		wait for 10 ns;
		TDK_in_sig<='0';
		J_in_sig<='1';
		
		wait for 10 ns;
		TDK_in_sig<='1';
		J_in_sig<='0';
		
		wait for 10 ns;
		TDK_in_sig<='0';
		J_in_sig<='0';
	end process;
	
	--reset generation
	reset_proc: process
	begin
		wait for 25 ns;
		reset_sig<='1';
		wait for 20 ns;
		reset_sig<='0';
	end process;
	
end behavior;