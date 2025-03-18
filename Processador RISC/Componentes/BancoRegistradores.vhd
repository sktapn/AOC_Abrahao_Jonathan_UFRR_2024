-- BANCO DE REGISTRADORES (Register Bank)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Biblioteca correta para operações numéricas

entity BancoRegistradores is
    Port (
        clk      : in  STD_LOGIC;                    -- Clock
        we       : in  STD_LOGIC;                    -- Sinal de escrita (Write Enable)
        raddr1   : in  STD_LOGIC_VECTOR(1 downto 0); -- Endereço do registrador 1
        raddr2   : in  STD_LOGIC_VECTOR(1 downto 0); -- Endereço do registrador 2
        waddr    : in  STD_LOGIC_VECTOR(1 downto 0); -- Endereço de escrita
        wdata    : in  STD_LOGIC_VECTOR(7 downto 0); -- Dados a serem escritos no registrador
        rdata1   : out STD_LOGIC_VECTOR(7 downto 0); -- Dados lidos do registrador 1
        rdata2   : out STD_LOGIC_VECTOR(7 downto 0); -- Dados lidos do registrador 2
        r0_out   : out STD_LOGIC_VECTOR(7 downto 0); -- Saída do registrador 0
        r1_out   : out STD_LOGIC_VECTOR(7 downto 0); -- Saída do registrador 1
        r2_out   : out STD_LOGIC_VECTOR(7 downto 0); -- Saída do registrador 2
        r3_out   : out STD_LOGIC_VECTOR(7 downto 0)  -- Saída do registrador 3
    );
end BancoRegistradores;

architecture Behavioral of BancoRegistradores is
    -- Definição do tipo de memória (array) para armazenar os 4 registradores de 8 bits
    type reg_array is array (0 to 3) of STD_LOGIC_VECTOR(7 downto 0);
    -- Sinal para armazenar os registradores
    signal regs : reg_array := (
        0 => (others => '0'),  -- Registrador 0
        1 => (others => '0'),  -- Registrador 1
        2 => (others => '0'),  -- Registrador 2
        3 => (others => '0')   -- Registrador 3
    );
begin
    -- Processamento de escrita e leitura dos registradores
    process(clk)
    begin
        if rising_edge(clk) then
            -- Se o sinal de escrita (we) for 1, escreve os dados no registrador especificado
            if we = '1' then
                regs(to_integer(unsigned(waddr))) <= wdata;
            end if;
        end if;
    end process;
    
    -- Leitura dos dados dos registradores
    rdata1 <= regs(to_integer(unsigned(raddr1)));  -- Leitura do registrador 1
    rdata2 <= regs(to_integer(unsigned(raddr2)));  -- Leitura do registrador 2

    -- Saídas específicas para os registradores
    r0_out <= regs(0);  -- Saída do registrador 0
    r1_out <= regs(1);  -- Saída do registrador 1
    r2_out <= regs(2);  -- Saída do registrador 2
    r3_out <= regs(3);  -- Saída do registrador 3
end Behavioral;
