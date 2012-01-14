LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY pc_test IS
END pc_test;
 
ARCHITECTURE behavior OF pc_test IS 
 
    COMPONENT pc
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         nextPC : IN  std_logic;
         pcSel : IN  std_logic_vector(1 downto 0);
         displacement : IN  std_logic_vector(7 downto 0);
         absoluteAddr : IN  std_logic_vector(9 downto 0);
         currentAddr : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal nextPC : std_logic := '0';
   signal pcSel : std_logic_vector(1 downto 0) := (others => '0');
   signal displacement : std_logic_vector(7 downto 0) := (others => '0');
   signal absoluteAddr : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal currentAddr : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN
 
   uut: pc PORT MAP (
          reset => reset,
          clk => clk,
          nextPC => nextPC,
          pcSel => pcSel,
          displacement => displacement,
          absoluteAddr => absoluteAddr,
          currentAddr => currentAddr
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
  
   pc_test: process
   begin
		nextPC <= '1';
      reset <= '1';
      wait for clk_period*2;
		reset <= '0';
		
		assert currentAddr = std_logic_vector(to_unsigned(0,10));
		
		wait for clk_period;
		assert currentAddr = std_logic_vector(to_unsigned(1,10));
		wait for clk_period;
		assert currentAddr = std_logic_vector(to_unsigned(2,10));
		
		-- set absolute address
		absoluteAddr <= "1111111111";
		pcSel <= "10";
		wait for clk_period;
		assert currentAddr = std_logic_vector(to_unsigned(1023,10));
		
		pcSel <= "00";
		wait for clk_period;
		assert currentAddr = std_logic_vector(to_unsigned(0,10));
		wait for clk_period;
		
		-- displace by 10
		pcSel <= "01";
		displacement <= "00001010";
		wait for clk_period;
		assert currentAddr = std_logic_vector(to_unsigned(11,10));

		-- displace by -20
		pcSel <= "01";
		displacement <= "11101100";
		wait for clk_period;
		assert currentAddr = std_logic_vector(to_unsigned(1015,10));
		
		-- don't do anything
		nextPC <= '0';
		pcSel <= "00";
		wait for clk_period;
		assert currentAddr = std_logic_vector(to_unsigned(1015,10));
      pcSel <= "01";
		wait for clk_period;
		assert currentAddr = std_logic_vector(to_unsigned(1015,10));
      pcSel <= "10";
		wait for clk_period;
		assert currentAddr = std_logic_vector(to_unsigned(1015,10));
      
		wait;
   end process;

END;
