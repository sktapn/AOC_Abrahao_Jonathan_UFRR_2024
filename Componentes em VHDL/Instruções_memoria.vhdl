---------------------------------------------------------
-- Bloco de instruções de memória

-- Contém todas as instruções que serão executadas.

-- Inicialmente, as instruções são carregadas na memória.
---------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory is
	port (
		read_address: in STD_LOGIC_VECTOR (4 downto 0);
		instruction: out STD_LOGIC_VECTOR (7 downto 0)
	);
end instruction_memory;

architecture behavioral of instruction_memory is
	type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (7 downto 0);
	signal data_mem: mem_array := (
		"01010100"; -- LD R1, 0x05
		"01011001"; -- LD R1, 0x06
		"00011011"; -- ADD R3, R1, R2
		"10011100"; -- ST R3, 0x07
		"10110100"; -- BEQ R3, R1, 0x04
		"11000000"; -- JMP 0x00
		others => "00000000"
	);
begin
	instruction <= data_mem(to_integer(unsigned(read_address)));
end behavioral;
