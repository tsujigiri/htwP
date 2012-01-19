LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY rom_test IS
END rom_test;
 
ARCHITECTURE behavior OF rom_test IS 
 
    COMPONENT rom
    PORT(
         addr     : IN  std_logic_vector(9 downto 0);
         data_out : OUT std_logic_vector(19 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal addr : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(19 downto 0);

BEGIN
 
   uut: rom PORT MAP (
          addr => addr,
          data_out => data_out
        );

   rom_test: process
   begin		
		addr <= std_logic_vector(to_unsigned(0,10));
		wait for 5ns;
		assert data_out = X"0000F";
		
		wait for 5ns;
		addr <= std_logic_vector(to_unsigned(1,10));
		wait for 5ns;
		assert data_out = X"000F0";
		
		wait for 5ns;
		addr <= std_logic_vector(to_unsigned(2,10));
		wait for 5ns;
		assert data_out = X"00F00";
		
		wait for 5ns;
		addr <= std_logic_vector(to_unsigned(3,10));
		wait for 5ns;
		assert data_out = X"0F000";
		
		wait for 5ns;
		addr <= std_logic_vector(to_unsigned(4,10));
		wait for 5ns;
		assert data_out = X"F0000";
		
		wait for 5ns;
		addr <= std_logic_vector(to_unsigned(5,10));
		wait for 5ns;
		assert data_out = X"00000";
		
      wait;
   end process;

END;
