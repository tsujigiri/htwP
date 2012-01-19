LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY ram_test IS
END ram_test;
 
ARCHITECTURE behavior OF ram_test IS 
 
    COMPONENT ram
    PORT(
         data_in  : IN  std_logic_vector(7 downto 0);
         addr     : IN  std_logic_vector(7 downto 0);
         we       : IN  std_logic;
         clk      : IN  std_logic;
         data_out : OUT std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal addr    : std_logic_vector(7 downto 0) := (others => '0');
   signal we      : std_logic := '0';
   signal clk     : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   uut: ram PORT MAP (
          data_in  => data_in,
          addr     => addr,
          we       => we,
          clk      => clk,
          data_out => data_out
        );

   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	ram_test: process
	begin		
		we <= '1';
		addr <= std_logic_vector(to_unsigned(8 * 2, 8));
		data_in <= "01010110";
		
		wait for clk_period;
		we <= '0';
		wait for clk_period;
		
		assert data_out = data_in;
		data_in <= "11110000";
		
		wait for clk_period;
		
		assert data_out = "01010110";
		wait;
	end process;

END;
