-------------------------------------------------
-- CONTADOR 5 MS
--
-- Este módulo es un divisor de frecuencia,
-- se encarga de reducir la frecuencia de reloj.
-------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity contador_5ms is
    Port ( clk : in  STD_LOGIC;       -- entrada de reloj	 				
           cnt_5ms : out  STD_LOGIC); -- salida del contador
end contador_5ms;

architecture Behavioral of contador_5ms is

signal contador : STD_LOGIC_VECTOR (17 downto 0):="000000000000000000"; -- señal que se encarga
signal cnt : STD_LOGIC := '0'; -- señal de salida                          de contar los flancos      
                                                                        -- de reloj.
begin		
	cnt_5ms <= cnt;
	process (clk)		
	begin		
		if clk'event and clk='1' then	
			cnt <= '0';
			contador <= contador + 1;			
			if (contador >= 250000) then -- valor maximo de la cuenta
				cnt <= '1';
				contador <= (others => '0');
			end if;	
		end if;
	end process;
end Behavioral;