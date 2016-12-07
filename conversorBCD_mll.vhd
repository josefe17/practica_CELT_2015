--------------------------------------------------------------
-- CONVERSOR BCD MILLARES
--
-- Este módulo se encarga de calcular el valor de los
-- millares y por saca por la salida el número de entrada
-- sin los millares.
--------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity conversorBCD_mll is
 Generic (  bits_in : integer := 14;  	bits_out : integer := 10; -- bits de la seal de entrada y salida
	    level1 : integer := 1000; 	level2 : integer := 2000; -- umbrales para generar el digito BCD
	    level3 : integer := 3000; 	level4 : integer := 4000;
	    level5 : integer := 5000; 	level6 : integer := 6000;
	    level7 : integer := 7000; 	level8 : integer := 8000;
	    level9 : integer := 9000);
 Port (  data_in : in STD_LOGIC_VECTOR (bits_in-1 downto 0);    -- numero binario de entrada
	 data_out : out STD_LOGIC_VECTOR (bits_out-1 downto 0); -- numero binario de salida
	 digito : out STD_LOGIC_VECTOR (3 downto 0) );          -- digito BCD de salida
end conversorBCD_mll;

architecture behavior of conversorBCD_mll is

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
