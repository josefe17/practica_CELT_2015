------------------------------------------------------------------------
-- REGISTRO DECENAS A UNIDADES
--
-- Este módulo se encarga de registrar el resto que sale del módulo
-- que calcula el valor de las decenas en BCD para luego pasarlo a la
-- salida como el valor de las unidades en BCD. La frecuencia de  
-- muestreo es la del reloj.
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegistroDU is
    Port ( clk : in  STD_LOGIC;                     -- entrada de reloj
           E : in  STD_LOGIC_VECTOR (3 downto 0);   -- entrada de datos
           S : out  STD_LOGIC_VECTOR (3 downto 0)); -- salida de datos
end RegistroDU;

architecture Behavioral of RegistroDU is

begin
process (clk)         -- el proceso simplemente actualiza el valor de salida
	begin         -- con el valor de entrada cada flanco de reloj
	if clk'event and clk='1' then
		S <= E;
	end if;
end process;
end Behavioral;
