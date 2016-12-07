------------------------------------------
-- REGISTRO DE VALORES
--
-- Este módulo se encarga de cambiar 
-- el valor de la frecuencia en función 
-- de los pulsadores y de registrarla
------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all; 

entity Reg_f is
    Port ( clk : in  STD_LOGIC;                      -- entrada de reloj
           rst_f : in  STD_LOGIC;                    -- entrada de reset
           en_f : in  STD_LOGIC;                     -- entrada de enable
           sel : in  STD_LOGIC_VECTOR (1 downto 0);  -- selección de pantalla
           f : out  STD_LOGIC_VECTOR (13 downto 0)); -- frecuencia de salida
end Reg_f;

architecture Behavioral of Reg_f is

signal freq : STD_LOGIC_VECTOR (13 downto 0):="00000110111000"; -- señal de frecuencia,
                                                                -- inicialmente se encuentra
begin                                                           -- en 440 Hz
		
	f <= freq;
	
	process (rst_f, clk)
	begin
		if (rst_f = '1') then 
			freq <= "00000110111000"; -- Asignacin del valor por defecto (440Hz)
		elsif clk'event and clk='1' then
			if en_f = '1' then
				if ((sel = "00") and (freq < 9999)) then -- si la frecuencia es 9999 
				   freq <= freq + "01";  -- +1              o mayor no se puede sumar 1					
				end if;
				if ((sel = "01") and (freq > 0)) then -- si la frecuencia es 0
				   freq <= freq - "01"; -- -1            o menor no se puede restar 1
				end if;
				if ((sel = "10") and (freq < 9900)) then -- si la frecuencia es 9900 
				   freq <= freq + "01100100"; -- +100       o mayor no se puede sumar 100
				end if;
				if ((sel = "11") and (freq > 99)) then -- si la frecuencia es 99
				   freq <= freq - "01100100"; -- -100     o menor no se puede restar 100
				end if;
			end if;
		end if;
	end process;
end Behavioral;
