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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
  port( op_a, op_b, ops : in   STD_LOGIC_VECTOR (3 downto 0);
        status, result  : out  STD_LOGIC_VECTOR (3 downto 0));
end alu;

architecture Behavioral of alu is
  
begin

  process ( op_a, op_b, ops )
    variable carry : std_logic := '0';
	 variable zero  : std_logic := '0';
	 variable tmp   : unsigned;
  begin
 
    status <= "0000";
    carry := '0';
	 zero := '0';
 
    case ops is
	 
      when "0000" | "0001" => -- add | addc
		  tmp := unsigned(op_a) + unsigned(op_b);
	     result <= std_logic_vector(tmp);
		  if tmp > 15 then
		    carry := '1';
		  end if;
		  		  
		when "0010" | "0011" => -- sub | subc
		  result <= std_logic_vector(unsigned(op_a) - unsigned(op_b));
		  if unsigned(op_b) > unsigned(op_a) then
		    carry := '1';
		  end if;
		  
		when "0100" => -- and
		  result <= op_a and op_b;
		  
		when others => result <= "1111";
    end case;
	 
	 status(2) <= carry;
	 if tmp = 0 then
	   status(3) <= '1';
	 end if;
	 
  end process;

end Behavioral;
