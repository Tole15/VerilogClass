------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.compPackage.all;

entity display4dig is
  port(
    clk    : in std_logic;       
    rst    : in std_logic;       
    ce_1khz: in std_logic;      
    dig0   : in std_logic_vector(3 downto 0);
    dig1   : in std_logic_vector(3 downto 0);
    dig2   : in std_logic_vector(3 downto 0);
    dig3   : in std_logic_vector(3 downto 0);
    puntos : in std_logic_vector(3 downto 0);
    seg    : out std_logic_vector(1 to 7);
    an     : out std_logic_vector(3 downto 0);
    dp     : out std_logic
  );
end display4dig;

architecture Behavioral of display4dig is
  signal sel   : std_logic_vector(1 downto 0);
  signal digito: std_logic_vector(3 downto 0);
  signal punt  : std_logic;
begin

  cont_mod4: ContGen
    generic map (cuentaFinal => 3)
    port map(
      clk    => clk,
      CE     => ce_1khz,    -- AQUI lo conectamos
      RST    => rst,        -- Reset sincrónico
      conteo => sel,
      CEO    => open
    );

  -- Decodificación 7 segmentos (usa `sel` para saber qué ánodo encender)
  dec7segm: dec7seg
    port map(
      dig => digito,
      sel => sel,
      p   => punt,
      seg => seg,
      an  => an,
      dp  => dp
    );
	 
  punt <= puntos(0) when sel = "00" else
          puntos(1) when sel = "01" else
          puntos(2) when sel = "10" else
          puntos(3);
			 
  digito <= dig0 when sel="00" else
            dig1 when sel="01" else
            dig2 when sel="10" else
            dig3;
				
end Behavioral;
			 