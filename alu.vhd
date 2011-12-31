----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:01 11/11/2011 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
	port( op_a, op_b, opc : in   STD_LOGIC_VECTOR (3 downto 0);
		  status, result  : out  STD_LOGIC_VECTOR (3 downto 0));
end alu;

architecture Behavioral of alu is
  
begin

	process ( op_a, op_b, opc )
		variable carry : std_logic := '0';
		variable zero  : std_logic := '0';
		variable tmp   : unsigned (3 downto 0);
	begin
 
		status <= "0000";
		carry := '0';
		zero := '0';
		
		case opc is
			
			when "0000" | "0001" => -- ADD | ADDC
				tmp := unsigned(op_a) + unsigned(op_b);
				result <= std_logic_vector(tmp);
				if tmp > 15 then
					carry := '1';
				end if;

			when "0010" | "0011" => -- SUB | SUBC
				result <= std_logic_vector(unsigned(op_a) - unsigned(op_b));
				if unsigned(op_b) > unsigned(op_a) then
					carry := '1';
				end if;

			when "0100" => -- AND
				result <= op_a and op_b;

			when "0101" => -- OR
				result <= op_a or op_b;

			when "0110" => -- XOR
				result <= op_a xor op_b;

			when "0111" => -- CMPA
				result <= not(op_a);

			when others => result <= "1111";
		end case;

		status(2) <= carry;
		if tmp = 0 then
			status(3) <= '1';
		end if;

	end process;

end Behavioral;

