library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
	port(
		op_a, op_b : in  STD_LOGIC_VECTOR (7 downto 0);
		alu_ops    : in  STD_LOGIC_VECTOR (2 downto 0);
		carry_in   : in  STD_LOGIC;
		status     : out STD_LOGIC_VECTOR (3 downto 0);
		result     : out STD_LOGIC_VECTOR (7 downto 0)
	);
end alu;

architecture Behavioral of alu is
  
begin
	process ( op_a, op_b, alu_ops, carry_in )
		variable carry : std_logic := '0';
		variable zero  : std_logic := '0';
		variable tmp   : unsigned(8 downto 0) := "000000000";
	begin
 
		status <= "0000";
		carry := '0';
		zero := '0';
 
		case alu_ops is
		when "000" | "001" => -- add | addc
			tmp := resize(unsigned(op_a), tmp'length) + resize(unsigned(op_b), tmp'length);
			if alu_ops(0) = '1' and carry_in = '1' then
				tmp := tmp + 1;
			end if;
			carry := tmp(result'length);
			result <= std_logic_vector(resize(tmp, result'length));

		when "010" | "011" => -- sub | subc
			tmp := resize(unsigned(op_a), tmp'length) - resize(unsigned(op_b), tmp'length);
			if alu_ops(0) = '1' and carry_in = '1' then
				tmp := tmp - 1;
			end if;
			carry := tmp(result'length);
			result <= std_logic_vector(resize(tmp, result'length));

		when "100" => -- and
			result <= op_a and op_b;

		when "101" => -- or
			result <= op_a or op_b;

		when "110" => -- xor
			result <= op_a xor op_b;

		when "111" => -- cmpa
			result <= not(op_a);

		when others => result <= "11111111";
		end case;

		status(2) <= carry;
		if tmp = 0 then
			status(3) <= '1';
		end if;
	end process;

end Behavioral;