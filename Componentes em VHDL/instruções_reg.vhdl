library ieee;
use ieee.std_logic_1164.all;

entity instrucoes_reg is
	port (
		clk: in std_logic;
		load: in std_logic; -- Sinal para carregar a instrução
		instrucao_in: in std_logic_vector (7 downto 0); -- Instrução da mem
		instrucao_out: out std_logic_vector (7 downto 0) -- Instrução atual
	);
end instrucoes_reg;

architecture comportamento of instrucoes_reg is
	signal instrucao_atual: std_logic_vector (7 downto 0);

begin
	process(clk)
	begin
		if rising_edge(clk) then
			if load = '1' then
				instrucao_atual <= instrucao_in; -- Carrega nova instrução
			end if;
		end if;
	end process;
	
	instrucao_out <= instrucao_atual; -- Saida da instrução atual
end comportamento;
