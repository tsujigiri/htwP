----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:26:50 11/11/2011 
-- Design Name: 
-- Module Name:    sru - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity sru is
	port(
		data_in     : in  std_logic_vector (7 downto 0);
		sru_ops     : in  std_logic_vector (1 downto 0);
		bit_to_move : in  std_logic_vector (2 downto 0);
		result      : out std_logic_vector (7 downto 0);
		zero, carry : out std_logic
	);
end sru;

architecture Behavioral of sru is

begin
	process( data_in, bit_to_move, sru_ops )
	begin
		zero <= '0';
		carry <= '0';
		
		case sru_ops is
		when "00" => -- SRL (shift right logical)
		carry <= data_in(0);
		result <= std_logic_vector(shift_right(unsigned(data_in), to_integer(unsigned(bit_to_move))));

		when "01" => -- SLL (shift left logical)
		carry <= data_in(data_in'length - 1);
		result <= std_logic_vector(shift_left(unsigned(data_in), to_integer(unsigned(bit_to_move))));

		when "10" => -- ROR (rotate right)
		result <= std_logic_vector(rotate_right(unsigned(data_in), to_integer(unsigned(bit_to_move))));

		when "11" => -- ROL (rotate left)
		result <= std_logic_vector(rotate_left(unsigned(data_in), to_integer(unsigned(bit_to_move))));

		when others => result <= "11111111";
		end case;
	end process;

end Behavioral;
