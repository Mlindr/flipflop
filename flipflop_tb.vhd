------------------------------------------------------------------------------
--revision:    12.1.2020 *Created test bench file
--authors:	   Mirko Lindroth
--project: 	   flipflop_tb.vhd
--Description: testbench for flipflop.vhd
------------------------------------------------------------------------------

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--entity
entity TB is
end TB;

--architecture
architecture behavior of TB is

signal	TDK_in_sig	:std_logic	:='0';
signal	J_in_sig		:std_logic	:='0';
signal	Q_sig			:std_logic	:='0';
signal	Qnot_sig		:std_logic	:='0';
signal	clk_sig		:std_logic	:='0';
signal	reset_sig	:std_logic	:='0';


--component
component flipflop
	generic(
		Tff_EN		:boolean		:=false;
		Dff_EN		:boolean		:=false;
		JKff_EN		:boolean		:=false;
		RESET_EN		:boolean		:=false
		);
	port(
		TDK_in	:in std_logic	:='0';
		J_in		:in std_logic	:='0';
		Q			:out std_logic	:='0';
		Qnot		:out std_logic	:='0';
		clk		:in std_logic	:='0';
		reset		:in std_logic	:='0'
		);
end component;

begin

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
			Q=>Q_sig,
			Qnot=>Qnot_sig,
			clk=>clk_sig,
			reset=>reset_sig
			);
end behavior;