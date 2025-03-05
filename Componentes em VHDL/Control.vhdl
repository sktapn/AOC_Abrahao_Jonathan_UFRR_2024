------------------------------------------------------
-- Bloco de instruções da memória
-- 
-- Contém todas as instruções que serão executadas.
-- Inicialmente, as instruções são carregadas na memória.
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Control is
    port (
        opcode: in std_logic_vector (5 downto 0);
        reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write: out std_logic;
        alu_op: out std_logic_vector (1 downto 0)
    );
end Control;

architecture behavioral of Control is
begin
    process(opcode)
    begin
        case opcode is
            when "000000" => -- R-type
                reg_dest <= '1'; jump <= '0'; branch <= '0'; mem_read <= '0';
                mem_to_reg <= '0'; mem_write <= '0'; alu_src <= '0'; reg_write <= '1'; alu_op <= "10";
            when "001000" => -- ADDI
                reg_dest <= '0'; jump <= '0'; branch <= '0'; mem_read <= '0';
                mem_to_reg <= '0'; mem_write <= '0'; alu_src <= '1'; reg_write <= '1'; alu_op <= "00";
            when "000100" => -- BEQ
                reg_dest <= '0'; jump <= '0'; branch <= '1'; mem_read <= '0';
                mem_to_reg <= '0'; mem_write <= '0'; alu_src <= '0'; reg_write <= '0'; alu_op <= "01";
            when "000101" => -- BNE
                reg_dest <= '0'; jump <= '0'; branch <= '1'; mem_read <= '0';
                mem_to_reg <= '0'; mem_write <= '0'; alu_src <= '0'; reg_write <= '0'; alu_op <= "11";
            when "000010" => -- JUMP
                reg_dest <= '0'; jump <= '1'; branch <= '0'; mem_read <= '0';
                mem_to_reg <= '0'; mem_write <= '0'; alu_src <= '0'; reg_write <= '0'; alu_op <= "00";
            when "100011" => -- LW
                reg_dest <= '0'; jump <= '0'; branch <= '0'; mem_read <= '1';
                mem_to_reg <= '1'; mem_write <= '0'; alu_src <= '1'; reg_write <= '1'; alu_op <= "00";
            when "101011" => -- SW
                reg_dest <= '0'; jump <= '0'; branch <= '0'; mem_read <= '0';
                mem_to_reg <= '0'; mem_write <= '1'; alu_src <= '1'; reg_write <= '0'; alu_op <= "00";
            when others => -- Instrução Inválida
                reg_dest <= '0'; jump <= '0'; branch <= '0'; mem_read <= '0';
                mem_to_reg <= '0'; mem_write <= '0'; alu_src <= '0'; reg_write <= '0'; alu_op <= "00";
        end case;
    end process;
end behavioral;
