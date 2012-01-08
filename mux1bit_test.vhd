--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:19:33 01/08/2012
-- Design Name:   
-- Module Name:   /home/helge/htwP2/mux1bit_test.vhd
-- Project Name:  htwP
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux1bit
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

ENTITY mux1bit_test IS
END mux1bit_test;
 
ARCHITECTURE behavior OF mux1bit_test IS 
 
    COMPONENT mux1bit
    PORT(
         input0 : IN  std_logic;
         input1 : IN  std_logic;
         ctl : IN  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal input0 : std_logic := '0';
   signal input1 : std_logic := '0';
   signal ctl : std_logic := '0';

 	--Outputs
   signal output : std_logic;

BEGIN
 
   uut: mux1bit PORT MAP (
          input0 => input0,
          input1 => input1,
          ctl => ctl,
          output => output
        );

	mux1bit_test: process
	begin
		input0 <= '1';
		input1 <= '0';
		ctl <= '0';
		wait for 5ns;
		assert output = '1';
		ctl <= '1';
		wait for 5ns;
		assert output = '1';
		
		wait;
	end process;
END;
