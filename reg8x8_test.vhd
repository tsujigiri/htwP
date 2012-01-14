LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
 
ENTITY reg8x8_test IS
END reg8x8_test;
 
ARCHITECTURE behavior OF reg8x8_test IS 

    COMPONENT reg8x8
    PORT(
         raAddr : IN  std_logic_vector(2 downto 0);
         rbPort0 : IN  std_logic_vector(2 downto 0);
         rbPort1 : IN  std_logic_vector(2 downto 0);
         rbSel : IN  std_logic;
         wrSrc : IN  std_logic_vector(1 downto 0);
         wrPort0 : IN  std_logic_vector(7 downto 0);
         wrPort1 : IN  std_logic_vector(7 downto 0);
         wrPort2 : IN  std_logic_vector(7 downto 0);
         wrPort3 : IN  std_logic_vector(7 downto 0);
         weSel : IN  std_logic_vector(2 downto 0);
         we : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic;
         ra : OUT  std_logic_vector(7 downto 0);
         rb : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal raAddr : std_logic_vector(2 downto 0) := (others => '0');
   signal rbPort0 : std_logic_vector(2 downto 0) := (others => '0');
   signal rbPort1 : std_logic_vector(2 downto 0) := (others => '0');
   signal rbSel : std_logic := '0';
   signal wrSrc : std_logic_vector(1 downto 0) := (others => '0');
   signal wrPort0 : std_logic_vector(7 downto 0) := (others => '0');
   signal wrPort1 : std_logic_vector(7 downto 0) := (others => '0');
   signal wrPort2 : std_logic_vector(7 downto 0) := (others => '0');
   signal wrPort3 : std_logic_vector(7 downto 0) := (others => '0');
   signal weSel : std_logic_vector(2 downto 0) := (others => '0');
   signal we : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal ra : std_logic_vector(7 downto 0);
   signal rb : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg8x8 PORT MAP (
          raAddr => raAddr,
          rbPort0 => rbPort0,
          rbPort1 => rbPort1,
          rbSel => rbSel,
          wrSrc => wrSrc,
          wrPort0 => wrPort0,
          wrPort1 => wrPort1,
          wrPort2 => wrPort2,
          wrPort3 => wrPort3,
          weSel => weSel,
          we => we,
          clk => clk,
          reset => reset,
          ra => ra,
          rb => rb
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	reg8x8_test: process
	begin
		reset <= '1';
		wait for clk_period*10;
		reset <= '0';
		
		wrPort0 <= "01010000";
		wrPort1 <= "01010001";
		wrPort2 <= "01010010";
		wrPort3 <= "01010011";
		
		wrSrc <= "00";
		weSel <= "000";
		raAddr <= "000";
		
		rbPort0 <= "010";
		rbPort1 <= "001";
		rbSel   <= '0';

		wait for clk_period;

		-- write and read regBank(0)
		assert ra = "00000000";
		assert rb = "00000000";
		wait for clk_period;
		we <= '1';
		wait for clk_period;
		assert ra = wrPort0;
		assert rb = "00000000";
		wait for clk_period*2;
		
		reset <= '1';
		wait for clk_period*2;
		reset <= '0';
		
		-- write and read regBank(7)
		assert ra = "00000000";
		wait for clk_period;
		raAddr <= "111";
		wait for clk_period;
		assert ra = "00000000";
		wait for clk_period;
		weSel <= "111";
		wait for clk_period;
		we <= '1';
		wait for clk_period;
		assert ra = wrPort0;
		
		reset <= '1';
		wait for clk_period*2;
		reset <= '0';
		
		-- wrPort2 -> regBank(5) -> ra
		-- wrPort3 -> regBank(3) -> rb
		we <= '0';
		wait for clk_period;
		wrSrc <= "10";
		weSel <= "101";
		wait for clk_period;
		we <= '1';
		wait for clk_period;
		we <= '0';
		wait for clk_period;
		wrSrc <= "11";
		weSel <= "100";
		wait for clk_period;
		we <= '1';
		wait for clk_period;
		we <= '0';
		wait for clk_period;
		
		raAddr <= "101";
		rbPort1 <= "100";
		rbSel <= '1';
		wait for clk_period;
		assert ra = wrPort2;
		assert rb = wrPort3;

		wait;
	end process;

END;
