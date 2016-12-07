-------------------------------------------------
-- TEST BENCH DE DIVISOR
--
--	Este módulo se encarga de comprobar el 
-- correcto funcionamiento del divisor.
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY divisor_tb IS
END divisor_tb;
 
ARCHITECTURE behavior OF divisor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT divisor
    PORT(
         clk : IN  std_logic;                         -- entrada de reloj
         f : IN  std_logic_vector(13 downto 0);       -- frecuencia de entrada
         N_count : OUT  std_logic_vector(31 downto 0) -- número de flancos de reloj
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal f : std_logic_vector(13 downto 0) := (others => '0');

 	--Outputs
   signal N_count : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: divisor PORT MAP (
          clk => clk,
          f => f,
          N_count => N_count
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process                 -- cada 100ms varía la frecuencia de entrada
   begin		
      f <= ext("01",14);                        -- 1
		wait for 100 ms;	
		f <= ext("110111000",14);       -- 440
      wait for 100 ms;
		f <= ext("11001000",14);        -- 200
		wait for 100 ms;
		f <= ext("10",14);              -- 2
		wait for 100 ms;
		f <= ext("10011100001111",14);  -- 9999
      wait;
   end process;
END;
