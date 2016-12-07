---------------------------------------------------------
-- ENABLE SALIDA
--
-- Este módulo se encarga de dejar pasar la señal
-- de entrada o de convertirla en 0.
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity en_salida is
    Port ( out_in : in  STD_LOGIC_VECTOR (3 downto 0);    -- entrada de tren de pulsos
           main_out : out  STD_LOGIC_VECTOR (3 downto 0); -- salida de tren de pulsos
           enable : in  STD_LOGIC);                       -- enable de salida
end en_salida;

architecture Behavioral of en_salida is

begin

with enable select main_out <= 
	out_in when '1',        -- Si la salida está encendida deja pasar los datos
	"0000" when others;     -- Si no, cero. 
end Behavioral;