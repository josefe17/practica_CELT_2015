----------------------------------------------------------------
-- ROM
--
-- Este módulo es una memoria ROM que asigna un valor 
-- de salida en función de una dirección de entrada. 
-- La frecuencia de refresco es la del reloj.
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROM is
    Port ( clk : in  STD_LOGIC;                       -- entrada de reloj
           addr : in  STD_LOGIC_VECTOR (3 downto 0);  -- direcciones de entrada
           s : out  STD_LOGIC_VECTOR (3 downto 0));   -- señal de salida
end ROM;

architecture Behavioral of ROM is

begin

process(clk)   -- este es el proceso encargado de leer la dirección de entrada
begin          -- para asignar una salida
	if clk'event and clk = '1' then
		case addr is
			when "0000" =>
				s <= "1000";
			when "0001" =>
				s <= "1011";
			when "0010" =>
				s <= "1101";
			when "0011" =>
				s <= "1111";
			when "0100" =>
				s <= "1111";
			when "0101" =>
				s <= "1111";
			when "0110" =>
				s <= "1101";
			when "0111" =>
				s <= "1011";
			when "1000" =>
				s <= "1000";
			when "1001" =>
				s <= "0100";
			when "1010" =>
				s <= "0010";
			when "1011" =>
				s <= "0000";
			when "1100" =>
				s <= "0000";
			when "1101" =>
				s <= "0000";
			when "1110" =>
				s <= "0010";
			when "1111" =>
				s <= "0100";
			when others =>
				s <= "1111";
		end case;
	end if;
end process;
end Behavioral;

