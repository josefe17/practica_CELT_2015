-----------------------------------------------------------------------
-- GENERACIÓN DE SALIDAS
--
-- Este módulo se encarga de generar una sinusoide analógica con la 
-- frecuencia de entrada. La frecuencia de refresco es la del reloj.
-----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gen_salidas is
    Port ( clk : in  STD_LOGIC;                      -- entrada de reloj
           f : in  STD_LOGIC_VECTOR (13 downto 0);   -- frecuencia de entrada
           s : out  STD_LOGIC_VECTOR (3 downto 0));  -- señal de salida
end gen_salidas;

architecture Behavioral of gen_salidas is

-- Declaración de componentes
component ROM is
    Port ( clk : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0));
end component;


component Contador_comparador is
    Port ( clk : in  STD_LOGIC;
           N_count : in  STD_LOGIC_VECTOR (31 downto 0);
           en_count : out  STD_LOGIC);
end component;


component contador is
    Port ( clk : in  STD_LOGIC;
           en_count : in  STD_LOGIC;
           addr : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component divisor is
    Port ( clk : in  STD_LOGIC;
           f : in  STD_LOGIC_VECTOR (13 downto 0);
           N_count : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal dire : STD_LOGIC_VECTOR (3 downto 0);        -- dirección para la ROM
signal cont : STD_LOGIC;                            -- enable del contador
signal N_contador : STD_LOGIC_VECTOR (31 downto 0); -- número de flancos de 
                                                    -- reloj que se deben contar
begin

-- Conexión de módulos
U1 : Contador_comparador
	Port Map (
		clk => clk,
		N_count => N_contador,
		en_count => cont
	);
	
U2 : contador
	Port Map (
		clk => clk,
		en_count => cont,
		addr => dire
	);
	
U3 : Rom
	Port Map (
		clk => clk,
		addr => dire,
		s => s
	);
	
U4 : divisor
	Port Map (
		clk => clk,
		f => f,
		N_count => N_contador
	);	
end Behavioral;