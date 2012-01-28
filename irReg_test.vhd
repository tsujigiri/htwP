LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
 
ENTITY irReg_test IS
END irReg_test;
 
ARCHITECTURE behavior OF irReg_test IS 
 
    COMPONENT irReg
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         data_in : IN  std_logic_vector(19 downto 0);
         irWr : IN  std_logic;
         instruction : OUT  std_logic_vector(19 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal data_in : std_logic_vector(19 downto 0) := (others => '0');
   signal irWr : std_logic := '0';

 	--Outputs
   signal instruction : std_logic_vector(19 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   uut: irReg PORT MAP (
          clk => clk,
          reset => reset,
          data_in => data_in,
          irWr => irWr,
          instruction => instruction
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   irreg_test: process
   begin		
		reset <= '1';
		irWr <= '0';
		data_in <= "01010110010101100101";
		
		wait for clk_period;
		assert instruction = "00000000000000000000";
		
		wait for clk_period;
		reset <= '0';
		
		wait for clk_period;
		assert instruction = "00000000000000000000";
		
		wait for clk_period;
		irWr <= '1';
		
		wait for clk_period;
		assert instruction = data_in;
		
      wait;
   end process;

END;
