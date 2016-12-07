------------------------------------------------------
-- AUTÓMATA DE CONTROL DEL MÓDULO
--
-- Este autómata se encarga de decir al registro que 
-- pulsador se ha activado. La frecuencia de refresco
-- viene dada por la señal del contador.
------------------------------------------------------ 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MooreFSM is
    Port ( clk : in STD_LOGIC;                          -- entrada de reloj
	   Up0 : in  STD_LOGIC;                         -- pulsador 1
           Down0 : in  STD_LOGIC;                       -- pulsador 2
           Up1 : in  STD_LOGIC;                         -- pulsador 3
           Down1 : in  STD_LOGIC;                       -- pulsador 4
           Rst : in  STD_LOGIC;                         -- entrada de reset
	   cnt_100ms : in  STD_LOGIC;			-- entrada contador
           rst_cnt : out  STD_LOGIC;                    -- salida reset contador
           en_cnt : out  STD_LOGIC;                     -- salida enable contador
           rst_f : out  STD_LOGIC;			-- salida reset registro	
           en_f : out  STD_LOGIC;			-- salida enable registro
           sel : out  STD_LOGIC_VECTOR (1 downto 0));   -- selección en le MUX
end MooreFSM;

architecture Behavioral of MooreFSM is

type status is 
	(st_Main, st_Up0a, st_Up0b, st_Down0a, st_Down0b,   -- estados de la máquina
	st_Up1a, st_Up1b, st_Down1a, st_Down1b, st_Reset);  -- de Moore
	
	signal current_st: status:=st_Main;  -- estado actual
	signal next_st: status:=st_Main;     -- estado siguiente 

begin

memmory: process (clk)  -- proceso de cambio de estado
	begin		
		if (clk='1' and clk'event) then
				current_st <= next_st;    -- pasa al estado siguiente con cada
		end if;		                    -- flanco positivo de reloj
	end process;
	
next_state: process (current_st, Up0, Down0, Up1, Down1, Rst, cnt_100ms) -- proceso que
	begin                                                            -- asigna el
		case current_st is                                       -- siguiente estado
			when st_Main =>
				if Up0='1' then
					next_st<=st_Up0a;				
				elsif Down0='1' then
					next_st<=st_Down0a;				
				elsif Up1='1' then
					next_st<=st_Up1a;				
				elsif Down1='1' then
					next_st<=st_Down1a;				
				elsif Rst='1' then
					next_st<=st_Reset;
				else
					next_st <= st_Main;
				end if;
				
			when st_Up0a =>
				if cnt_100ms='0' then
					next_st<=st_Up0a;
				else
					next_st<=st_Up0b;				
				end if;
			
			when st_Down0a =>
				if cnt_100ms='0' then
					next_st<=st_Down0a;
				else
					next_st<=st_Down0b;				
				end if;
			
			when st_Up1a =>
				if cnt_100ms='0' then
					next_st<=st_Up1a;
				else
					next_st<=st_Up1b;				
				end if;
				
			when st_Down1a =>
				if cnt_100ms='0' then
					next_st<=st_Down1a;
				else
					next_st<=st_Down1b;				
				end if;		

			when st_Up0b =>
				next_st<=st_Main;
				
			when st_Down0b =>
				next_st<=st_Main;
				
			when st_Up1b =>
				next_st<=st_Main;
				
			when st_Down1b =>
				next_st<=st_Main;
				
			when st_Reset =>
				next_st<=st_Main;
		end case;
	end process;
	

outputs: process (current_st)  -- proceso que asigna los valores dependiendo del estado actual
	begin
		case current_st is		
			when st_Main  =>				
				rst_cnt<='1';
				en_cnt<='0';				
				rst_f<='0';
				en_f<='0';
				sel<="00";
				
			when st_Up0a =>				
				rst_cnt<='0';
				en_cnt<='1';
				rst_f<='0';
				en_f<='0';
				sel<="00";	
				
			when st_Up0b =>
				rst_cnt<='1';
				en_cnt<='0';
				rst_f<='0';
				en_f<='1';
				sel<="00";
				
			when st_Down0a =>				
				rst_cnt<='0';
				en_cnt<='1';
				rst_f<='0';
				en_f<='0';
				sel<="00";	
				
			when st_Down0b =>
				rst_cnt<='1';
				en_cnt<='0';
				rst_f<='0';
				en_f<='1';
				sel<="01";
				
			when st_Up1a =>				
				rst_cnt<='0';
				en_cnt<='1';
				rst_f<='0';
				en_f<='0';
				sel<="00";	
				
			when st_Up1b =>
				rst_cnt<='1';
				en_cnt<='0';
				rst_f<='0';
				en_f<='1';
				sel<="10";
				
			when st_Down1a =>				
				rst_cnt<='0';
				en_cnt<='1';
				rst_f<='0';
				en_f<='0';
				sel<="00";	
				
			when st_Down1b =>
				rst_cnt<='1';
				en_cnt<='0';
				rst_f<='0';
				en_f<='1';
				sel<="11";	

			when st_Reset =>
				rst_cnt<='1';
				en_cnt<='0';				
				rst_f<='1';
				en_f<='0';
				sel<="00";
				
			when others  =>				
				rst_cnt<='1';
				en_cnt<='0';				
				rst_f<='0';
				en_f<='0';
				sel<="00";			
		end case;
	end process;				
end Behavioral;
