library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
    Port (
        opcode_3b : in  STD_LOGIC_VECTOR(2 downto 0);  -- Opcode de 3 bits
        we_reg    : out STD_LOGIC;  -- Controle para escrita no registrador
        we_mem    : out STD_LOGIC;  -- Controle para escrita na memória
        branch    : out STD_LOGIC;  -- Controle de salto condicional (branch)
        jump      : out STD_LOGIC;  -- Controle de salto incondicional (jump)
        alu_op    : out STD_LOGIC_VECTOR(2 downto 0)   -- Operação da ALU (baseada no opcode)
    );
end Control;

architecture Behavioral of Control is
begin
    process(opcode_3b)
    begin
        -- Inicialização dos sinais de controle (valores padrão)
        we_reg <= '0';      -- Desativa a escrita no registrador
        we_mem <= '0';      -- Desativa a escrita na memória
        branch <= '0';      -- Desativa o salto condicional
        jump   <= '0';      -- Desativa o salto incondicional
        alu_op <= opcode_3b;  -- Operação da ALU definida pelo opcode

        -- Decodificação do opcode e ativação dos controles correspondentes
        case opcode_3b is
            when "000" =>  -- ADD
                we_reg <= '1';  -- Habilita a escrita no registrador
            when "001" =>  -- SUB
                we_reg <= '1';  -- Habilita a escrita no registrador
            when "010" =>  -- LW (Load Word)
                we_reg <= '1';  -- Habilita a escrita no registrador
            when "011" =>  -- SW (Store Word)
                we_mem <= '1';  -- Habilita a escrita na memória
            when "100" =>  -- ADDI (Add Immediate)
                we_reg <= '1';  -- Habilita a escrita no registrador
            when "101" =>  -- LI (Load Immediate)
                we_reg <= '1';  -- Habilita a escrita no registrador
            when "110" =>  -- BEQ (Branch if Equal)
                branch <= '1';  -- Habilita o controle de salto condicional
            when "111" =>  -- JUMP (Jump)
                jump <= '1';  -- Habilita o controle de salto incondicional
            when others =>
                null;  -- Nenhuma operação caso o opcode não corresponda a nenhum dos casos
        end case;
    end process;
end Behavioral;
