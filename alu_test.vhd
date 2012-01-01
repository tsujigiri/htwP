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
USE ieee.numeric_std.ALL;
 
ENTITY alu_test IS
  port( expected : out STD_LOGIC_VECTOR (3 downto 0));
END alu_test;
 
ARCHITECTURE behavior OF alu_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         op_a : IN  std_logic_vector(3 downto 0);
         op_b : IN  std_logic_vector(3 downto 0);
         ops : IN  std_logic_vector(3 downto 0);
         status : OUT  std_logic_vector(3 downto 0);
         result : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op_a : std_logic_vector(3 downto 0) := (others => '0');
   signal op_b : std_logic_vector(3 downto 0) := (others => '0');
   signal ops : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal status : std_logic_vector(3 downto 0);
   signal result : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          op_a => op_a,
          op_b => op_b,
          ops => ops,
          status => status,
          result => result
        );

   alu_test :process
	begin
	  
	  for i in 0 to 15 loop
	    op_a <= std_logic_vector(to_unsigned(i,4));
	    for j in 0 to 15 loop
		   op_b <= std_logic_vector(to_unsigned(j,4));
			
			ops <= "0000";
			wait for 5ns;
			assert result = std_logic_vector(to_unsigned(i+j,4));
			if i + j <= 15 then
				wait for 5ns;
				assert status(2) = '0'; -- c
				wait for 5ns;
				assert status(3) = '0'; -- z
			elsif i + j > 15 then
				wait for 5ns;
				assert status(2) = '1'; -- c
				wait for 5ns;
				assert status(3) = '0'; -- z
			end if;
			
			
			wait for 5ns;
			--case i + j > 15 is
	      --  when true =>
	      --    assert status(2) = '1';
	      --  when false =>
	      --    assert status(2) = '0';
	      --end case;
			--wait for 5ns;
			
			
		 end loop;
	  end loop;
	  
	  wait;
	end process;
	
END;
