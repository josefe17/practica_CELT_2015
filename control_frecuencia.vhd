--------------------------------------------------------------------
-- CONTROL DE FRECUENCIA
--
-- Este módulo se encarga de leer y procesar la nota musical 
-- que proviene del sintetizador midi. Además de encarga de 
-- conmuntar entre la frecuencia de la nota y la frecuencia 
-- pasada de los pulsadores (es decir, la frecuencia de la 
-- parte obligatoria.
--------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_frecuencia is
    Port ( midi_en : in  STD_LOGIC;                       -- Entrada del sw de seleccin de modo
           mute : in  STD_LOGIC;                          -- Si activo, está sonando una nota			  
           note : in  STD_LOGIC_VECTOR (6 downto 0);      -- nota MIDI
           f_in : in  STD_LOGIC_VECTOR (13 downto 0);     -- valor de frecuencia de los pulsadores
	   en_out: out STD_LOGIC;                         -- si activo, la salida global está activa
           f_out : out  STD_LOGIC_VECTOR (13 downto 0));  -- frecuencia de salida
			  
end control_frecuencia;

architecture Behavioral of control_frecuencia is

signal freq : STD_LOGIC_VECTOR (13 downto 0):= (others => '0'); -- frecuencia final en la octava adecuada
signal main_freq : STD_LOGIC_VECTOR (13 downto 0) ;             -- frecuencia base de la ROM
signal pitch : STD_LOGIC_VECTOR (3 downto 0);                   -- tono (nota dentro de la octava)
signal octave : STD_LOGIC_VECTOR (3 downto 0);                  -- número de desplazamientos de octava desde la 7
signal DO: STD_LOGIC_VECTOR (6 downto 0);                       -- valor MIDI del DO primero de la octava 

begin

with midi_en select en_out <=      -- genera la señal de enable.
	mute when '1',             -- si el modo MIDI activo, el enable de salida lo controla mute.
	'1' when others;           -- si no (modo display), salida siempre activa.
	
with midi_en select f_out <=      -- conmuta la fuente de frecuencia.
	freq when '1',            -- si MIDI activo, la frecuencia se calcula a partir de las notas MIDI.
	f_in when others;         -- si no, el sistema deja pasar la frecuencia de los pulsadores.
	

octave <= -- Indica cuantas octavas hay que bajar partiendo de la 7, o todo 1 si la nota es de la 8 octava
				"1001" when (note >= 0 and note <12)    	else 			
				"1000" when (note >= 12 and note <24)   	else 	
				"0111" when (note >= 24 and note <36)   	else
				"0110" when (note >= 36 and note <48)   	else
				"0101" when (note >= 48 and note <60)   	else
				"0100" when (note >= 60 and note <72)   	else --LA 440
				"0011" when (note >= 72 and note < 84) 	        else
				"0010" when (note >= 84 and note <96)   	else
				"0001" when (note >= 96 and note <108)   	else
				"0000" when (note >= 108 and  note <120)        else
				"1111";
				
with octave select DO <= --Calcula el valor MIDI del DO asociado a la octava en cuestión
	"1101100" when "0000", --108
	"1100000" when "0001", --96
	"1010100" when "0010", --84
	"1001000" when "0011", --72
	"0111100" when "0100", --60
	"0110000" when "0101", --48
	"0100100" when "0110", --36
	"0011000" when "0111", --24
	"0001100" when "1000", --12
	"0000000" when "1001", --0
	"1111000" when others; --120
	
	
pitch <=note - DO ; --Calcula cuál de las notas de la octava es.
				
with pitch select main_freq <= --Calcula cual es la frecuencia base de la nota en la 7 octava
				"01000001011010" when "0000", -- 4186 Hz para DO (4186,08 teoricos)
				"01000101010011" when "0001", -- 4435 Hz para DO# (4434,88 tericos)
				"01001001011011" when "0010", -- 4699 Hz para RE (4698,56 tericos)
				"01001101110010" when "0011", -- 4978 Hz para RE# (4978,08 tericos)
				"01010010011010" when "0100", -- 5274 Hz para MI (5274,08 tericos)
				"01010111010100" when "0101", -- 5588 Hz para FA (5587,68 tericos)
				"01011100100000" when "0110", -- 5920 Hz para FA# (5919,84 tericos)
				"01100010000000" when "0111", -- 6272 Hz para SOL
				"01100111110101" when "1000", -- 6645 Hz para SOL# (6644,8 tericos)
				"01101110000000" when "1001", -- 7040 Hz para LA
				"01110100100011" when "1010", -- 7459 Hz para LA# (7458,56 tericos)
				"01111011011110" when "1011", -- 7902 Hz para SI (7902,08 tericos)
				(others => '0') when others;  -- Si error, frecuencia 0
				
with octave select freq <=                   -- calcula la frecuencia real de la nota haciendo desplazamientos
	shl(main_freq, "1")  when "1111",    -- multiplica por 2 si es una nota de la 8 octava
	shr(main_freq, octave) when others ; -- divide por 2^octave según el número de octava
	
end Behavioral;
