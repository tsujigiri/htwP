library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           nextPC : in  STD_LOGIC;
           pcSel : in  STD_LOGIC_VECTOR (1 downto 0);
           displacement : in  STD_LOGIC_VECTOR (7 downto 0);
           absoluteAddr : in  STD_LOGIC_VECTOR (9 downto 0);
           currentAddr : out  STD_LOGIC_VECTOR (9 downto 0));
end pc;

architecture Behavioral of pc is
	signal counter : signed(9 downto 0) := (others => '0');
begin

	pc: process( clk )
	begin
		if rising_edge(clk) then
			if nextPC = '1' then
				currentAddr <= std_logic_vector(counter);
			end if;
		else
			if reset = '1' then
				counter <= (others => '0');
			elsif pcSel(1) = '1' then
				counter <= signed(absoluteAddr);
			elsif pcSel(0) = '0' then
				counter <= counter + 1;
			else
				counter <= counter + resize(signed(displacement), 10);
			end if;
		end if;
	end process;

end Behavioral;
