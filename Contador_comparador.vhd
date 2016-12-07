-----------------------------------------------------------
-- CONTADOR COMPARADOR
--
-- Este módulo es un divisor de frecuencia. Se encarga 
-- de reducir la frecuencia del reloj en función de un 
-- valor de entrada.
-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Contador_comparador is
    Port ( clk : in  STD_LOGIC;                           -- entrada de reloj
           N_count : in  STD_LOGIC_VECTOR (31 downto 0);  -- número de flancos de reloj
           en_count : out  STD_LOGIC);                    -- salida del contador
end Contador_comparador;

architecture Behavioral of Contador_comparador is

signal contador : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000"; -- señal que se encarga
signal count : STD_LOGIC := '0';  -- señal de salida                                       de contar los flancos

begin
en_count <= count;
process (clk)
begin
	if clk'event and clk = '1' then
		count <= '0';
		contador <= contador + 1;
		if contador >= N_count - 1 then 
			count <= '1';
			contador <= ext("00",32);
		end if;		
	end if;
end process;	
end Behavioral;

