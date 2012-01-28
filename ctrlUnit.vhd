library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity ctrlUnit is
	Port ( singleStep  : in   STD_LOGIC;
			 reset       : in   STD_LOGIC;
			 clk         : in   STD_LOGIC;
			 instruction : in   STD_LOGIC_VECTOR (19 downto 0);
			 carryFlag   : in   STD_LOGIC;
			 zeroFlag    : in   STD_LOGIC;
			 nextPC      : out  STD_LOGIC;
			 pcSel       : out  STD_LOGIC_VECTOR (1 downto 0);
			 irWr        : out  STD_LOGIC;
			 regWrSrc    : out  STD_LOGIC_VECTOR (1 downto 0);
			 regWr       : out  STD_LOGIC;
			 rbSel       : out  STD_LOGIC;
			 abWr        : out  STD_LOGIC;
			 aluSrcB     : out  STD_LOGIC;
			 aluCtrl     : out  STD_LOGIC_VECTOR (4 downto 0);
			 aluresWr    : out  STD_LOGIC;
			 memWr       : out  STD_LOGIC;
			 ioRd        : out  STD_LOGIC;
			 ioWr        : out  STD_LOGIC);
end ctrlUnit;

architecture Behavioral of ctrlUnit is

	type ctrl_state is ( reset_state, fetch_state, decode_state,
	                     exec_state, memory_state, writeback_state );
	signal state, next_state : ctrl_state;

begin

	next_ctrl: process( OpCode, subFunc, state )
		variable int_nextPC, int_irWr, int_regWr, int_abWr       : std_logic;
		variable int_ioWr, int_ioRd                              : std_logic;
		variable int_aluSrcB, int_aluresWr, int_memWr, int_rbSel : std_logic;
		
		variable int_pcSel    : std_logic_vector(1 downto 0);
		variable int_regWrSrc : std_logic_vector(1 downto 0);
		variable int_aluCtrl  : std_logic_vector(1 downto 0);
	begin
	
		-- default values
		int_nextPC := '0';
		int_pcSel  := "00";
		int_irWr := '0';
		int_rbSel := '0';
		int_regWr := '0';
		int_regWrSrc := "11";
		int_abWr := '0';
		int_aluSrcB := '0';
		int_aluCtrl := '0' & subFunc;
		int_aluresWr := '0';
		int_memWr := '0';
		int_ioWr := '0';
		int_ioRd := '0';

		case state is
			when reset_state =>
				next_state <= fetch_state;
			when fetch_state => ;
			when decode_state => ;
			when exec_state =>;
			when memory_state => ;
			when wrietback_state =>;
		end;
	
	end process;
	
	state_reg: process(clk, reset)
	begin
		if reset = '1' then
			state <= reset_state;
		else rising_edge(clk) then
			state <= next_state;
		end if;
	end process;
	
end Behavioral;

