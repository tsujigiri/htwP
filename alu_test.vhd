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
		op_a   : IN  std_logic_vector(3 downto 0);
		op_b   : IN  std_logic_vector(3 downto 0);
		opc    : IN  std_logic_vector(3 downto 0);
		status : OUT std_logic_vector(3 downto 0);
		result : OUT std_logic_vector(3 downto 0);
		debug  : OUT std_logic_vector(3 downto 0)
	);
	END COMPONENT;


	--Inputs
	signal op_a : std_logic_vector(3 downto 0) := (others => '0');
	signal op_b : std_logic_vector(3 downto 0) := (others => '0');
	signal opc : std_logic_vector(3 downto 0) := (others => '0');

	--Outputs
	signal status : std_logic_vector(3 downto 0);
	signal result : std_logic_vector(3 downto 0);
	signal debug  : std_logic_vector(3 downto 0);
	-- No clocks detected in port list. Replace <clock> below with 
	-- appropriate port name 
	
BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: alu PORT MAP (
		op_a => op_a,
		op_b => op_b,
		opc => opc,
		status => status,
		result => result,
		debug  => debug
	);

	alu_test :process
	begin
	
		wait for 5ns;

		-- ADD should handle addition
		op_a <= "0101"; -- 5
		op_b <= "0110"; -- 6
		opc <= "0000";
		wait for 5ns;
		assert result = "1011"; -- 11
		assert status(2) = '0'; -- carry
		assert status(2) = '0'; -- zero
		wait for 5ns;

		-- ADD should handle overflow on addition
		op_a <= "1001"; -- 9 
		op_a <= "1000"; -- 8
		opc <= "0000";
		wait for 5ns;
		assert result = "0010"; -- 2
		assert status(2) = '1'; -- carry
		assert status(2) = '0'; -- zero

	wait;
	end process;
END;

