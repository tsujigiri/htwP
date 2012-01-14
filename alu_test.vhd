LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY alu_test IS
END alu_test;
 
ARCHITECTURE behavior OF alu_test IS 
 
	COMPONENT alu
	PORT(
		op_a, op_b : IN  std_logic_vector(7 downto 0);
		alu_ops    : IN  std_logic_vector(2 downto 0);
		carry_in   : IN  std_logic;
		status     : OUT std_logic_vector(3 downto 0);
		result     : OUT std_logic_vector(7 downto 0)
	);
	END COMPONENT;

	--Inputs
	signal op_a     : std_logic_vector(7 downto 0) := (others => '0');
	signal op_b     : std_logic_vector(7 downto 0) := (others => '0');
	signal alu_ops  : std_logic_vector(2 downto 0) := (others => '0');
	signal carry_in : std_logic;

	--Outputs
	signal status : std_logic_vector(3 downto 0);
	signal result : std_logic_vector(7 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: alu PORT MAP (
		op_a    => op_a,
		op_b    => op_b,
		alu_ops => alu_ops,
		carry_in => carry_in,
		status  => status,
		result  => result
	);

	alu_test :process
	begin
	
		wait for 5ns;

		-- ADD should handle addition
		op_a <= "01100100"; -- 100
		op_b <= "00010100"; -- 20
		alu_ops <= "000";
		carry_in <= '0';
		wait for 5ns;
		assert result = "01111000"; -- 120
		assert status(2) = '0'; -- carry
		assert status(2) = '0'; -- zero
		wait for 5ns;

		-- ADD should handle overflow on addition
		op_a <= "01100100"; -- 100 
		op_b <= "11001000"; -- 200
		alu_ops <= "000";
		carry_in <= '0';
		wait for 5ns;
		assert result = "00101100"; -- 300
		assert status(2) = '1'; -- carry
		assert status(3) = '0'; -- zero
		wait for 5ns;

		-- ADD should ignore carry_in
		op_a <= "01100100"; -- 100
		op_b <= "00010100"; -- 20
		alu_ops <= "000";
		carry_in <= '1';
		wait for 5ns;
		assert result = "01111000"; -- 121
		assert status(2) = '0'; -- carry
		assert status(2) = '0'; -- zero
		wait for 5ns;

		-- ADDC should handle carry_in
		op_a <= "01100100"; -- 100
		op_b <= "00010100"; -- 20
		alu_ops <= "001";
		carry_in <= '1';
		wait for 5ns;
		assert result = "01111001"; -- 121
		assert status(2) = '0'; -- carry
		assert status(2) = '0'; -- zero
		wait for 5ns;

		-- SUB should handle subtraction
		op_a <= "11001000"; -- 200
		op_b <= "01100100"; -- 100 
		alu_ops <= "010"; -- sub
		carry_in <= '0';
		wait for 5ns;
		assert result = "01100100"; -- -100
		assert status(2) = '0'; -- carry
		assert status(3) = '0'; -- zero
		wait for 5ns;

		-- SUB should handle subtraction with overflow
		op_a <= "01100100"; -- 100
		op_b <= "11001000"; -- 200 
		alu_ops <= "010"; -- sub
		carry_in <= '0';
		wait for 5ns;
		assert result = "10011100"; -- -100
		assert status(2) = '1'; -- carry
		assert status(3) = '0'; -- zero
		wait for 5ns;

		-- SUB should ignore carry_in
		op_a <= "11001000"; -- 200
		op_b <= "01100100"; -- 100 
		alu_ops <= "010"; -- sub
		carry_in <= '1';
		wait for 5ns;
		assert result = "01100100"; -- -100
		assert status(2) = '0'; -- carry
		assert status(3) = '0'; -- zero
		wait for 5ns;

		-- SUBC should handle carry_in
		op_a <= "11001000"; -- 200
		op_b <= "01100100"; -- 100 
		alu_ops <= "011"; -- subc
		carry_in <= '1';
		wait for 5ns;
		assert result = "01100011"; -- -101
		assert status(2) = '0'; -- carry
		assert status(3) = '0'; -- zero
		wait for 5ns;

		-- AND
		op_a <= "01010110";
		op_b <= "01100101";
		alu_ops <= "100";
		carry_in <= '0';
		wait for 5ns;
		assert result = "01000100";
		assert status = "0000";
		wait for 5ns;
		
		-- OR
		op_a <= "01010110";
		op_b <= "01100101";
		alu_ops <= "101";
		carry_in <= '0';
		wait for 5ns;
		assert result = "01110111";
		assert status = "0000";
		wait for 5ns;

		-- XOR
		op_a <= "01010110";
		op_b <= "01100101";
		alu_ops <= "110";
		carry_in <= '0';
		wait for 5ns;
		assert result = "00110011";
		assert status = "0000";
		wait for 5ns;
		
		-- CMPA - not(op_a)
		op_a <= "01010110";
		alu_ops <= "111";
		carry_in <= '0';
		wait for 5ns;
		assert result = "10101001";
		assert status = "0000";
		wait for 5ns;
		
	wait;
	end process;
END;
