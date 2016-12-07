--------------------------------------------------------------
-- CONVERSOR BCD DECENAS
--
-- Este módulo se encarga de calcular el valor de las
-- decenas y por saca por la salida el número de entrada
-- sin las decenas, es decir, las unidades.
--------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity conversorBCD_dec is
 Generic (  bits_in : integer := 7;  	bits_out : integer := 4; -- bits de la seal de entrada y salida
	    level1 : integer := 10; 	level2 : integer := 20;  -- umbrales para generar el digito BCD
	    level3 : integer := 30; 	level4 : integer := 40;
	    level5 : integer := 50; 	level6 : integer := 60;
	    level7 : integer := 70; 	level8 : integer := 80;
	   level9 : integer := 90);
 Port (  data_in : in STD_LOGIC_VECTOR (bits_in-1 downto 0);    -- numero binario de entrada
	 data_out : out STD_LOGIC_VECTOR (bits_out-1 downto 0); -- numero binario de salida
	 digito : out STD_LOGIC_VECTOR (3 downto 0) );          -- digito BCD de salida
end conversorBCD_dec;

architecture behavior of conversorBCD_dec is

begin

process (data_in)

 VARIABLE resto : STD_LOGIC_VECTOR (bits_in-1 downto 0);
 
begin
 digito <= (others => '0'); resto := data_in; -- VALORES POR DEFECTO

 if data_in >= conv_std_logic_vector(level1, bits_in) then
	digito <= "0001"; resto := data_in - conv_std_logic_vector(level1, bits_in); -- resto = data_in - 1000
 end if;
 if data_in >= conv_std_logic_vector(level2, bits_in) then
	digito <= "0010"; resto := data_in - conv_std_logic_vector(level2, bits_in); -- resto = data_in - 2000
 end if;
 if data_in >= conv_std_logic_vector(level3, bits_in) then
	digito <= "0011"; resto := data_in - conv_std_logic_vector(level3, bits_in); -- resto = data_in - 3000
 end if;
 if data_in >= conv_std_logic_vector(level4, bits_in) then
	digito <= "0100"; resto := data_in - conv_std_logic_vector(level4, bits_in); -- resto = data_in - 4000
 end if;
 if data_in >= conv_std_logic_vector(level5, bits_in) then
	digito <= "0101"; resto := data_in - conv_std_logic_vector(level5, bits_in); -- resto = data_in - 5000
 end if;
 if data_in >= conv_std_logic_vector(level6, bits_in) then
	digito <= "0110"; resto := data_in - conv_std_logic_vector(level6, bits_in); -- resto = data_in - 6000
 end if;
 if data_in >= conv_std_logic_vector(level7, bits_in) then
	digito <= "0111"; resto := data_in - conv_std_logic_vector(level7, bits_in); -- resto = data_in - 7000
 end if;
 if data_in >= conv_std_logic_vector(level8, bits_in) then
	digito <= "1000"; resto := data_in - conv_std_logic_vector(level8, bits_in); -- resto = data_in - 8000
 end if;
 if data_in >= conv_std_logic_vector(level9, bits_in) then
	digito <= "1001"; resto := data_in - conv_std_logic_vector(level9, bits_in); -- resto = data_in - 9000
 end if;
 
 data_out <= resto(bits_out-1 downto 0); -- Asignacion de salida
end process;
end behavior;
