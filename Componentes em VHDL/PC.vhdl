library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PC is
	port (
		clk: in std_logic;
		reset: in std_logic;
		load: in std_logic; -- Carregamento de um novo valor
		inc: in std_logic; -- Sinal para incrementar o PC
		novo_ender: in std_logic_vector (7 downto 0); -- Novo endereço
		ender_out: out std_logic_vector (7 downto 0) -- Endereço atual
	);
end PC;

architecture comportamento of PC is
	signal ender_atual: std_logic_vector (7 downto 0);

begin
	process(clk, reset)
	begin
		if reset = '1' then
			ender_atual <= (others => '0'); -- Reseta o PC para 0
		elsif rising_edge (clk) then
			if load = '1' then
				ender_atual <= novo_ender; -- Carrega um novo endereço
			elsif inc = '1' then
				ender_atual  <= ender_atual + 1; -- Incrimenta o PC
			end if;
		end if;
	end process;
	
	ender_out <= ender_atual;
end comportamento;
