----------------------------------------------------------------
-- CONVERSOR BCD
--
-- Este módulo se encarga de convertir un número binario
-- a BCD, es decir, separas las unidades de millar,
-- las centenas, las decenas y las unidades. La frecuencia
-- de refresco es la del reloj.
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity conversorBCD is
    Port ( clk : in  STD_LOGIC;                       -- entrada de reloj
           f : in  STD_LOGIC_VECTOR (13 downto 0);    -- frecuencia de entrada
           D0 : out  STD_LOGIC_VECTOR (3 downto 0);   -- unidades
           D1 : out  STD_LOGIC_VECTOR (3 downto 0);   -- decenas
           D2 : out  STD_LOGIC_VECTOR (3 downto 0);   -- centenas
           D3 : out  STD_LOGIC_VECTOR (3 downto 0));  -- unidades de millar
end conversorBCD;

architecture Behavioral of conversorBCD is

-- declaración de componentes
component conversorBCD_mll is
	Port ( data_in : in STD_LOGIC_VECTOR (13 downto 0);
	       data_out : out STD_LOGIC_VECTOR (9 downto 0);
	       digito : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component conversorBCD_cent is
	Port ( data_in : in STD_LOGIC_VECTOR (9 downto 0);
	       data_out : out STD_LOGIC_VECTOR (6 downto 0);
	       digito : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component conversorBCD_dec is
	Port ( data_in : in STD_LOGIC_VECTOR(6 downto 0);
			 data_out : out STD_LOGIC_VECTOR(3 downto 0);
			 digito : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component RegistroMC is
	Port ( clk : in STD_LOGIC;
	       E : in STD_LOGIC_VECTOR (9 downto 0);
	       s : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component RegistroCD is
	Port ( clk : in STD_LOGIC;
	       E : in STD_LOGIC_VECTOR (6 downto 0);
	       s : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component RegistroDU is
	Port ( clk : in STD_LOGIC;
	       E : in STD_LOGIC_VECTOR (3 downto 0);
	       s : out STD_LOGIC_VECTOR (3 downto 0));
end component;

-- señales que unen los registros con los conversores_unit
signal mr, rc : STD_LOGIC_VECTOR(9 downto 0) := "0000000000";
signal cr, rd : STD_LOGIC_VECTOR(6 downto 0) := "0000000";
signal dr : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin

-- conexión de módulos
U1 : conversorBCD_mll
	port map(
		data_in => f,
		data_out => mr,
		digito => D3);
		
R1 : RegistroMC
	port map(
		clk => clk,
		E => mr,
		S => rc);
		
U2 : conversorBCD_cent
	port map(
		data_in => rc,
		data_out => cr,
		digito => D2);
		
R2 : RegistroCD
	port map(
		clk => clk,
		E => cr,
		S => rd);
		
U3 : conversorBCD_dec
	port map(
		data_in => rd,
		data_out => dr,
		digito => D1);
		
R3 : RegistroDU
	port map(
		clk => clk,
		E => dr,
		S => D0);
end Behavioral;
