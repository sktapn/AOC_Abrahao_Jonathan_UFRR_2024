library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ULA is
	Port ( A, B : in STD_LOGIC_VECTOR (7 downto 0);
		OP : in STD_LOGIC_VECTOR (2 downto 0);
		Result : out STD_LOGIC_VECTOR (7 downto 0);
end ULA;

architecture Comportamento of ULA is
begin
	process (A, B, OP)
	begin
		case OP is
			when "000" => Result <= A + B; -- soma
			when "001" => Result <= A - B; -- subtração
			when "010" => Result <= A and B; -- AND
			when "011" => Result <= A or B; -- OR
			when "100" => Result <= A xor B; -- XOR
			when "101" => Result <= A sll B; -- Shift Left
			when "110" => Result <= A srl B; -- Shift RIght
			when others => Result <= (others = '0');
		end case;
	end process;
end Comportamento;
