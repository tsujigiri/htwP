--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:14:43 11/25/2011
-- Design Name:   
-- Module Name:   I:/VHDL/htwP/alu_test.vhd
-- Project Name:  htwP
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY alu_test IS
END alu_test;
 
ARCHITECTURE behavior OF alu_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	COMPONENT alu
	PORT(
		op_a, op_b : IN  std_logic_vector(7 downto 0);
		alu_ops    : IN  std_logic_vector(2 downto 0);
		status     : OUT std_logic_vector(3 downto 0);
		result     : OUT std_logic_vector(7 downto 0)
	);
	END COMPONENT;

	--Inputs
	signal op_a    : std_logic_vector(7 downto 0) := (others => '0');
	signal op_b    : std_logic_vector(7 downto 0) := (others => '0');
	signal alu_ops : std_logic_vector(2 downto 0) := (others => '0');

	--Outputs
	signal status : std_logic_vector(3 downto 0);
	signal result : std_logic_vector(7 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: alu PORT MAP (
		op_a    => op_a,
		op_b    => op_b,
		alu_ops => alu_ops,
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
		wait for 5ns;
		assert result = "01111000"; -- 120
		assert status(2) = '0'; -- carry
		assert status(2) = '0'; -- zero
		wait for 5ns;

		-- ADD should handle overflow on addition
		op_a <= "01100100"; -- 100 
		op_b <= "11001000"; -- 200
		alu_ops <= "000";
		wait for 5ns;
		assert result = "00101100"; -- 300
		assert status(2) = '1'; -- carry
		assert status(3) = '0'; -- zero
		wait for 5ns;

		-- SUB should handle subtraction
		op_a <= "11001000"; -- 200
		op_b <= "01100100"; -- 100 
		alu_ops <= "010"; -- sub
		wait for 5ns;
		assert result = "01100100"; -- 100
		assert status(2) = '0'; -- carry
		assert status(3) = '0'; -- zero
		wait for 5ns;

		-- SUB should handle subtraction with overflow
		op_a <= "01100100"; -- 100
		op_b <= "11001000"; -- 200 
		alu_ops <= "010"; -- sub
		wait for 5ns;
		assert result = "10011100"; -- -100
		assert status(2) = '1'; -- carry
		assert status(3) = '0'; -- zero
		wait for 5ns;

		-- AND
		op_a <= "01010110";
		op_b <= "01100101";
		alu_ops <= "100";
		wait for 5ns;
		assert result = "01000100";
		assert status = "0000";
		wait for 5ns;
		
		-- OR
		op_a <= "01010110";
		op_b <= "01100101";
		alu_ops <= "101";
		wait for 5ns;
		assert result = "01110111";
		assert status = "0000";
		wait for 5ns;

		-- XOR
		op_a <= "01010110";
		op_b <= "01100101";
		alu_ops <= "110";
		wait for 5ns;
		assert result = "00110011";
		assert status = "0000";
		wait for 5ns;
		
		-- CMPA - not(op_a)
		op_a <= "01010110";
		alu_ops <= "111";
		wait for 5ns;
		assert result = "10101001";
		assert status = "0000";
		wait for 5ns;
		
	wait;
	end process;
END;
