library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
	port (
		A, B: in std_logic_vector (7 downto 0);
		ULAop: in std_logic_vector (3 downto 0);
		Result: out std_logic_vector (7 downto 0);
		Zero: out std_logic
	);
end ULA;

architecture comportamento of ULA is
	signal Result_interno: std_logic_vector (7 downto 0); -- Sinal interno de 8 bits

begin
	process (A, B, ULAop)
	begin
		case ULAop is
			when "0000" => Result_interno <= A and B; -- AND de 8 bits
			when "0001" => Result_interno <= A or B;  -- OR de bits
			when "0010" => Result_interno <= std_logic_vector(unsigned(A) + unsigned(B)); -- Soma de 8 bits
			when "0110" => Result_interno <= std_logic_vector(unsigned(A) - unsigned(B)); -- Subtração de 8 bits
			when "0111" => 
				if unsigned(A) < unsigned(B) then 
					Result_interno <= "00000001"; -- SLT de 8 bits
				else
					Result_interno <= "00000000";
				end if;
			when "1100" => Result_interno <= not (A or B); -- NOR de 8 bits
			when others => Result_interno <= (others => '0'); -- Todos os bits em 0
		end case;
		
		-- Define sinal Zero
		if Result_interno = "00000000" then
			Zero <= '1'; -- Se result zero, ativa o sinal zero
		else
			Zero <= '0'; -- Caso contrário, desativa o sinal zero
		end if;
	end process;
	
	Result <= Result_interno; -- Atribui o resultado interno a saída
end comportamento;
