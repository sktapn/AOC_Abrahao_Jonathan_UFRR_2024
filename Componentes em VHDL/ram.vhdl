library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ram is
	port (
		clk: in std_logic;
		endereco: in std_logic_vector (7 downto 0); -- Endereço de memória
		data_in: in std_logic_vector (7 downto 0); -- Dado a ser escrito
		data_out: out std_logic_vector (7 downto 0); -- Dado lido
		write_en: in std_logic -- Sinal de escrita
	);
end ram;

architecture comportamento of ram is
	type ram_array is array (0 to 255) of std_logic_vector (7 downto 0);
	signal ram: ram_array := (others => (others => '0')); -- Inicializa a ram com 0s
	
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if write_en = '1' then
				ram(conv_integer(endereco)) <= data_in; -- Escreve na ram
			end if;
		end if;
	end process;
	
	data_out <= ram(conv_integer(endereco)); -- Lê na ram
end comportamento;
