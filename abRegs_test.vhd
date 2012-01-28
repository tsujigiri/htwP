LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
 
ENTITY abRegs_test IS
END abRegs_test;
 
ARCHITECTURE behavior OF abRegs_test IS 
 
    COMPONENT abRegs
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         dataIn_RegA : IN  std_logic_vector(7 downto 0);
         dataIn_RegB : IN  std_logic_vector(7 downto 0);
         abWr : IN  std_logic;
         dataOut_RegA : OUT  std_logic_vector(7 downto 0);
         dataOut_RegB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal dataIn_RegA : std_logic_vector(7 downto 0) := (others => '0');
   signal dataIn_RegB : std_logic_vector(7 downto 0) := (others => '0');
   signal abWr : std_logic := '0';

 	--Outputs
   signal dataOut_RegA : std_logic_vector(7 downto 0);
   signal dataOut_RegB : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: abRegs PORT MAP (
          clk => clk,
          reset => reset,
          dataIn_RegA => dataIn_RegA,
          dataIn_RegB => dataIn_RegB,
          abWr => abWr,
          dataOut_RegA => dataOut_RegA,
          dataOut_RegB => dataOut_RegB
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
   abRegs_test: process
   begin		
		reset <= '1';
		abWr <= '0';
		dataIn_RegA <= "01010001";
		dataIn_RegB <= "10100010";
		
		wait for clk_period;
		assert dataOut_RegA = "00000000";
		assert dataOut_RegB = "00000000";
		
		wait for clk_period;
		reset <= '0';
		
		wait for clk_period;
		assert dataOut_RegA = "00000000";
		assert dataOut_RegB = "00000000";
		
		wait for clk_period;
		abWr <= '1';
		
		wait for clk_period;
		assert dataOut_RegA = dataIn_RegA;
		assert dataOut_RegB = dataIn_RegB;
		
      wait;
   end process;

END;
