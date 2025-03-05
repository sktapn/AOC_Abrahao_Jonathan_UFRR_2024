library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ULA is
    Port (
        A, B : in STD_LOGIC_VECTOR (7 downto 0);
        OP : in STD_LOGIC_VECTOR (2 downto 0);
        Result : out STD_LOGIC_VECTOR (7 downto 0)
    );
end ULA;

architecture Comportamento of ULA is
begin
    process (A, B, OP)
    begin
        case OP is
            when "000" => Result <= std_logic_vector(unsigned(A) + unsigned(B)); -- Soma
            when "001" => Result <= std_logic_vector(unsigned(A) - unsigned(B)); -- Subtração
            when "010" => Result <= A and B; -- AND
            when "011" => Result <= A or B; -- OR
            when "100" => Result <= A xor B; -- XOR
            when "101" => Result <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B(2 downto 0))))); -- Shift Left
            when "110" => Result <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B(2 downto 0))))); -- Shift Right
            when others => Result <= (others => '0'); -- Default: Zera a saída
        end case;
    end process;
end Comportamento;
