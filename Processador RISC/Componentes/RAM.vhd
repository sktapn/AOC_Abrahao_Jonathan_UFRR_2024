library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Biblioteca correta para operações numéricas

entity RAM is
    Port (
        clk  : in  STD_LOGIC;                     -- Clock da RAM
        addr : in  STD_LOGIC_VECTOR(7 downto 0);  -- Endereço (8 bits)
        we   : in  STD_LOGIC;                     -- Sinal de escrita (Write Enable)
        din  : in  STD_LOGIC_VECTOR(7 downto 0);  -- Dado de entrada para escrita
        dout : out STD_LOGIC_VECTOR(7 downto 0)   -- Dado de saída (leitura)
    );
end RAM;

architecture Behavioral of RAM is
    -- Definição do array de memória com 256 posições de 8 bits
    type ram_array is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
    signal memory : ram_array;

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                memory(to_integer(unsigned(addr))) <= din;  -- Escrita na RAM
            end if;
            dout <= memory(to_integer(unsigned(addr)));  -- Leitura síncrona
        end if;
    end process;
end Behavioral;
