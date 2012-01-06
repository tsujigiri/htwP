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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sru is
	port(
		data_in : in std_logic_vector (3 downto 0);
		sru_ops : in std_logic_vector (2 downto 0);
		bit_to_move : in std_logic_vector (1 downto 0);
		result : out std_logic_vector (3 downto 0);
		zero, carry : out std_logic
	);
end sru;

architecture Behavioral of sru is

begin
	process( data_in, bit_to_move, sru_ops )
	begin
		zero <= '0';
		carry <= '0';
		
		case resize(unsigned(sru_ops),2) is
		when "00" => -- SRL (shift right logical)
		carry <= data_in(0);
		result <= std_logic_vector(shift_right(unsigned(data_in), to_integer(unsigned(bit_to_move))));

		when "01" => -- SLL (shift left logical)
		carry <= data_in(3);
		result <= std_logic_vector(shift_left(unsigned(data_in), to_integer(unsigned(bit_to_move))));

		when "10" => -- ROR (rotate right)
		result <= std_logic_vector(rotate_right(unsigned(data_in), to_integer(unsigned(bit_to_move))));

		when "11" => -- ROL (rotate left)
		result <= std_logic_vector(rotate_left(unsigned(data_in), to_integer(unsigned(bit_to_move))));

		when others => result <= "1111";
		end case;
	end process;

end Behavioral;
