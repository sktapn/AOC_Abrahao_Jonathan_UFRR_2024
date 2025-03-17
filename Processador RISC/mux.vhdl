library ieee;
use ieee.std_logic_1164.all;

entity mux is
	port (
		sel : in  std_logic; -- Seleção
		in0: in std_logic_vector (7 downto 0); -- Entrada 0
		in1: in std_logic_vector (7 downto 0); -- Entrada 1
		output: out std_logic_vector (7 downto 0) -- Saída
	);
end mux;

architecture comportamento of mux is
begin
	output <= in0 when sel = '0' else in1; -- Seleciona a entrada com base na seleção
end comportamento;
