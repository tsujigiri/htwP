--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:41:12 01/07/2012
-- Design Name:   
-- Module Name:   /home/helge/htwP2/alu_shift_test.vhd
-- Project Name:  htwP
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu_shift
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
USE ieee.numeric_std.ALL;
 
ENTITY alu_shift_test IS
END alu_shift_test;
 
ARCHITECTURE behavior OF alu_shift_test IS 
 
    COMPONENT alu_shift
    PORT(
         op_a      : IN   std_logic_vector(7 downto 0);
         op_b      : IN   std_logic_vector(7 downto 0);
         const     : IN   std_logic_vector(7 downto 0);
         carry_in  : IN   std_logic;
         aluSrcB   : IN   std_logic;
         aluCtrl   : IN   std_logic_vector(3 downto 0);
         carry_out : OUT  std_logic;
         zero_out  : OUT  std_logic;
         alu_out   : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal op_a : std_logic_vector(7 downto 0) := (others => '0');
   signal op_b : std_logic_vector(7 downto 0) := (others => '0');
   signal const : std_logic_vector(7 downto 0) := (others => '0');
   signal carry_in : std_logic := '0';
   signal aluSrcB : std_logic := '0';
   signal aluCtrl : std_logic_vector(3 downto 0) := (others => '0');

	--Outputs
	signal carry_out : std_logic;
	signal zero_out  : std_logic;
	signal alu_out   : std_logic_vector(7 downto 0);

BEGIN
 
	uut: alu_shift PORT MAP (
		op_a      => op_a,
		op_b      => op_b,
		const     => const,
		carry_in  => carry_in,
		aluSrcB   => aluSrcB,
		aluCtrl   => aluCtrl,
		carry_out => carry_out,
		zero_out  => zero_out,
		alu_out   => alu_out
	);

	alu_shift_test: process
	begin
	
		op_a <= "01010101";
		op_b <= "00100010";
		carry_in <= '1';
	
		-- ADD
		aluCtrl <= "0000";
		wait for 5ns;
		assert alu_out = "01110111";
		assert carry_out = '0';
		assert zero_out = '0';
		wait for 5ns;

		-- ADDC
		aluCtrl <= "0001";
		wait for 5ns;
		assert alu_out = "01111000";
		assert carry_out = '0';
		assert zero_out = '0';
		wait for 5ns;

		-- SUB
		aluCtrl <= "0010";
		wait for 5ns;
		assert alu_out = "00110011";
		assert carry_out = '0';
		assert zero_out = '0';
		wait for 5ns;

		-- SUB with zero result
		aluCtrl <= "0010";
		op_b <= op_a;
		wait for 5ns;
		assert alu_out = "00000000";
		assert carry_out = '0';
		assert zero_out = '1';
		wait for 5ns;

		-- SUB with carry_out
		aluCtrl <= "0010";
		op_b <= "10101010";
		wait for 5ns;
		assert alu_out = "10101011";
		assert carry_out = '1';
		assert zero_out = '0';
		wait for 5ns;

		-- SUBC
		aluCtrl <= "0011";
		op_b <= "00100010";
		wait for 5ns;
		assert alu_out = "00110010";
		assert carry_out = '0';
		assert zero_out = '0';
		wait for 5ns;

      -- AND
		aluCtrl <= "0100";
		op_a <= "01010101";
		op_b <= "01100110";
		wait for 5ns;
		assert alu_out = "01000100";
		assert carry_out = '0';
		assert zero_out = '0';
		
		-- OR
		aluCtrl <= "0101";
		op_a <= "01010101";
		op_b <= "01100110";
		wait for 5ns;
		assert alu_out = "01110111";
		assert carry_out = '0';
		assert zero_out = '0';

		-- XOR
		aluCtrl <= "0110";
		op_a <= "01010101";
		op_b <= "01100110";
		wait for 5ns;
		assert alu_out = "00110011";
		assert carry_out = '0';
		assert zero_out = '0';

		-- CMPA (complement a)
		aluCtrl <= "0111";
		op_a <= "01010110";
		wait for 5ns;
		assert alu_out = "10101001";
		assert carry_out = '0';
		assert zero_out = '0';

		-- SRL (shift right logical)
		op_a <= "01010101";
		aluCtrl <= "1000";
		wait for 5ns;
		assert alu_out = "00101010";
		assert carry_out = '1';
		assert zero_out = '0';

		-- SLL (shift left logical)
		op_a <= "10101010";
		aluCtrl <= "1001";
		wait for 5ns;
		assert alu_out = "01010100";
		assert carry_out = '1';
		assert zero_out = '0';

		-- ROR (rotate right)
		op_a <= "01100101";
		aluCtrl <= "1010";
		wait for 5ns;
		assert alu_out = "10110010";
		assert carry_out = '0';
		assert zero_out = '0';

		-- ROL (rotate left)
		op_a <= "10100110";
		aluCtrl <= "1011";
		wait for 5ns;
		assert alu_out = "01001101";
		assert carry_out = '0';
		assert zero_out = '0';

		wait;
	end process;

END;