-------------------------------------------------
-- CONTADOR 100 MS
--
-- Este módulo es un divisor de frecuencia,
-- se encarga de reducir la frecuencia de reloj.
-------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity contador_100ms is
    Port ( clk : in STD_LOGIC;          -- entrada de reloj
	   rst_cnt : in  STD_LOGIC;     -- entrada de reset
           en_cnt : in  STD_LOGIC;      -- entrada de enable
           cnt_100ms : out  STD_LOGIC); -- salida del contador
end contador_100ms;

architecture Behavioral of contador_100ms is

signal contador : STD_LOGIC_VECTOR (22 downto 0); 
-- señal que se encarga de contar flancos de reloj, 
-- es de 23 bits porque son los bits que se necesiten 
-- para el valor máximo del contador

begin

	process (rst_cnt, clk)
	begin
		if rst_cnt='1' then
			cnt_100ms <= '0';
			contador <= (others => '0');
		elsif clk'event and clk='1' then
			cnt_100ms <= '0';
			if en_cnt='1' then
				contador <= contador + 1;
			end if;
			if (contador >= 5000000) then -- 50MHz * 100ms = 5000000 flancos de reloj
				cnt_100ms <= '1';
				contador <= (others => '0');
			end if;
		end if;		
	end process;
end Behavioral;
