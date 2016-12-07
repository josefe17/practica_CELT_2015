------------------------------------------------------------------------
-- CONTADOR
--
-- Este módulo se encarga de pasar las direcciones a la memoria ROM 
-- cada cierto tiempo. La frecuencia de refresco viene dada por el 
-- módulo Contador_comparador.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity contador is
    Port ( clk : in  STD_LOGIC;                        -- entrada de reloj
           en_count : in  STD_LOGIC;                   -- entrada de contador_comparador
           addr : out  STD_LOGIC_VECTOR (3 downto 0)); -- direcciones de salida
end contador;

architecture Behavioral of contador is

signal dir : STD_LOGIC_VECTOR (3 downto 0) := "0000";  -- señal con las direcciones de 
                                                       -- salida
begin
addr <= dir;
process (clk)                             -- este proceso suma 1 a la dirección actual para 
begin                                     -- luego pasarla a la memoria ROM. Las direcciones 
	if clk'event and clk = '1' then   -- van de 0 a 15
		if en_count = '1' then
			dir <= dir + 1;
		end if;
	end if;
end process;
end Behavioral;

