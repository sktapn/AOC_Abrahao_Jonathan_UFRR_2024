library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ULA_control is
	port (
		funct: in std_logic_vector(5 downto 0);
		ula_op: in std_logic_vector(1 downto 0);
		control_ula_fuct: out std_logic_vector(3 downto 0)
	);
end ULA_control;

architecture behavioral of ULA_control is
begin
	process(funct, ula_op)
	begin
		case ula_op is
			when "00" => control_ula_fuct <= "0010"; -- ADD (LW, SW)
			when "01" => control_ula_fuct <= "0110"; -- SUB (BEQ)
			when "11" => control_ula_fuct <= "0011"; -- Special case
			when "10" => -- R-type Instructions
				case funct is
					when "100000" => control_ula_fuct <= "0010"; -- ADD
					when "100010" => control_ula_fuct <= "0110"; -- SUB
					when "100100" => control_ula_fuct <= "0000"; -- AND
					when "100101" => control_ula_fuct <= "0001"; -- OR
					when "101010" => control_ula_fuct <= "0111"; -- SLT
					when others => control_ula_fuct <= "0000"; -- Default
				end case;
			when others => control_ula_fuct <= "0000"; -- Default case
		end case;
	end process;
end behavioral;
