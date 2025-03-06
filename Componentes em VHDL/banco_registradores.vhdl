library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_registradores is
	port (
		clk: in std_logic;
		reg_write: in std_logic;
		read_reg1: in std_logic_vector (2 downto 0); -- Endereço do reg 1
		read_reg2: in std_logic_vector (2 downto 0); -- Endereço do reg 2
		write_reg: in std_logic_vector (2 downto 0); -- Endereço do reg para escrita
		write_data: in std_logic_vector (7 downto 0); -- Dado a ser escrito
		read_data1: out std_logic_vector (7 downto 0); -- Saída do primeiro reg
		read_data2: out std_logic_vector (7 downto 0) -- Saída do segundo reg
	);
end banco_registradores;

architecture comportamento of banco_registradores is
	type reg_array is array (0 to 7) of std_logic_vector (7 downto 0);
	signal registradores: reg_array := (others => (others => '0')); -- Para inicializar todos os registradores com 0

begin
	-- Leitura assíncrona 
	process (read_reg1, read_reg2)
	begin 
		read_data1 <= registradores(to_integer(unsigned(read_reg1)));
		read_data2 <= registradores(to_integer(unsigned(read_reg2)));
	end process;
	
	-- Escrita assíncrona
	process (clk)
	begin
		if rising_edge(clk) then
			if reg_write = '1' then
				registradores(to_integer(unsigned(write_reg))) <= write_data;
			end if;
		end if;
	end process;
end comportamento;
