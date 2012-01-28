LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
 
ENTITY aluRegs_test IS
END aluRegs_test;
 
ARCHITECTURE behavior OF aluRegs_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT aluRegs
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         carryIn : IN  std_logic;
         zeroIn : IN  std_logic;
         dataIn : IN  std_logic_vector(7 downto 0);
         aluRegsWr : IN  std_logic;
         carryOut : OUT  std_logic;
         zeroOut : OUT  std_logic;
         dataOut : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal carryIn : std_logic := '0';
   signal zeroIn : std_logic := '0';
   signal dataIn : std_logic_vector(7 downto 0) := (others => '0');
   signal aluRegsWr : std_logic := '0';

 	--Outputs
   signal carryOut : std_logic;
   signal zeroOut : std_logic;
   signal dataOut : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: aluRegs PORT MAP (
          clk => clk,
          reset => reset,
          carryIn => carryIn,
          zeroIn => zeroIn,
          dataIn => dataIn,
          aluRegsWr => aluRegsWr,
          carryOut => carryOut,
          zeroOut => zeroOut,
          dataOut => dataOut
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
   aluRegs_test: process
   begin
		reset <= '1';
		aluRegsWr <= '0';
		dataIn <= "01010110";
		zeroIn <= '0';
		carryIn <= '0';
		
		wait for clk_period;
		assert dataOut = "00000000";
		assert carryOut = '0';
		assert zeroOut = '0';
		
		wait for clk_period;
		reset <= '0';
		
		wait for clk_period;
		assert dataOut = "00000000";
		assert carryOut = '0';
		assert zeroOut = '0';
		
		wait for clk_period;
		aluRegsWr <= '1';
		
		wait for clk_period;
		assert dataOut = dataIn;
		assert carryOut = carryIn;
		assert zeroOut = zeroIn;
		
		wait for clk_period;
		zeroIn <= '1';
		
		wait for clk_period;
		assert zeroOut = zeroIn;
		
		wait for clk_period;
		carryIn <= '1';
		
		wait for clk_period;
		assert carryOut = carryIn;
		
      wait;
   end process;

END;
