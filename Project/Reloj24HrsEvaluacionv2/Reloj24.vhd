library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.compPackage.all;
use work.funPackage.all;

entity Reloj24 is
    Port (
        clk         : in  std_logic;
        CE_minutos  : in  std_logic;
        rst         : in  std_logic;
        UnidadesHr  : out std_logic_vector(3 downto 0);
        DecenasHr   : out std_logic_vector(1 downto 0);
        UnidadesMin : out std_logic_vector(3 downto 0);
        DecenasMin  : out std_logic_vector(2 downto 0);
        CEO         : out std_logic
    );
end Reloj24;

architecture Behavioral of Reloj24 is

  signal CEO_uni_min  : std_logic;
  signal CEO_dec_min  : std_logic;
  signal CEO_uni_hr   : std_logic;
  signal reinicio_horas : std_logic;
  signal reset_all    : std_logic;
  signal int_UnidadesHr : std_logic_vector(3 downto 0);
  signal int_DecenasHr  : std_logic_vector(1 downto 0);
	 
begin
    UnidadesHr <= int_UnidadesHr;
    DecenasHr  <= int_DecenasHr; 
	 
	 reinicio_horas <= '1' when (int_DecenasHr = "01" and int_UnidadesHr = "0010" and CEO_dec_min = '1') else '0';

	 
	 reset_all <= reinicio_horas OR rst;
	 
    -- Unidades de minuto (0..9)
    cont_uni_min : ContGen
        generic map(cuentaFinal => 9)
        port map(
            clk    => clk,
				CE     => CE_minutos,
            RST    =>  reset_all,
            conteo => UnidadesMin,
            CEO    => CEO_uni_min
        );
    -- Decenas de minuto (0..5)
    cont_dec_min : ContGen
        generic map(cuentaFinal => 5)
        port map(
            clk    => clk,
            CE     => CEO_uni_min, 
            RST    =>  reset_all,
            conteo => DecenasMin,
            CEO    => CEO_dec_min
        );
		  
    -- Unidades de hora (0..9)
    cont_uni_hr : ContGen
        generic map(cuentaFinal => 9)
        port map(
            clk    => clk,
            CE     => CEO_dec_min,        
            RST    =>  reset_all,
            conteo => int_UnidadesHr,
            CEO    => CEO_uni_hr
        );
    -- Decenas de hora (0..2)
    cont_dec_hr : ContGen
        generic map(cuentaFinal => 2)
        port map(
            clk    => clk,
            CE     => CEO_uni_hr,
            RST    =>  reset_all,
            conteo => int_DecenasHr,
            CEO    => CEO
        );
end Behavioral;

