library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg8x8 is
    Port ( raAddr : in  STD_LOGIC_VECTOR (2 downto 0);
           rbPort0 : in  STD_LOGIC_VECTOR (2 downto 0);
           rbPort1 : in  STD_LOGIC_VECTOR (2 downto 0);
           rbSel : in  STD_LOGIC;
           wrSrc : in  STD_LOGIC_VECTOR (1 downto 0);
           wrPort0 : in  STD_LOGIC_VECTOR (7 downto 0);
           wrPort1 : in  STD_LOGIC_VECTOR (7 downto 0);
           wrPort2 : in  STD_LOGIC_VECTOR (7 downto 0);
           wrPort3 : in  STD_LOGIC_VECTOR (7 downto 0);
           weSel : in  STD_LOGIC_VECTOR (2 downto 0);
           we : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ra : out  STD_LOGIC_VECTOR (7 downto 0);
           rb : out  STD_LOGIC_VECTOR (7 downto 0));
end reg8x8;

architecture Behavioral of reg8x8 is

	-- register bank
	type r_array is array (integer range 0 to 7) of std_logic_vector(7 downto 0);
	signal regBank : r_array;
	
	signal dataIn : std_logic_vector(7 downto 0);
	signal rbAddr : std_logic_vector(2 downto 0);
	
begin

	rbAddr <= rbPort0 when rbSel = '0'
		  else rbPort1 when rbSel = '1';
	dataIn <= wrPort0 when wrSrc = "00"
		  else wrPort1 when wrSrc = "01"
		  else wrPort2 when wrSrc = "10"
		  else wrPort3 when wrSrc = "11"
		  else "11111111";

	ra <= regBank(to_integer(unsigned(raAddr)));
	rb <= regBank(to_integer(unsigned(rbAddr)));

	write: process(reset, clk)
	begin
		
		if reset = '1' then
			regBank(0) <= "00000000";
			regBank(1) <= "00000000";
			regBank(2) <= "00000000";
			regBank(3) <= "00000000";
			regBank(4) <= "00000000";
			regBank(5) <= "00000000";
			regBank(6) <= "00000000";
			regBank(7) <= "00000000";
		elsif we = '1' and rising_edge(clk) then
			regBank(to_integer(unsigned(weSel))) <= dataIn;
		end if;
	end process;
	
end Behavioral;

