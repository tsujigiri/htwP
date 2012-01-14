library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity mux8 is
    Port ( input0 : in  STD_LOGIC_VECTOR (7 downto 0);
           input1 : in  STD_LOGIC_VECTOR (7 downto 0);
           input2 : in  STD_LOGIC_VECTOR (7 downto 0);
           input3 : in  STD_LOGIC_VECTOR (7 downto 0);
           input4 : in  STD_LOGIC_VECTOR (7 downto 0);
           input5 : in  STD_LOGIC_VECTOR (7 downto 0);
           input6 : in  STD_LOGIC_VECTOR (7 downto 0);
           input7 : in  STD_LOGIC_VECTOR (7 downto 0);
           inputSel : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end mux8;

architecture Behavioral of mux8 is
begin
	process(input0, input1, input2, input3, input4,
			  input5, input6, input7, inputSel )
	begin
		case inputSel is
		when "000" => output <= input0;
		when "001" => output <= input1;
		when "010" => output <= input2;
		when "011" => output <= input3;
		when "100" => output <= input4;
		when "101" => output <= input5;
		when "110" => output <= input6;
		when "111" => output <= input7;
		when others => output <= "11111111";
		end case;
	end process;
end Behavioral;

