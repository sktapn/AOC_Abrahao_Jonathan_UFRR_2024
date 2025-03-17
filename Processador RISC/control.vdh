library ieee;
use ieee.std_logic_1164.all;

entity unidade_controle is
	port (
		opcode: in std_logic_vector (3 downto 0); -- Opcode da isntrução
		reg_write: out std_logic; -- Sinal para escrever no banco de resgiradores
		ula_op: out std_logic_vector (2 downto 0); -- Operação da ULA
		mem_write: out std_logic; -- Sinal para escrever na memória
		mem_read: out std_logic; -- Sinal para ler na memória
		branch: out std_logic -- Sinal de desvio
	);
end unidade_controle;

architecture comportamento of unidade_controle is
begin
	process(opcode)
	begin
		case opcode is
			when "0000" => -- Load
				reg_write <= '1';
				ula_op <= "000";
				mem_write <= '0';
				mem_read <= '1';
				branch <= '0';
			when "0001" => -- Store
				reg_write <= '0';
				ula_op <= "000";
				mem_write <= '1';
				mem_read <= '0';
				branch <= '0';
			when others => -- Default
				reg_write <= '0';
				ula_op <= "000";
				mem_write <= '0';
				mem_read <= '0';
				branch <= '0';
		end case;
	end process;
end comportamento;
