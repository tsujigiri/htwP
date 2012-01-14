LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
 
ENTITY mux5_test IS
END mux5_test;
 
ARCHITECTURE behavior OF mux5_test IS 
 
    COMPONENT mux5
    PORT(
         input0 : IN  std_logic_vector(7 downto 0);
         input1 : IN  std_logic_vector(7 downto 0);
         input2 : IN  std_logic_vector(7 downto 0);
         input3 : IN  std_logic_vector(7 downto 0);
         input4 : IN  std_logic_vector(7 downto 0);
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
   signal inputSel : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(7 downto 0);

BEGIN
 
   uut: mux5 PORT MAP (
          input0 => input0,
          input1 => input1,
          input2 => input2,
          input3 => input3,
          input4 => input4,
          inputSel => inputSel,
          output => output
        );
		  
	mux5_test: process
	begin
		input0 <= "11101110";
		input1 <= "11011101";
		input2 <= "11001100";
		input3 <= "10111011";
		input4 <= "10101010";
		
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
		
		wait;
	end process;

END;
