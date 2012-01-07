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

	-- signals: ALU
	-- inputs
	signal alu_op_a     : std_logic_vector(7 downto 0) := (others => '0');
	signal alu_op_b     : std_logic_vector(7 downto 0) := (others => '0');
	signal alu_ops      : std_logic_vector(2 downto 0) := (others => '0');
	signal alu_carry_in : std_logic := '0';
	-- outputs
	signal alu_status   : std_logic_vector(3 downto 0);
	signal alu_result   : std_logic_vector(7 downto 0);
	
	-- signals: SRU
	-- inputs
	signal sru_data_in         : std_logic_vector (7 downto 0) := (others => '0');
	signal sru_ops             : std_logic_vector (2 downto 0) := (others => '0');
	signal sru_bit_to_move     : std_logic_vector (2 downto 0) := (others => '0');
	-- outputs
	signal sru_result          : std_logic_vector (7 downto 0) := (others => '0');
	signal sru_zero, sru_carry : std_logic := '0';

begin

	alu0: alu PORT MAP (
		op_a     => alu_op_a,
		op_b     => alu_op_b,
		alu_ops  => alu_ops,
		carry_in => alu_carry_in,
		status   => alu_status,
		result   => alu_result
	);

	sru0: sru port map (
		data_in     => sru_data_in,
		sru_ops     => sru_ops,
		bit_to_move => sru_bit_to_move,
		result      => sru_result,
		zero        => sru_zero,
		carry       => sru_carry
	);
	
	alu_ops <= (aluCtrl(2), aluCtrl(1), aluCtrl(0));
	sru_ops <= (aluCtrl(2), aluCtrl(1), aluCtrl(0));
	alu_op_a <= op_a;
	alu_op_b <= op_b;
	sru_op_a <= op_a;
	sru_op_b <= op_b;
	alu_carry_in <= carry_in;
	
end rtl;
