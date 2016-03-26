library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity Definition
entity T2L_Cabailo_tb is 
	constant MAX_COMB: integer := 64; 
	constant DELAY: time := 10 ns; 
end entity T2L_Cabailo_tb;

architecture tb of T2L_Cabailo_tb is
	signal output: std_logic; 
	signal in_buzzer: std_logic_vector(2 downto 0); 
	signal out_buzzer: std_logic_vector(2 downto 0);
	
	--Component declaration
	component T2L_Cabailo is
		port(output: out std_logic; 
		in_buzzer: in std_logic_vector(2 downto 0);
		out_buzzer : in std_logic_vector(2 downto 0));
	end component T2L_Cabailo;
	
	begin
		
		UUT: component T2L_Cabailo port map(output, in_buzzer, out_buzzer);
		
		main: process is
			variable temp: unsigned(5 downto 0);
			variable expected_output: std_logic;
			variable error_count: integer := 0; --number of simulation errors
			
		begin
			report "Start simulation.";
			
			-- generate all possible input values, since max = 255
			for count in 0 to 127 loop
				temp := TO_UNSIGNED(count, 6);
				in_buzzer(2) <= std_logic(temp(5));
				in_buzzer(1) <= std_logic(temp(4));
				in_buzzer(0) <= std_logic(temp(3));
				out_buzzer(2) <= std_logic(temp(2));
				out_buzzer(1) <= std_logic(temp(1));
				out_buzzer(0) <= std_logic(temp(0));

				wait for DELAY;

				expected_output := ((in_buzzer(2) or in_buzzer(1) or in_buzzer(0)) and (out_buzzer(2) or out_buzzer(1) or out_buzzer(0)));
				
				assert(expected_output = output) report "Logic Error";

				if(expected_output/=output)then
					error_count:=error_count+1;
				end if;
			end loop;
			
			wait for DELAY;
			
			--report errors
			assert(error_count=0)
				report "ERROR: There were " &
					integer'image(error_count) & "errors!";
					
			-- there are no errors
			if(error_count = 0) then
				report "Simulation completed with NO errors.";
			end if;
			
			wait; -- terminate the simulation
		end process;
	end architecture tb;
				
				
				
				
				
				
				
				
				
				
				
				
				
