-- MEMÓRIA ROM - Armazena instruções do programa
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Biblioteca correta para operações numéricas

entity ROM is
    Port (
        addr  : in  STD_LOGIC_VECTOR(7 downto 0);  -- Endereço da instrução
        instr : out STD_LOGIC_VECTOR(7 downto 0)  -- Instrução armazenada
    );
end ROM;

architecture Behavioral of ROM is
    -- Definição da ROM com 256 posições de 8 bits
    type rom_array is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
    
    -- Programa armazenado na ROM (exemplo: Fibonacci e testes gerais)
    signal rom : rom_array := (
        -- Programa Fibonacci:
        0  => "10101001",  -- LI R1, 001  ; R1 = 1 (primeiro termo)
        1  => "10110000",  -- LI R2, 000  ; R2 = 0 (termo anterior)
        2  => "01101010",  -- SW R1, 010  ; Armazena R1 na memória, endereço = 2
        3  => "00001100",  -- ADD R1, R1, R2  ; R1 = R1 + R2 (novo termo)
        4  => "01010010",  -- LW R2, 010  ; R2 = antigo R1 (recupera valor de Mem[2])
        5  => "11100010",  -- JUMP 00010  ; Salta para instrução 2 (loop)
        6  => "00000000",  -- NOP  ; (fim do loop)

        -- Programa de Testes Gerais:
        7  => "10101101",  -- LI R1, 5
        8  => "10110010",  -- LI R2, 2
        9  => "01110011",  -- SW R2, 011
        10 => "01011011",  -- LW R3, 011
        11 => "00001110",  -- ADD R1, R3
        12 => "00101100",  -- SUB R1, R2
        13 => "10010001",  -- ADDI R2, 1
        14 => "11010000",  -- BEQ R2, 000
        15 => "10100011",  -- LI R0, 3
        16 => "11100111",  -- JUMP 00111
        17 => "00000000",  -- NOP
        
        others => "00000000"  -- Demais posições são NOP
    );

begin
    instr <= rom(to_integer(unsigned(addr)));  -- Acesso à ROM com conversão correta
end Behavioral;
