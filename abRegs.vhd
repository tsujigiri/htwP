library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity abRegs is
	Port (
		clk          : in  STD_LOGIC;
		reset        : in  STD_LOGIC;
		dataIn_RegA  : in  STD_LOGIC_VECTOR (7 downto 0);
		dataIn_RegB  : in  STD_LOGIC_VECTOR (7 downto 0);
		abWr         : in  STD_LOGIC;
		dataOut_RegA : out STD_LOGIC_VECTOR (7 downto 0);
		dataOut_RegB : out STD_LOGIC_VECTOR (7 downto 0)
	);
end abRegs;

architecture Behavioral of abRegs is
begin

	abRegs: process( clk, reset )
	begin
		if reset = '1' then
			dataOut_RegA <= (others => '0');
			dataOut_RegB <= (others => '0');
		elsif rising_edge(clk) and abWr = '1' then
			dataOut_RegA <= dataIn_RegA;
			dataOut_RegB <= dataIn_RegB;
		end if;
	end process;

end Behavioral;

