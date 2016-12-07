-----------------------------------------
-- CONTROL PULSADORES
--
-- Este módulo se encarga de fijar la 
-- frecuencia en función de los 
-- pulsadores que se activen. La 
-- frecuencia de refresco viene 
-- dada por la señal de reloj CLK.
-----------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_pulsadores is
    Port ( clk : in  STD_LOGIC;                       -- entrada de reloj
           Rst : in  STD_LOGIC;                       -- entrada de reset
           Up0 : in  STD_LOGIC;                       -- pulsador 1
           Down0 : in  STD_LOGIC;                     -- pulsador 2
           Up1 : in  STD_LOGIC;                       -- pulsador 3
           Down1 : in  STD_LOGIC;                     -- pulsador 4
           f : out  STD_LOGIC_VECTOR (13 downto 0));  -- frecuencia de salida
end control_pulsadores;

architecture Behavioral of control_pulsadores is

-- Declaración de componentes
component contador_100ms is
    Port ( clk:in STD_LOGIC;
			  rst_cnt : in  STD_LOGIC;
           en_cnt : in  STD_LOGIC;
           cnt_100ms : out  STD_LOGIC);
end component;

component MooreFSM is
    Port ( clk : in STD_LOGIC;
			  Up0 : in  STD_LOGIC;
           Down0 : in  STD_LOGIC;
           Up1 : in  STD_LOGIC;
           Down1 : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           rst_cnt : out  STD_LOGIC;
           en_cnt : out  STD_LOGIC;
           cnt_100ms : in  STD_LOGIC;
           rst_f : out  STD_LOGIC;
           en_f : out  STD_LOGIC;
           sel : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

component Reg_f is
    Port ( clk : in  STD_LOGIC;
           rst_f : in  STD_LOGIC;
           en_f : in  STD_LOGIC;
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           f : out  STD_LOGIC_VECTOR (13 downto 0));
end component;

signal rst_cnt, en_cnt, cnt_100ms, en_f, rst_f: STD_LOGIC; -- señales de control 
signal sel: STD_LOGIC_VECTOR (1 downto 0);    	           -- del contador y el registro

begin

-- conexión de módulos
U1: contador_100ms
	port map (
	   clk=>clk,
	   rst_cnt=>rst_cnt,
	   en_cnt=>en_cnt,
	   cnt_100ms=>cnt_100ms
	);
		
U2: MooreFSM
	port map (
           clk => clk,
	   Up0 => Up0,
           Down0 => Down0,
           Up1 => Up1,
           Down1 => Down1,
           Rst => Rst,
           rst_cnt => rst_cnt,
           en_cnt => en_cnt,
           cnt_100ms => cnt_100ms,
           rst_f => rst_f,
           en_f => en_f,
           sel => sel
	);
	
U3: Reg_f
	port map (
	   clk => clk,
           rst_f => rst_f,
           en_f => en_f,
           sel => sel,
           f => f
	);		
 end Behavioral;

