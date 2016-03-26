library IEEE; use IEEE.std_logic_1164.all;

-- Entity Definition
entity T2L_Cabailo is
	port(output: out std_logic;
	in_buzzer: in std_logic_vector(2 downto 0);
	out_buzzer: in std_logic_vector(2 downto 0));
end entity T2L_Cabailo; 

-- Architecture Definition
architecture priority of T2L_Cabailo is
begin
	process(in_buzzer(2), in_buzzer(1), in_buzzer(0), out_buzzer(2), out_buzzer(1), out_buzzer(0)) is
	begin
		if(((in_buzzer(2)='1') or (in_buzzer(1)='1') or (in_buzzer(0)='1')) and ((out_buzzer(2)='1') or (out_buzzer(1)='1') or (out_buzzer(0)='1')))
			then output <= '1';
		else
			output <= '0';
		end if;
	end process;
end architecture priority;
