library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity htwP is
end htwP;

architecture structural of htwP is

	-- program memory
	component instMemory
		port ( addr    : in  std_logic_vector (9 downto 0);	-- rom address
				 dataOut : out std_logic_vector (19 downto 0));	-- data out
	end component;

	component ctrlUnit
	    Port ( singleStep  : in  STD_LOGIC;
				  reset       : in  STD_LOGIC;
				  clk         : in  STD_LOGIC;
				  instruction : in  STD_LOGIC_VECTOR (19 downto 0);
				  carryFlag   : in  STD_LOGIC;
				  zeroFlag    : in  STD_LOGIC;
				  nextPC      : out STD_LOGIC;
				  pcSel       : out STD_LOGIC_VECTOR (1 downto 0);
				  irWr        : out STD_LOGIC;
				  regWrSrc    : out STD_LOGIC_VECTOR (1 downto 0);
				  regWr       : out STD_LOGIC;
				  rbSel       : out STD_LOGIC;
				  abWr        : out STD_LOGIC;
				  aluSrcB     : out STD_LOGIC;
				  aluCtrl     : out STD_LOGIC_VECTOR (4 downto 0);
				  aluresWr    : out STD_LOGIC;
				  memWr       : out STD_LOGIC;
				  ioRd        : out STD_LOGIC;
				  ioWr        : out STD_LOGIC);
	end component;

	component pc	
		Port ( reset        : in  STD_LOGIC;
				 clk          : in  STD_LOGIC;
				 nextPC       : in  STD_LOGIC;
				 pcSel        : in  STD_LOGIC_VECTOR (1 downto 0);
				 displacement : in  STD_LOGIC_VECTOR (7 downto 0);
				 absoluteAddr : in  STD_LOGIC_VECTOR (9 downto 0);
				 currentAddr  : out STD_LOGIC_VECTOR (9 downto 0));
	end component;
	
	component irReg
		Port ( clk         : in  STD_LOGIC;
				 reset       : in  STD_LOGIC;
				 data_in     : in  STD_LOGIC_VECTOR (19 downto 0);
				 irWr        : in  STD_LOGIC;
				 instruction : out STD_LOGIC_VECTOR (19 downto 0));
	end component;
	
	component reg8x8
		Port(
			raAddr  : IN  std_logic_vector(2 downto 0);
			rbPort0 : IN  std_logic_vector(2 downto 0);
			rbPort1 : IN  std_logic_vector(2 downto 0);
			rbSel   : IN  std_logic;
			wrSrc   : IN  std_logic_vector(1 downto 0);
			wrPort0 : IN  std_logic_vector(7 downto 0);
			wrPort1 : IN  std_logic_vector(7 downto 0);
			wrPort2 : IN  std_logic_vector(7 downto 0);
			wrPort3 : IN  std_logic_vector(7 downto 0);
			weSel   : IN  std_logic_vector(2 downto 0);
			we      : IN  std_logic;
			clk     : IN  std_logic;
			reset   : IN  std_logic;
			ra      : OUT std_logic_vector(7 downto 0);
			rb      : OUT std_logic_vector(7 downto 0)
		);
	end component;
	
	component abRegs
		Port(
			clk          : IN  std_logic;
			reset        : IN  std_logic;
			dataIn_RegA  : IN  std_logic_vector(7 downto 0);
			dataIn_RegB  : IN  std_logic_vector(7 downto 0);
			abWr         : IN  std_logic;
			dataOut_RegA : OUT std_logic_vector(7 downto 0);
			dataOut_RegB : OUT std_logic_vector(7 downto 0)
        );
	end component;
	
	component alu_shift
		Port(
			op_a      : IN  std_logic_vector(7 downto 0);
			op_b      : IN  std_logic_vector(7 downto 0);
			const     : IN  std_logic_vector(7 downto 0);
			carry_in  : IN  std_logic;
			aluSrcB   : IN  std_logic;
			aluCtrl   : IN  std_logic_vector(3 downto 0);
			carry_out : OUT std_logic;
			zero_out  : OUT std_logic;
			alu_out   : OUT std_logic_vector(7 downto 0)
		);
	end component;

	component aluRegs
		Port(
			clk       : IN  std_logic;
			reset     : IN  std_logic;
			carryIn   : IN  std_logic;
			zeroIn    : IN  std_logic;
			dataIn    : IN  std_logic_vector(7 downto 0);
			aluRegsWr : IN  std_logic;
			carryOut  : OUT std_logic;
			zeroOut   : OUT std_logic;
			dataOut   : OUT std_logic_vector(7 downto 0)
		);
	end component;

	component ram
		Port(
			data_in  : IN  std_logic_vector(7 downto 0);
			addr     : IN  std_logic_vector(7 downto 0);
			we       : IN  std_logic;
			clk      : IN  std_logic;
			data_out : OUT std_logic_vector(7 downto 0)
		);
	end component;
	
	component clockUnit
		Port (
			mainClk 	: in   std_logic;
			resetBtn : in   std_logic;
			stepBtn 	: in   std_logic;
			rstOut 	: out  std_logic;
			stepOut 	: out  std_logic;
			clkOut 	: out  std_logic
		);
	end component;

	component ioUnit is
		port (
			clk 		: in  std_logic;
			reset 	: in  std_logic;
			ioRd 		: in  std_logic;
			ioWr 		: in  std_logic;
			dataIn	: in  std_logic_vector (7 downto 0);
			dataOut	: out std_logic_vector (7 downto 0);
			ioAddr 	: in  std_logic_vector (7 downto 0);
			swPort	: in  std_logic_vector (7 downto 0);
			ledPort	: out std_logic_vector (3 downto 0)
		);
	end component;

	-------------
	-- SIGNALS --
	-------------
	
	-- program memory
	program_addr	: std_logic_vector(9 downto 0);
	program_instr	: std_logic_vector(19 downto 0);
	
	-- global
	signal clk 				: std_logic;
	signal reset 			: std_logic;
	signal instruction	: std_logic_vector(19 downto 0);
	signal aluResout		: std_logic_vector(7 downto 0);

	-- clockUnit -> ctrlUnit
	signal singleStep : std_logic;

	-- ctrlUnit -> pc
	signal nextPC : std_logic;
	signal pcSel  : std_logic_vector(1 downto 0);
	
	-- ctrlUnit -> irReg
	signal irWr : std_logic;
	
	-- ctrlUnit -> reg8x8
	signal wrSrc	: std_logic_vector(1 downto 0);
	signal regWr 	: std_logic;
	signal rbSel 	: std_logic;
	
	-- reg8x8 -> abRegs
	signal ra : std_logic_vector(7 downto 0);
	signal rb : std_logic_vector(7 downto 0);
	
	-- ctrlUnit -> abRegs
	signal abWr : std_logic;
	
	-- abRegs -> alu_shift
	signal regA : std_logic_vector(7 downto 0);
	signal regB : std_logic_vector(7 downto 0);
	
	-- ctrlUnit -> alu_shift
	signal aluSrcB : std_logic;
	signal aluCtrl : std_logic_vector(3 downto 0);
	
	-- alu_shift -> aluRegs
	signal aluCarry 	: std_logic;
	signal aluZero 	: std_logic;
	signal aluOut		: std_logic_vector(7 downto 0);

	-- aluRegs-> alu_shift
	signal aluRegsCarryOut : std_logic;
	
	-- aluRegs -> ctrlUnit
	signal aluRegsZeroOut : std_logic;
	
	-- ctrlUnit -> aluRegs
	signal aluResWr : std_logic;
	
	-- ctrlUnit -> ram
	signal memWr : std_logic;
	
	-- ctrlUnit -> ioUnit
	signal ioWr : std_logic;
	signal ioRd : std_logic;
	
	-- io
	signal inputPort	: std_logic_vector(7 downto 0);
	signal outputPort	: std_logic_vector(7 downto 0);
	
	-- ioUnit -> regsUnit
	signal ioIn : std_logic_vector(7 downto 0);
	
	-- external -> clockUnit
	signal mainClk 	: std_logic;
	signal resetBtn 	: std_logic;
	signal stepBtn 	: std_logic;
	
begin

end structural;

