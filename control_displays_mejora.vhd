---------------------------------------------------------
-- CONTROL DISPLAYS
--
-- Este módulo se encarga de mostrar en los displays 
-- de la placa la frecuencia de entrada o "TECL" en caso
-- de que esté activo el modo MIDI. La frecuencia 
-- de refresco viene dado por la señal de reloj.
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_displays is
    Port ( clk : in  STD_LOGIC;                        -- entrada de reloj
           f : in  STD_LOGIC_VECTOR (13 downto 0);     -- frecuencia de entrada
	   midi : in STD_LOGIC;                        -- enable modo midi
           Disp0 : out  STD_LOGIC;                     -- Display 1 Activo a nivel bajo
           Disp1 : out  STD_LOGIC;                     -- Display 2 Activo a nivel bajo
           Disp2 : out  STD_LOGIC;                     -- Display 3 Activo a nivel bajo
           Disp3 : out  STD_LOGIC;                     -- Display 4 Activo a nivel bajo
           Seg7 : out  STD_LOGIC_VECTOR (6 downto 0)); -- segmentos del display
end control_displays;

architecture Behavioral of control_displays is

-- Declaración de componentes
component conversorBCD is
    Port ( clk : in  STD_LOGIC;
           f : in  STD_LOGIC_VECTOR (13 downto 0);
           D0 : out  STD_LOGIC_VECTOR (3 downto 0);
           D1 : out  STD_LOGIC_VECTOR (3 downto 0);
           D2 : out  STD_LOGIC_VECTOR (3 downto 0);
           D3 : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component contador_5ms is
    Port ( clk : in  STD_LOGIC;
           cnt_5ms : out  STD_LOGIC);
end component;

component visualizacion is
    Port ( clk : in  STD_LOGIC;
           cnt_5ms : in  STD_LOGIC;
           Digito0 : in  STD_LOGIC_VECTOR (3 downto 0);
           Digito1 : in  STD_LOGIC_VECTOR (3 downto 0);
           Digito2 : in  STD_LOGIC_VECTOR (3 downto 0);
           Digito3 : in  STD_LOGIC_VECTOR (3 downto 0);
           Disp0 : out  STD_LOGIC;
           Disp1 : out  STD_LOGIC;
           Disp2 : out  STD_LOGIC;
           Disp3 : out  STD_LOGIC;
           Seg7 : out  STD_LOGIC_VECTOR (6 downto 0));
end component;

signal digito_0, digito_1, digito_2, digito_3: STD_LOGIC_VECTOR (3 downto 0); -- Dígitos BCD
signal digitoM_0, digitoM_1, digitoM_2, digitoM_3: STD_LOGIC_VECTOR (3 downto 0); -- letras 
signal cnt_5_ms: STD_LOGIC;  -- señal del contador

begin

-- Conexión de módulos
U1:conversorBCD
	port map (
		clk => clk,
		f => f,
		D0 => digito_0,  
		D1 => digito_1,
		D2 => digito_2,
		D3 => digito_3
	);
		
U2: contador_5ms
	port map (
		clk => clk,
		cnt_5ms => cnt_5_ms
	);

U3: visualizacion
	port map (
		clk => clk,
      cnt_5ms => cnt_5_ms,
		Digito0 => digito_0,
		Digito1 => digito_1,
		Digito2 => digito_2,
		Digito3 => digito_3,
      Disp0 => Disp0,
      Disp1 => Disp1,
      Disp2 => Disp2,
		Disp3 => Disp3,
      Seg7 => Seg7
	);	

with midi select digitoM_0 <=              -- esta parte se encarga de conmutar
		digito_0 when '0',         -- en la salida entre el número que entra
		"1010" when '1',           -- del conversor BCD y un código asignado 
		"1111" when others;        -- a las letras 'T', 'E', 'C' y 'L'
		
with midi select digitoM_1 <=
		digito_1 when '0',
		"1011" when '1',
		"1111" when others;
		
with midi select digitoM_2 <=
		digito_2 when '0',
		"1100" when '1',
		"1111" when others;
		
with midi select digitoM_3 <=
		digito_3 when '0',
		"1101" when '1',
		"1111" when others;
end Behavioral;
