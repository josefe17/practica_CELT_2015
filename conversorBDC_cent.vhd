--------------------------------------------------------------
-- CONVERSOR BCD CENTENAS
--
-- Este módulo se encarga de calcular el valor de las
-- centenas y por saca por la salida el número de entrada
-- sin las centenas.
--------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity conversorBCD_cent is
 Generic (  bits_in : integer := 10;  	bits_out : integer := 7; -- bits de la seal de entrada y salida
	    level1 : integer := 100; 	level2 : integer := 200; -- umbrales para generar el digito BCD
	    level3 : integer := 300; 	level4 : integer := 400; -- se han elegido como umbrales los múltiplos
	    level5 : integer := 500; 	level6 : integer := 600; -- de 100 hasta 900 porque para sacar el número
	    level7 : integer := 700; 	level8 : integer := 800; -- de las centenas hay que comprobar los rangos:
	    level9 : integer := 900);                            -- [100,200), [200,300),...,[900,1000)
 Port (  data_in : in STD_LOGIC_VECTOR (bits_in-1 downto 0);      -- numero binario de entrada
	 data_out : out STD_LOGIC_VECTOR (bits_out-1 downto 0);   -- numero binario de salida
	 digito : out STD_LOGIC_VECTOR (3 downto 0) );            -- digito BCD de salida
end conversorBCD_cent;

architecture behavior of conversorBCD_cent is

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
