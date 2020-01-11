


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflop is
	generic(
		Tff		:integer range 0 to 1	:=0;
		Dff		:integer range 0 to 1	:=0;
		JKff		:integer range 0 to 1	:=0;
		reset_en	:integer range 0 to 1	:=0
		);
	port(
		in_1		:std_logic	:='0';
		in_2		:std_logic	:='0';
		out_1		:std_logic	:='0';
		out_2		:std_logic	:='0';
		reset		:std_logic	:='0'
		);
end flipflop

architecture behavior of flipflop is

