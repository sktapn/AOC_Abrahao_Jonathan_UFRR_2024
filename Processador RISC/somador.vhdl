library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity somador is
	port (
		A: in std_logic_vector (7 downto 0);
		B: in std_logic_vector (7 downto 0);
		Cin: in std_logic; -- Carry in (Operações Encadeadas)
		S: out std_logic_vector (7 downto 0); -- Saida do soma
		Cout: out std_logic -- Carry out (Estouro da soma)
	);
end somador;

architecture comportamento of somador is
	signal soma: std_logic_vector (8 downto 0); -- Sinal intermediario para carry
begin
	soma <= ('0' & A) + ('0' & B) + Cin; -- Soma dos operadores + Carry in
	S <= soma (7 downto 0); -- O resultado fica nos 8 bits menos significativos
	Cout  <= soma(8); -- O crry out é o bit mais sginificativo
end comportamento;
