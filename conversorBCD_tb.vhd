-------------------------------------------------
-- TEST BENCH DE CONVERSOR BCD
--
-- Este módulo se encarga de comprobar el 
-- correcto funcionamiento del conversor BCD.
-------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY conversorBCD_tb IS
END conversorBCD_tb;
 
ARCHITECTURE behavior OF conversorBCD_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT conversorBCD
    PORT(
         clk : IN  std_logic;                     -- entrada de reloj
         f : IN  std_logic_vector(13 downto 0);   -- entrada de datos
         D0 : OUT  std_logic_vector(3 downto 0);  -- salida unidades
         D1 : OUT  std_logic_vector(3 downto 0);  -- salida decenas
         D2 : OUT  std_logic_vector(3 downto 0);  -- salida centenas
         D3 : OUT  std_logic_vector(3 downto 0)   -- salida unidades de millar
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal f : std_logic_vector(13 downto 0) := (others => '0');

 	--Outputs
   signal D0 : std_logic_vector(3 downto 0);
   signal D1 : std_logic_vector(3 downto 0);
   signal D2 : std_logic_vector(3 downto 0);
   signal D3 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: conversorBCD PORT MAP (
          clk => clk,
          f => f,
          D0 => D0,
          D1 => D1,
          D2 => D2,
          D3 => D3
        );

   -- Clock process definitions
   clk_process: process
	begin
		clk <= '1', '0' after clk_period/2;
		wait for clk_period;
   end process clk_process;
 

   -- Stimulus process
   stim_proc: process       -- cada 100ms varía la frecuencia de entrada
   begin		                
	f<="00000011011111";  -- 223
      	wait for 100 ms;	
	f<="10000110111000";  -- 8632
	wait for 100 ms;
	f<="00000000001010";  -- 10
	wait for 100 ms;
	f<="01000010001001";  -- 4233
	wait for 100 ms;
	f<="00000000000111";  -- 7
        wait;
   end process;
END;
