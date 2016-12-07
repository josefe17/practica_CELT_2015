---------------------------------------------------------
-- CONTROL DISPLAYS
--
-- Este módulo se encarga de mostrar en los displays 
-- de la placa la frecuencia de entrada. La frecuencia 
-- de refresco viene dado por la señal de reloj.
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_displays is
    Port ( clk : in  STD_LOGIC;                        -- entrada de reloj
           f : in  STD_LOGIC_VECTOR (13 downto 0);     -- frecuencia de entrada
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
end Behavioral;

