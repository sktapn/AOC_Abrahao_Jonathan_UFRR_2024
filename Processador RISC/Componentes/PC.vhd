-- PROGRAM COUNTER (PC)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        clk        : in  STD_LOGIC;                      -- Clock
        branch     : in  STD_LOGIC;                      -- Sinal de desvio condicional (BEQ)
        jump       : in  STD_LOGIC;                      -- Sinal de salto incondicional (JUMP)
        alu_result : in  STD_LOGIC_VECTOR(7 downto 0);   -- Resultado da ULA (para BEQ/JUMP)
        imm        : in  STD_LOGIC_VECTOR(2 downto 0);   -- Imediato (usado em BEQ)
        pc         : out STD_LOGIC_VECTOR(7 downto 0)    -- Valor atual do PC
    );
end Pc;

architecture Behavioral of PC is
    signal pc_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');  -- Registrador do PC
begin
    process(clk)
        variable pc_next   : unsigned(7 downto 0);  -- Próximo valor do PC
        variable imm_ext   : unsigned(7 downto 0);  -- Imediato estendido para 8 bits
    begin
        if rising_edge(clk) then
            -- Incremento padrão do PC (próxima instrução)
            pc_next := unsigned(pc_reg) + 1;

            -- Extensão do imediato para 8 bits
            imm_ext := to_unsigned(to_integer(unsigned(imm)), 8);

            -- JUMP: salto incondicional (PC recebe valor da ULA)
            if jump = '1' then
                pc_next := unsigned(alu_result);
            
            -- BEQ: desvio condicional baseado no resultado da ULA
            elsif branch = '1' and alu_result = "00000000" then
                pc_next := imm_ext;
            end if;

            -- Atualiza o PC
            pc_reg <= std_logic_vector(pc_next);
        end if;
    end process;

    -- Saída do PC
    pc <= pc_reg;
end Behavioral;
