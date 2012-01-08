--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:48:05 01/08/2012
-- Design Name:   
-- Module Name:   /home/helge/htwP2/mux_test.vhd
-- Project Name:  htwP
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux
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

ENTITY mux_test IS
END mux_test;
 
ARCHITECTURE behavior OF mux_test IS 
 
    COMPONENT mux
    PORT(
         input0 : IN  std_logic_vector(7 downto 0);
         input1 : IN  std_logic_vector(7 downto 0);
         output : OUT std_logic_vector(7 downto 0);
         ctl    : IN  std_logic
        );
    END COMPONENT;

   --Inputs
   signal input0 : std_logic_vector(7 downto 0) := (others => '0');
   signal input1 : std_logic_vector(7 downto 0) := (others => '0');
   signal ctl    : std_logic := '0';
 	--Outputs
   signal output : std_logic_vector(7 downto 0);

BEGIN
 
   uut: mux PORT MAP (
          input0 => input0,
          input1 => input1,
          output => output,
          ctl => ctl
        );

	mux_test :process
	begin
	
		input0 <= "10101010";
		input1 <= "01010101";
		ctl <= '0';
		wait for 5ns;
		assert output = input0;
		ctl <= '1';
		wait for 5 ns;
		assert output = input1;
		
		wait;
	end process;
END;