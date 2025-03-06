library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rom is
	port (
		endereco: in std_logic_vector (7 downto 0); -- Endereço da instrução
		instrucao: out std_logic_vector (7 downto 0) -- Instrução lida
	);
end rom;

architecture comportamento of rom is
	type rom_array is array (0 to 255) of std_logic_vector (7 downto 0);
	constant rom: rom_array :=(
		0 => "00000001", -- Exemplo de instrução (load)
		1 => "00000010", -- Exemplo de instrução (add)
		others => "00000000"
	);

begin
	instrucao <= rom(conv_integer(endereco)); -- Lê a instrução no endereço especificado
end comportamento;
