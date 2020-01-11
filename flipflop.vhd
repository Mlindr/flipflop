------------------------------------------------------------------------------
--revision:    11.1.2020 created project
--authors:	   Mirko Lindroth
--project: 	   flipflop.vhd
--Description: Basic flipflops
--					Select the flipflop you want to use in your top entity
--					with generics
------------------------------------------------------------------------------

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--entity
entity flipflop is
	generic(
		Tff_EN		:boolean		:=false;
		Dff_EN		:boolean		:=false;
		JKff_EN		:boolean		:=false;
		RESET_EN		:boolean		:=false
		);
	port(
		in_1		:in std_logic	:='0';
		in_2		:in std_logic	:='0';
		Q			:out std_logic	:='0';
		Qnot		:out std_logic	:='0';
		clk		:in std_logic	:='0';
		reset		:in std_logic	:='0'
		);
end flipflop;

--architecture
architecture behavior of flipflop is

--signals
signal def_o	:std_logic;
signal inv_o	:std_logic;

begin

	Q<=def_o;
	Qnot<=inv_o;
	
	--generate fliflops with reset
	RST_EN:	if RESET_EN=true generate
		Tff_rst_gen: if Tff_EN=true generate
			Tff_rst_proc: process(clk,reset)
			begin
				if(reset='0') then
					if rising_edge(clk) then
						if(in_1='1') then
							def_o<=(not def_o);
							inv_o<=(not inv_o);
						end if;
					end if;
				else
					inv_o<='1';
					def_o<='0';
				end if;
			end process;
		end generate;
		Dff_rst_gen:	if Dff_EN=true generate
			Dff_rst_proc: process(clk,reset)
			begin
				if(reset='0') then
					if rising_edge(clk) then
						def_o<=in_1;
						inv_o<=not in_1;
					end if;
				else
					inv_o<='1';
					def_o<='0';
				end if;
			end process;
		end generate;
		JKff_rst_gen: if JKff_EN=true generate
			--JK flipflop
		end generate;
	end generate;
	
	--generate fliflops without reset
	RST_DI:	if RESET_EN=false generate
		Tff_rst_gen: if Tff_EN=true generate
			toggle_proc: process(clk)
			begin
				if rising_edge(clk) then
					if(in_1='1') then
						def_o<=(not def_o);
						inv_o<=(not inv_o);
					end if;
				end if;
			end process;
		end generate;
		Dff_rst_gen:	if Dff_EN=true generate
			--D flipflop
		end generate;
		JKff_rst_gen: if JKff_EN=true generate
			--JK flipflop
		end generate;
	end generate;
end behavior;
