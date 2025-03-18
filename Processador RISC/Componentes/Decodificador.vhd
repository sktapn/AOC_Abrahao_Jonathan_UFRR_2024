library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decodificador is
    Port (
        instr   : in  STD_LOGIC_VECTOR(7 downto 0);  -- Instrução de 8 bits
        opcode  : out STD_LOGIC_VECTOR(2 downto 0);  -- 3 bits do opcode
        rd      : out STD_LOGIC_VECTOR(1 downto 0);  -- 2 bits para o registrador de destino
        rs      : out STD_LOGIC_VECTOR(1 downto 0);  -- 2 bits para o registrador de origem
        imm     : out STD_LOGIC_VECTOR(2 downto 0);  -- 3 bits de imediato
        jump5   : out STD_LOGIC_VECTOR(4 downto 0)   -- 5 bits para o endereço de salto
    );
end Decodificador;

architecture Behavioral of Decodificador is
begin
    -- Decodificação da instrução:
    opcode  <= instr(7 downto 5);   -- Bits 7 a 5 para o opcode
    rd      <= instr(4 downto 3);   -- Bits 4 a 3 para o registrador de destino (rd)
    rs      <= instr(2 downto 1);   -- Bits 2 a 1 para o registrador de origem (rs)
    imm     <= instr(2 downto 0);   -- Bits 2 a 0 para o valor do imediato (imm)
    jump5   <= instr(4 downto 0);   -- Bits 4 a 0 para o endereço de salto (jump5)
end Behavioral;
