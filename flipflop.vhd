------------------------------------------------------------------------------
--revision:    11.1.2020 *Created project
--					12.1.2020 *Added generate and process for T flipflop with and 
--								  without reset
--								 *Added generate and process for D flipflop with reset
--								 *Finished project
--authors:	   Mirko Lindroth
--project: 	   flipflop.vhd
--Description: Basic flipflops designs.
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
		TDK_in	:in std_logic	:='0';
		J_in		:in std_logic	:='0';
		Q			:out std_logic	:='0';
		Qnot		:out std_logic	:='0';
		clk		:in std_logic	:='0';
		reset		:in std_logic	:='0'
		);
end flipflop;

--architecture
architecture behavior of flipflop is

--signals
signal Q_sig	:std_logic	:='0';
signal Qnot_sig	:std_logic	:='0';


begin
	
	--fliflops with reset
	RST_EN_gen:	if RESET_EN=true generate
		--T flip flop
		Tff_rst_gen: if Tff_EN=true generate
			Tff_rst_proc: process(clk,reset)
			begin
				if(reset='0') then
					if rising_edge(clk) then
						if(TDK_in='1') then
							Q_sig<=(not Q_sig);
							Qnot_sig<=(not Qnot_sig);
						end if;
					end if;
				else
					Qnot_sig<='1';
					Q_sig<='0';
				end if;
			end process;
		end generate;
		--D flip flop
		Dff_rst_gen:	if Dff_EN=true generate
			Dff_rst_proc: process(clk,reset)
			begin
				if(reset='0') then
					if rising_edge(clk) then
						Q_sig<=TDK_in;
						Qnot_sig<=not TDK_in;
					else
						Q_sig<=Q_sig;
						Qnot_sig<=Qnot_sig;
					end if;
				else
					Qnot_sig<='1';
					Q_sig<='0';
				end if;
			end process;
		end generate;
		--JK flip flop
		JKff_rst_gen: if JKff_EN=true generate
			JKff_rst_proc: process(clk,reset)
			begin
				if(reset='0') then
					if rising_edge(clk) then
						if(TDK_in='1') then
							if(J_in='1') then
								Qnot_sig<=not Qnot_sig;
								Q_sig<=not Q_sig;
							else
								Q_sig<='0';
								Qnot_sig<='1';
							end if;
						else
							if(J_in='1') then
								Q_sig<='1';
								Qnot_sig<='0';
							else
								Q_sig<=Q_sig;
								Qnot_sig<=Qnot_sig;
							end if;
						end if;
					else
						Q_sig<=Q_sig;
						Qnot_sig<=Qnot_sig;
					end if;
				else
					Qnot_sig<='1';
					Q_sig<='0';
				end if;
			end process;
		end generate;
	end generate;
	
	--fliflops without reset
	RST_DI_gen:	if RESET_EN=false generate
		--T flip flop
		Tff_gen: if Tff_EN=true generate
			Tff_proc: process(clk)
			begin
				if rising_edge(clk) then
					if(TDK_in='1') then
						Q_sig<=not Q_sig;
						Qnot_sig<=not Qnot_sig;
					end if;
				end if;
			end process;
		end generate;
		--D flip flop
		Dff_gen:	if Dff_EN=true generate
			Dff_proc: process(clk)
			begin
				if rising_edge(clk) then
					Q_sig<=TDK_in;
					Qnot_sig<=not TDK_in;
				else
					Q_sig<=Q_sig;
					Qnot_sig<=Qnot_sig;
				end if;
			end process;
		end generate;
		--JK flip flop
		JKff_gen: if JKff_EN=true generate
			JKff_proc: process(clk)
			begin
				if rising_edge(clk) then
					if(TDK_in='1') then
						if(J_in='1') then
							Q_sig<=not Q_sig;
							Qnot_sig<=not Qnot_sig;
						else
							Q_sig<='0';
							Qnot_sig<='1';
						end if;
					else
						if(J_in='1') then
							Q_sig<='1';
							Qnot_sig<='0';
						else
							Q_sig<=Q_sig;
							Qnot_sig<=Qnot_sig;
						end if;
					end if;
				else
					Q_sig<=Q_sig;
					Qnot_sig<=Qnot_sig;
				end if;
			end process;
		end generate;
	end generate;
	
	--set signals to ouput
	Q<=Q_sig;
	Qnot<=Qnot_sig;
	
end behavior;
