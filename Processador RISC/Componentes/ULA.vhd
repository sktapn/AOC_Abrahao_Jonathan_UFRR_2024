-- UNIDADE LÓGICA E ARITMÉTICA (ULA)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ULA is
    Port (
        op     : in  STD_LOGIC_VECTOR(2 downto 0);  -- Código da operação
        a, b   : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operandos
        result : out STD_LOGIC_VECTOR(7 downto 0)   -- Resultado da operação
    );
end ULA;

architecture Behavioral of ULA is
begin
    process(op, a, b)
    begin
        case op is
            when "000" =>  -- ADD: Soma de A e B
                result <= a + b;
                
            when "001" =>  -- SUB: Subtração de A e B
                result <= a - b;
                
            when "010" | "011" =>  -- LW / SW: Apenas passa o valor de B (usado para endereçamento)
                result <= b;
                
            when "100" =>  -- ADDI: Soma imediata (A + B)
                result <= a + b;
                
            when "101" =>  -- LI: Carrega um valor imediato (B)
                result <= b;
                
            when "110" =>  -- BEQ: Verifica igualdade (A - B)
                result <= a - b;
                
            when "111" =>  -- JUMP: Retorna endereço destino (B)
                result <= b;
                
            when others =>  -- Caso padrão: Retorna zero
                result <= (others => '0');
        end case;
    end process;
end Behavioral;
