library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
	generic ( word_size : integer := 8;
				 addr_size : integer := 8);

	Port ( data_in  : in  STD_LOGIC_VECTOR (word_size-1 downto 0);
			 addr     : in  STD_LOGIC_VECTOR (addr_size-1 downto 0);
			 we       : in  STD_LOGIC;
			 clk      : in  STD_LOGIC;
			 data_out : out STD_LOGIC_VECTOR (word_size-1 downto 0));
end ram;

architecture Behavioral of ram is
	type ram_type is array (2**addr_size-1 downto 0) of std_logic_vector (word_size-1 downto 0);
	signal RAM : ram_type;
begin

	process( clk )
	begin
		if rising_edge(clk) then
			if we = '1' then
				RAM(to_integer(unsigned(addr))) <= data_in;
			end if;
		end if;
	end process;
	
	data_out <= RAM(to_integer(unsigned(addr)));

end Behavioral;

