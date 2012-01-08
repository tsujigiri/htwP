----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:16:47 01/08/2012 
-- Design Name: 
-- Module Name:    mux1bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux1bit is
    Port ( input0 : in   STD_LOGIC;
           input1 : in   STD_LOGIC;
           ctl    : in   STD_LOGIC;
           output : out  STD_LOGIC);
end mux1bit;

architecture Behavioral of mux1bit is

begin
	process( input0, input1, ctl )
	begin
		if ctl = '0' then
			output <= input0;
		else
			output <= input1;
		end if;
	end process;
end Behavioral;