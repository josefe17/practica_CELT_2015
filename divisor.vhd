---------------------------------------------------------------------
-- DIVISOR
--
-- Este módulo se encarga de calcular cuantos flancos de reloj
-- deben de pasar para completar delta de t, siendo delta de t
-- el resultado de dividir entre 16 el inverso de la frecuencia
-- de entrada. La frecuencia de refresco es la del reloj.
---------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity divisor is
    Port ( clk : in  STD_LOGIC;                             -- entrada de reloj
           f : in  STD_LOGIC_VECTOR (13 downto 0);          -- frecuencia de entrada
           N_count : out  STD_LOGIC_VECTOR (31 downto 0));  -- número de flancos de reloj
end divisor;
-- El valor N_count se hace máximo cuando la frecuencia es 1[Hz], en ese caso cada delta de t
-- dura 1/16[s], como la frecuencia de reloj es de 50[MHz] => T = 20[ns], entoces delta de t
-- entre T da el número de flancos de reloj => N_count(max) = 3.125.000
-- Haciendo el logaritmo en base 2 de 3.125.000 calculamos el número mínimo de bits necesarios
-- para representar N_count, que son 22 bits.
-- El valor de la connstante 'c' declarada más abajo se calcula como c = f*N_count, sabemos
-- que cuando f = 1, N_count = 3.125.000; entonces c = 3.125.000

architecture Behavioral of divisor is

-- Factor de conversión
constant c: STD_LOGIC_VECTOR(63 downto 0) := "0000000000000000000000000000000000000000001011111010111100001000";
-- Señal con los flancos de reloj
signal count : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";	
	
begin

N_count <= count;

operaciones : process (clk)
	-- Declaración de variables:
	-- divisor: frecuencia de entrada
	-- resto_H: bits más significativos del resto de la división
	-- resto_L: bits menos significativos del resto de la división
	-- cociente: cociente de la división, es decir, los flancos de reloj
	variable divisor, resto_H, resto_L, cociente: STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
	-- resto: resto de la división
	variable resto : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
	variable fin : STD_LOGIC := '1'; -- se activa cada vez que el contador llega a 31
	variable contador: STD_LOGIC_VECTOR (5 downto 0):="000000"; -- señal de contador
	-- PasoR y PasoC: señales auxiliares para hacer rotaciones
	variable pasoR : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
	variable pasoC : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
	
	-- Todas las variables y las señales declaradas antes tienen más bits de los necesarios 
	-- para que no se pierda información en las rotaciones
	
	begin
		if clk'event and clk = '1' then
			if fin = '1' then  -- reinicia las variables cada vez que el contador llega a 31
			                   -- la primera vez siempre entra porque el valor por defecto de
			                   -- fin es '1'
				divisor := ext(f,32);     -- se actualiza con el valor de la frecuencia de entrada
				resto := c;               -- se actualiza con la constance 'c'
				cociente := ext("00",32); -- se reinicia a '0'
				contador := "000000";     -- se reinicia a '0'
				fin := '0';               -- se actualiza a '0'
			end if;
			if contador >= 31 then  -- entra cuando el contador llega a 31
				fin := '1';                   -- se actualiza a '1'
				count <= shl(cociente,"01");  -- pasamos el valor del conciente a la salida, la
			else				      -- última rotación se hace por motivos de diseño del código
				pasoR := resto;                   -- rotamos el resto una posición a la izquierda
				resto := shl(pasoR,"01");         -- con ayuda de una señal auxiliar.
				resto_H := resto (63 downto 32);  -- asociamos los bitas más y menos significativos
				resto_L := resto (31 downto 0);   -- a sus respectivas variables.
				pasoC := cociente;                -- rotamos el cociente una posición a la izquierda
				cociente := shl(pasoC,"01");      -- con ayuda de una señal auxiliar.
				if (resto_H - divisor >= 0) then   -- entra cuando el valor de los bits más significativos
				                                   -- del resto es mayor o igual al divisor
					resto_H := resto_H - divisor;  -- los bits más significativos del resto se actualizan con
								       -- el valor de la diferencia entre estos y el divisor
					cociente := cociente + 1;      -- se suma uno al cociente
					resto := resto_H & resto_L;    -- se actualiza el resto con su nuevo valor
				end if;	
				contador := contador + 1;    -- se actualiza el contador
			end if;			
		end if;
end process;
end Behavioral;
