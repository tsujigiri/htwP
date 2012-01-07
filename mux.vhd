----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:58:56 01/07/2012 
-- Design Name: 
-- Module Name:    mux - behavioral 
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

entity mux is
    Port ( input0 : in  STD_LOGIC_VECTOR (7 downto 0);
           input1 : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0);
           ctl    : in  STD_LOGIC);
end mux;

architecture behavioral of mux is
begin

	process(input0, input1, ctl)
	begin
		if ctl = '0' then
			output <= input0;
		else
			output <= input1;
		end if;
	end process;

end behavioral;

