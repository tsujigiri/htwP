--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:51:22 01/06/2012
-- Design Name:   
-- Module Name:   /home/helge/htwP2/sru_test.vhd
-- Project Name:  htwP
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sru
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
 
ENTITY sru_test IS
END sru_test;
 
ARCHITECTURE behavior OF sru_test IS 

    COMPONENT sru
    PORT(
         data_in     : IN  std_logic_vector(7 downto 0);
         sru_ops     : IN  std_logic_vector(1 downto 0);
         bit_to_move : IN  std_logic_vector(2 downto 0);
         result      : OUT std_logic_vector(7 downto 0);
         zero        : OUT std_logic;
         carry       : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal data_in     : std_logic_vector(7 downto 0) := (others => '0');
   signal sru_ops     : std_logic_vector(1 downto 0) := (others => '0');
   signal bit_to_move : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(7 downto 0);
   signal zero   : std_logic;
   signal carry  : std_logic;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sru PORT MAP (
          data_in => data_in,
          sru_ops => sru_ops,
          bit_to_move => bit_to_move,
          result => result,
          zero => zero,
          carry => carry
        );

	sru_test :process
   begin
		wait for 5ns;

		-- SRL should shift right
		data_in <= "10101010";
		sru_ops <= "00";
		bit_to_move <= "001";
		wait for 5ns;
		assert result = "01010101";
		assert carry = '0';
		wait for 5ns;
		
		-- SRL should shift right with carry out
		data_in <= "01010101";
		sru_ops <= "00";
		bit_to_move <= "001";
		wait for 5ns;
		assert result = "00101010";
		assert carry = '1';
		wait for 5ns;
		
		-- SLL should shift left
		data_in <= "01010101";
		sru_ops <= "01";
		bit_to_move <= "001";
		wait for 5ns;
		assert result = "10101010";
		assert carry = '0';
		wait for 5ns;
		
		-- SLL should shift left with carry out
		data_in <= "10101010";
		sru_ops <= "01";
		bit_to_move <= "001";
		wait for 5ns;
		assert result = "01010100";
		assert carry = '1';
		wait for 5ns;
		
		-- ROR should rotate right
		data_in <= "01010001";
		sru_ops <= "10";
		bit_to_move <= "001";
		wait for 5ns;
		assert result = "10101000";
		assert carry = '0';
		wait for 5ns;
		
		-- ROL should rotate left
		data_in <= "10101000";
		sru_ops <= "11";
		bit_to_move <= "001";
		wait for 5ns;
		assert result = "01010001";
		assert carry = '0';
		wait for 5ns;

		wait;
	end process;
END;

