library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_ula is
	port (
		funct: in std_logic_vector(5 downto 0);
		ula_op: in std_logic_vector(1 downto 0);
		control_ula_fuct: outr std_logic_vector(3 downto 0);
		);
end control_ula;

architecture behavioral of ula_control is
begin
	process(funct, ula_op)
	begin
		case ula_op is
			when "00" => ula_control_fuct <= "0010"; -- ADD (LW, SW)
			when "01" => ula_control_fuct <= "0110"; -- SUB (BEQ)
			when "11" => ula_control_fuct <= "0011"; -- Special case
			when "10" => -- R-type Instructions
				case funct is
					when "100000" => ula_control_fuct <= "0010"; -- ADD
					when "100010" => ula_control_fuct <= "0110"; -- SUB
					when "100100" => ula_control_fuct <= "0000"; -- AND
					when "100101" => ula_control_fuct <= "0001"; -- OR
					when "101010" => ula_control_fuct <= "0111"; -- SLT
					when others => ula_control_fuct <= "0000"; -- Default
				end case;
			when others => ula_control_fuct <= "0000"; -- Default case
		end case;
	end process;
end behavioral;
