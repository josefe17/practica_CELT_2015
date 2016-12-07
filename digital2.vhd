-----------------------------------------------------------
-- DIGITAL 2
--
-- Este es el módulo TOP, es el encargado de mostrar
-- por los displays los números correctos y de generar
-- la señal de salida en función de los pulsadores y
-- switches. La frecuencia de refresco es la de reloj.
-----------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity digital2 is
    Port ( clk : in  STD_LOGIC;                       -- entrada de reloj
           Rst : in  STD_LOGIC;                       -- señal de reset
           Up0 : in  STD_LOGIC;                       -- pulsador 1
           Up1 : in  STD_LOGIC;                       -- pulsador 2
           Down0 : in  STD_LOGIC;                     -- pulsador 3
           Down1 : in  STD_LOGIC;                     -- pulsador 4
           Disp0 : out  STD_LOGIC;                    -- display 1
           Disp1 : out  STD_LOGIC;                    -- display 2
           Disp2 : out  STD_LOGIC;                    -- display 3
           Disp3 : out  STD_LOGIC;                    -- display 4
           Seg7 : out  STD_LOGIC_VECTOR (6 downto 0); -- segmentos del display
	   s : out STD_LOGIC_VECTOR (3 downto 0));    -- señal analógica de salida
end digital2;

architecture Behavioral of digital2 is

-- declaración de componentes
component control_displays is
	Port (  clk : in  STD_LOGIC;
                f : in  STD_LOGIC_VECTOR (13 downto 0);
                Disp0 : out  STD_LOGIC;
                Disp1 : out  STD_LOGIC;
                Disp2 : out  STD_LOGIC;
                Disp3 : out  STD_LOGIC;
                Seg7 : out  STD_LOGIC_VECTOR (6 downto 0));
end component;

component control_pulsadores is 
	Port (  clk : in  STD_LOGIC;
                Rst : in  STD_LOGIC;
                Up0 : in  STD_LOGIC;
                Down0 : in  STD_LOGIC;
                Up1 : in  STD_LOGIC;
                Down1 : in  STD_LOGIC;
                f : out  STD_LOGIC_VECTOR (13 downto 0));
end component;		

component gen_salidas is
    Port ( clk : in  STD_LOGIC;
           f : in  STD_LOGIC_VECTOR (13 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal freq: STD_LOGIC_VECTOR(13 downto 0);  -- señal de frecuencia
	
begin

-- conexión de componentes
U1: control_pulsadores
	port map( 
		clk => clk,
		Rst => Rst,
		Up0 => Up0,
		Down0 => Down0,
		Up1 => Up1,
		Down1 => Down1,
		f => freq
	);
	
U2: control_displays
	port map(
		clk => clk,
                f => freq,
		Disp0 => Disp0,
		Disp1 => Disp1,
		Disp2 => Disp2,
		Disp3 => Disp3,
		Seg7 => Seg7
	);
	
U3: gen_salidas
	port map(
		clk => clk,
		f => freq,
		s => s
	);
end Behavioral;
