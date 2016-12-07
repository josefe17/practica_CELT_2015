-----------------------------------------------------------------
-- VISUALIZACIÓN
--
-- Este módulo se encarga de enceder cada vez uno 
-- de los displays y de enceder los segmentos correctos 
-- del display para mostrar un número o letra. La frecuencia 
-- de refresco viene marcada por la señal del contador.
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity visualizacion is
    Port ( clk : in  STD_LOGIC;                         -- entrada de reloj
           cnt_5ms : in  STD_LOGIC;                     -- entrada de contador
           Digito0 : in  STD_LOGIC_VECTOR (3 downto 0); -- dígito BCD (Unidades)
           Digito1 : in  STD_LOGIC_VECTOR (3 downto 0); -- dígito BCD (Decenas)
           Digito2 : in  STD_LOGIC_VECTOR (3 downto 0); -- dígito BCD (Centenas)
           Digito3 : in  STD_LOGIC_VECTOR (3 downto 0); -- dígito BCD (Millares)
           Disp0 : out  STD_LOGIC;                      -- Display 1 Activo a nivel bajo
           Disp1 : out  STD_LOGIC;                      -- Display 2 Activo a nivel bajo
           Disp2 : out  STD_LOGIC;                      -- Display 3 Activo a nivel bajo
           Disp3 : out  STD_LOGIC;                      -- Display 4 Activo a nivel bajo
           Seg7 : out  STD_LOGIC_VECTOR (6 downto 0));  -- segmentos del display
end visualizacion;

architecture Behavioral of visualizacion is

signal sel: STD_LOGIC_VECTOR (1 downto 0):="00";   -- señal de control de displays
signal digitoBCD: STD_LOGIC_VECTOR (3 downto 0):="0000";  -- dígito a mostrar

begin

with digitoBCD select Seg7 <=       -- se encarga de encender los segmentos correctos 
	"0000001" when "0000",      -- para mostrar el número de entrada o las letras
	"1001111" when "0001",      -- correspondientes
	"0010010" when "0010",
	"0000110" when "0011",
	"1001100" when "0100",
	"0100100" when "0101",
	"0100000" when "0110",
	"0001111" when "0111",
	"0000000" when "1000",
	"0000100" when "1001",
	"1110001" when "1010", -- L
	"0110001" when "1011", -- C
	"0110000" when "1100", -- E
	"0001111" when "1101", -- T
	"1111111" when others;

process(clk)  -- proceso de refresco de los displays
	begin
		if clk='1' and clk'event then
			if cnt_5ms='1' then
				sel <= sel + 1;
			end if;
		end if;
	end process;			

process (sel, Digito0, Digito1, Digito2, Digito3)   -- proceso que asigna un número 
	begin                                            -- a cada display
		digitoBCD <= Digito0;
		Disp0 <= '1'; Disp1 <= '1'; Disp2 <= '1'; Disp3 <= '1';
		case sel is
			when "00" => 
				Disp0 <= '0';
				Disp1 <= '1'; 
				Disp2 <= '1'; 
				Disp3 <= '1';
				digitoBCD <= Digito0;
				
			when "01" =>
				Disp0 <= '1';
				Disp1 <= '0'; 
				Disp2 <= '1'; 
				Disp3 <= '1';
				digitoBCD <= Digito1;
				
			when "10" =>
				Disp0 <= '1';
				Disp1 <= '1'; 
				Disp2 <= '0'; 
				Disp3 <= '1';
				digitoBCD <= Digito2;
				
			when "11" =>
				Disp0 <= '1';
				Disp1 <= '1'; 
				Disp2 <= '1'; 
				Disp3 <= '0';
				digitoBCD <= Digito3;
				
			when others => Disp0 <= '1'; Disp1 <= '1'; Disp2 <= '1'; Disp3 <= '1';
		END CASE;
end process;
end Behavioral;
