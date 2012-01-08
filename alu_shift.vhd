----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:35:35 01/07/2012 
-- Design Name: 
-- Module Name:    alu_shift - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_shift is
    Port ( op_a      : in   STD_LOGIC_VECTOR (7 downto 0);
           op_b      : in   STD_LOGIC_VECTOR (7 downto 0);
           const     : in   STD_LOGIC_VECTOR (7 downto 0);
           carry_in  : in   STD_LOGIC;
           aluSrcB   : in   STD_LOGIC;
           aluCtrl   : in   STD_LOGIC_VECTOR (3 downto 0);
           carry_out : out  STD_LOGIC;
           zero_out  : out  STD_LOGIC;
           alu_out   : out  STD_LOGIC_VECTOR (7 downto 0));
end alu_shift;

architecture rtl of alu_shift is

	COMPONENT alu
	PORT(
		op_a, op_b : IN  std_logic_vector(7 downto 0);
		alu_ops    : IN  std_logic_vector(2 downto 0);
		carry_in   : IN  std_logic;
		status     : OUT std_logic_vector(3 downto 0);
		result     : OUT std_logic_vector(7 downto 0)
	);
	END COMPONENT;

	component sru
	port(
		data_in     : in  std_logic_vector (7 downto 0);
		sru_ops     : in  std_logic_vector (2 downto 0);
		bit_to_move : in  std_logic_vector (2 downto 0);
		result      : out std_logic_vector (7 downto 0);
		zero, carry : out std_logic
	);
	end component;
	
	COMPONENT mux
		PORT(
			input0 : IN  std_logic_vector(7 downto 0);
			input1 : IN  std_logic_vector(7 downto 0);
			output : OUT std_logic_vector(7 downto 0);
			ctl    : IN  std_logic
		);
	END COMPONENT;
    
	-- signals: MUX
	--Inputs
	signal mux0_in0 : std_logic_vector(7 downto 0) := (others => '0');
	signal mux0_in1 : std_logic_vector(7 downto 0) := (others => '0');
	signal mux0_ctl : std_logic := '0';
 	--Outputs
	signal mux0_out : std_logic_vector(7 downto 0);

	-- signals: ALU
	-- inputs
	signal alu0_op_a     : std_logic_vector(7 downto 0) := (others => '0');
	signal alu0_op_b     : std_logic_vector(7 downto 0) := (others => '0');
	signal alu0_ops      : std_logic_vector(2 downto 0) := (others => '0');
	signal alu0_carry_in : std_logic := '0';
	-- outputs
	signal alu0_status   : std_logic_vector(3 downto 0);
	signal alu0_result   : std_logic_vector(7 downto 0);
	
	-- signals: SRU
	-- inputs
	signal sru0_data_in         : std_logic_vector (7 downto 0) := (others => '0');
	signal sru0_ops             : std_logic_vector (2 downto 0) := (others => '0');
	signal sru0_bit_to_move     : std_logic_vector (2 downto 0) := (others => '0');
	-- outputs
	signal sru0_result          : std_logic_vector (7 downto 0) := (others => '0');
	signal sru0_zero, sru0_carry : std_logic := '0';

begin

	alu0: alu PORT MAP (
		op_a     => alu0_op_a,
		op_b     => alu0_op_b,
		alu_ops  => alu0_ops,
		carry_in => alu0_carry_in,
		status   => alu0_status,
		result   => alu0_result
	);

	sru0: sru port map (
		data_in     => sru0_data_in,
		sru_ops     => sru0_ops,
		bit_to_move => sru0_bit_to_move,
		result      => sru0_result,
		zero        => sru0_zero,
		carry       => sru0_carry
	);
	
	mux0: mux port map (
		input0 => mux0_in0,
		input1 => mux0_in1,
		ctl    => mux0_ctl,
		output => mux0_out
	);
	
	alu0_ops      <= (aluCtrl(2), aluCtrl(1), aluCtrl(0));
	sru0_ops      <= (aluCtrl(2), aluCtrl(1), aluCtrl(0));
	alu0_op_a     <= op_a;
	alu0_op_b     <= op_b;
	sru0_op_a     <= op_a;
	sru0_op_b     <= op_b;
	alu0_carry_in <= carry_in;
	mux0_ctl      <= aluCtrl(3);
	mux0_in0      <= alu0_result;
	mux0_in1      <= sru0_result;
	alu_out       <= mux0_out;
	
end rtl;

