--------------------------------------------------------------------------------
-- TEST BENCH VISUALIZACIÓN
--
-- Este módulo se encarga de comprobar el correcto funcionamiento
-- del módulo "visualización". La frecuencia de refresco es la de reloj.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY visualizacion_tb IS
END visualizacion_tb;
 
ARCHITECTURE behavior OF visualizacion_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT visualizacion
    PORT(
         clk : IN  std_logic;                         -- entrada de reloj
         cnt_5ms : IN  std_logic;                     -- entrada del contador
         Digito0 : IN  std_logic_vector(3 downto 0);  -- unidades
         Digito1 : IN  std_logic_vector(3 downto 0);  -- decenas
         Digito2 : IN  std_logic_vector(3 downto 0);  -- centenas
         Digito3 : IN  std_logic_vector(3 downto 0);  -- millares
         Disp0 : OUT  std_logic;                      -- display 1
         Disp1 : OUT  std_logic;                      -- display 2
         Disp2 : OUT  std_logic;                      -- display 3
         Disp3 : OUT  std_logic;                      -- display 4
         Seg7 : OUT  std_logic_vector(6 downto 0)     -- segmentos
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal cnt_5ms : std_logic := '0';
   signal Digito0 : std_logic_vector(3 downto 0) := (others => '0');
   signal Digito1 : std_logic_vector(3 downto 0) := (others => '0');
   signal Digito2 : std_logic_vector(3 downto 0) := (others => '0');
   signal Digito3 : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Disp0 : std_logic;
   signal Disp1 : std_logic;
   signal Disp2 : std_logic;
   signal Disp3 : std_logic;
   signal Seg7 : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: visualizacion PORT MAP (
          clk => clk,
          cnt_5ms => cnt_5ms,
          Digito0 => Digito0,
          Digito1 => Digito1,
          Digito2 => Digito2,
          Digito3 => Digito3,
          Disp0 => Disp0,
          Disp1 => Disp1,
          Disp2 => Disp2,
          Disp3 => Disp3,
          Seg7 => Seg7
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	cnt_5ms_process :process
	begin
		cnt_5ms <= '0';
		wait for 5ms;
		cnt_5ms <= '1';
		wait for 20ns;
	end process;
 

   -- Stimulus process
   stim_proc: process   -- cada 100ms cambia el número de entrada
   begin		
      Digito0 <= "0001";  --251
		Digito1 <= "0101";
		Digito2 <= "0010";
		Digito3 <= "0000";
      wait for 100ms;
		Digito0 <= "0000";  --1000
		Digito1 <= "0000";
		Digito2 <= "0000";
		Digito3 <= "0001";
      wait for 100ms;
		Digito0 <= "0100";  --1234
		Digito1 <= "0111";
		Digito2 <= "0010";
		Digito3 <= "0001";
      wait for 100ms;
		Digito0 <= "0111";  --587
		Digito1 <= "1000";
		Digito2 <= "0101";
		Digito3 <= "0000";
      wait for 100ms;
		Digito0 <= "1001";  --8719
		Digito1 <= "0001";
		Digito2 <= "0111";
		Digito3 <= "1000";		
      wait;
   end process;
END;