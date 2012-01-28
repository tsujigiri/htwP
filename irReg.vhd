library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity irReg is
	Port ( clk         : in  STD_LOGIC;
			 reset       : in  STD_LOGIC;
			 data_in     : in  STD_LOGIC_VECTOR (19 downto 0);
			 irWr        : in  STD_LOGIC;
			 instruction : out STD_LOGIC_VECTOR (19 downto 0));
end irReg;

architecture Behavioral of irReg is
begin
	irReg: process( clk, reset )
	begin
		if reset = '1' then
			instruction <= (others => '0');
		elsif rising_edge(clk) and irWr = '1' then
			instruction <= data_in;
		end if;
	end process;
end Behavioral;

