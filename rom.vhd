library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
	generic ( word_size : integer := 20;
				 addr_size : integer := 10);
	Port ( addr     : in  STD_LOGIC_VECTOR (addr_size-1 downto 0);
			 data_out : out  STD_LOGIC_VECTOR (word_size-1 downto 0));
end rom;

architecture Behavioral of rom is
	type rom_type is array (0 to 2**addr_size-1) of std_logic_vector (data_out'range);
	constant ROM : rom_type :=
		(X"0000F",
		 X"000F0",
		 X"00F00",
		 X"0F000",
		 X"F0000",
		 others => X"00000");
begin

	data_out <= ROM(to_integer(unsigned(addr)));

end Behavioral;

