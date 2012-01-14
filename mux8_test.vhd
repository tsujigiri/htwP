LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
 
ENTITY mux8_test IS
END mux8_test;
 
ARCHITECTURE behavior OF mux8_test IS 
 
    COMPONENT mux8
    PORT(
         input0 : IN  std_logic_vector(7 downto 0);
         input1 : IN  std_logic_vector(7 downto 0);
         input2 : IN  std_logic_vector(7 downto 0);
         input3 : IN  std_logic_vector(7 downto 0);
         input4 : IN  std_logic_vector(7 downto 0);
         input5 : IN  std_logic_vector(7 downto 0);
         input6 : IN  std_logic_vector(7 downto 0);
         input7 : IN  std_logic_vector(7 downto 0);
         inputSel : IN  std_logic_vector(2 downto 0);
         output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal input0 : std_logic_vector(7 downto 0) := (others => '0');
   signal input1 : std_logic_vector(7 downto 0) := (others => '0');
   signal input2 : std_logic_vector(7 downto 0) := (others => '0');
   signal input3 : std_logic_vector(7 downto 0) := (others => '0');
   signal input4 : std_logic_vector(7 downto 0) := (others => '0');
   signal input5 : std_logic_vector(7 downto 0) := (others => '0');
   signal input6 : std_logic_vector(7 downto 0) := (others => '0');
   signal input7 : std_logic_vector(7 downto 0) := (others => '0');
   signal inputSel : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(7 downto 0);

BEGIN
 
   uut: mux8 PORT MAP (
          input0 => input0,
          input1 => input1,
          input2 => input2,
          input3 => input3,
          input4 => input4,
          input5 => input5,
          input6 => input6,
          input7 => input7,
          inputSel => inputSel,
          output => output
        );
		  
	mux8_test: process
	begin
		
		input0 <= "11111111";
		input1 <= "11101110";
		input2 <= "11011101";
		input3 <= "11001100";
		input4 <= "10111011";
		input5 <= "10101010";
		input6 <= "10011001";
		input7 <= "10001000";
		
		inputSel <= "000";
		wait for 5ns;
		assert output = input0;
		wait for 5ns;
		
		inputSel <= "001";
		wait for 5ns;
		assert output = input1;
		wait for 5ns;
		
		inputSel <= "010";
		wait for 5ns;
		assert output = input2;
		wait for 5ns;
		
		inputSel <= "011";
		wait for 5ns;
		assert output = input3;
		wait for 5ns;
		
		inputSel <= "100";
		wait for 5ns;
		assert output = input4;
		
		inputSel <= "101";
		wait for 5ns;
		assert output = input5;
		wait for 5ns;
		
		inputSel <= "110";
		wait for 5ns;
		assert output = input6;
		wait for 5ns;
		
		inputSel <= "111";
		wait for 5ns;
		assert output = input7;
		wait for 5ns;
		
		wait;
	end process;

END;
