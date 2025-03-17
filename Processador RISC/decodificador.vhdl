library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decodificador is
    Port (
        instrucao : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada: Instrução de 8 bits
        opcode    : out STD_LOGIC_VECTOR(2 downto 0); -- Código da operação (3 bits)
        reg1      : out STD_LOGIC_VECTOR(1 downto 0); -- Registrador 1 (2 bits)
        reg2      : out STD_LOGIC_VECTOR(1 downto 0); -- Registrador 2 (2 bits) (para tipo R)
        destino   : out STD_LOGIC;                    -- Destino (1 bit) (para tipo R)
        imediato  : out STD_LOGIC_VECTOR(2 downto 0); -- Valor imediato (para tipo I)
        endereco  : out STD_LOGIC_VECTOR(4 downto 0)  -- Endereço (para JUMP)
    );
end decodificador;

architecture comportamento of decodificador is
    -- Sinais internos para evitar erro de leitura em saídas
    signal opcode_int   : STD_LOGIC_VECTOR(2 downto 0);
    signal reg1_int     : STD_LOGIC_VECTOR(1 downto 0);
    signal reg2_int     : STD_LOGIC_VECTOR(1 downto 0);
    signal destino_int  : STD_LOGIC;
    signal imediato_int : STD_LOGIC_VECTOR(2 downto 0);
    signal endereco_int : STD_LOGIC_VECTOR(4 downto 0);
begin
    process(instrucao)
    begin
        opcode_int   <= instrucao(7 downto 5); -- Extrai os 3 bits do opcode
        
        case opcode_int is
            when "000" =>  -- Tipo R (ADD, SUB)
                reg1_int    <= instrucao(4 downto 3);
                reg2_int    <= instrucao(2 downto 1);
                destino_int <= instrucao(0);
                imediato_int <= "000";  -- Não usado
                endereco_int <= "00000"; -- Não usado
            
            when "010" | "011" | "100" =>  -- Tipo I (LOAD, STORE, BEQ)
                reg1_int    <= instrucao(4 downto 3);
                imediato_int <= instrucao(2 downto 0);
                reg2_int    <= "00";  -- Não usado
                destino_int <= '0';  -- Não usado
                endereco_int <= "00000"; -- Não usado

            when "110" =>  -- Tipo J (JUMP)
                endereco_int <= instrucao(4 downto 0);
                reg1_int    <= "00";  -- Não usado
                reg2_int    <= "00";  -- Não usado
                destino_int <= '0';  -- Não usado
                imediato_int <= "000";  -- Não usado

            when others =>
                opcode_int   <= "000";  -- Instrução inválida
                reg1_int     <= "00";
                reg2_int     <= "00";
                destino_int  <= '0';
                imediato_int <= "000";
                endereco_int <= "00000";
        end case;
    end process;

    -- Atribuição dos sinais internos às saídas
    opcode   <= opcode_int;
    reg1     <= reg1_int;
    reg2     <= reg2_int;
    destino  <= destino_int;
    imediato <= imediato_int;
    endereco <= endereco_int;

end comportamento;
