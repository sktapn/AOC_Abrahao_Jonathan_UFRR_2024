library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    port (
        InputA  : in  STD_LOGIC_VECTOR(7 downto 0);
        InputB  : in  STD_LOGIC_VECTOR(7 downto 0);
        Chave   : in  STD_LOGIC;
        Output  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end MUX;

architecture Behavioral of MUX is
begin
    process (Chave, InputA, InputB)
    begin
        case Chave is
            when '0' =>
                Output <= InputA;  -- Se Chave for 0, escolhe InputA
            when '1' =>
                Output <= InputB;  -- Se Chave for 1, escolhe InputB
            when others =>
                Output <= (others => '0');  -- Caso não seja 0 ou 1, define Output como '00000000'
        end case;
    end process;
end Behavioral;
