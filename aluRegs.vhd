library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity aluRegs is
	Port (
		clk       : in  STD_LOGIC;
		reset     : in  STD_LOGIC;
		carryIn   : in  STD_LOGIC;
		zeroIn    : in  STD_LOGIC;
		dataIn    : in  STD_LOGIC_VECTOR (7 downto 0);
		aluRegsWr : in  STD_LOGIC;
		carryOut  : out STD_LOGIC;
		zeroOut   : out STD_LOGIC;
		dataOut   : out STD_LOGIC_VECTOR (7 downto 0)
	);
end aluRegs;

architecture Behavioral of aluRegs is

begin

	aluRegs: process( clk, reset )
	begin
		if reset = '1' then
			carryOut <= '0';
			zeroOut <= '0';
			dataOut <= (others => '0');
		elsif rising_edge(clk) and aluRegsWr = '1' then
			zeroOut <= zeroIn;
			carryOut <= carryIn;
			dataOut <= dataIn;
		end if;
	end process;

end Behavioral;

