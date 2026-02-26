library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.compPackage.all;

entity Reloj24Completo is
    Port (
        clk_in : in std_logic;
        rst    : in std_logic;
        seg    : out std_logic_vector(1 to 7);
        an     : out std_logic_vector(3 downto 0);
        dp     : out std_logic;
		  UnidadesHr  : out std_logic_vector(3 downto 0);
        DecenasHr   : out std_logic_vector(1 downto 0);
        UnidadesMin : out std_logic_vector(3 downto 0);
        DecenasMin  : out std_logic_vector(2 downto 0)
    );
end Reloj24Completo;

architecture Behavioral of Reloj24Completo is

  signal ce_minutos : std_logic; -- 2Hz Hz clock enable
  signal ce_1khz    : std_logic; -- 1 kHz clock enable
  signal int_DecHr  : std_logic_vector(1 downto 0);
  signal int_UniHr  : std_logic_vector(3 downto 0);
  signal int_DecMin : std_logic_vector(2 downto 0);
  signal int_UniMin : std_logic_vector(3 downto 0);
  signal nib_DecHr  : std_logic_vector(3 downto 0);
  signal nib_UniHr  : std_logic_vector(3 downto 0);
  signal nib_DecMin : std_logic_vector(3 downto 0);
  signal nib_UniMin : std_logic_vector(3 downto 0);

begin

U_prescaler_2Hz : entity work.Prescaler(Behavioral)
    generic map(DIVISOR => 25_000_000)  -- 2Hz
    port map(
      clk_in => clk_in,
      rst    => rst,
      CE_out => ce_minutos
    );

	 
	   U_prescaler_1kHz : entity work.Prescaler(Behavioral)
    generic map(DIVISOR => 50_000)  -- Generates a 1 kHz enable pulse
    port map(
      clk_in => clk_in,
      rst    => rst,
      CE_out => ce_1khz
    );

  U_reloj24 : entity work.Reloj24(Behavioral)
    port map(
      clk         => clk_in,
      CE_minutos  => ce_minutos,
      rst         => rst,
      UnidadesHr  => int_UniHr,
      DecenasHr   => int_DecHr,
      UnidadesMin => int_UniMin,
      DecenasMin  => int_DecMin,
      CEO         => open  
    );
	 
  nib_DecHr  <= "00" & int_DecHr;  
  nib_UniHr  <= int_UniHr;        
  nib_DecMin <= "0"  & int_DecMin;
  nib_UniMin <= int_UniMin;    
  
   U_display : entity work.display4dig(Behavioral)
    port map(
      clk     => clk_in,
      rst     => rst,
      ce_1khz => ce_1khz,
      dig0    => nib_UniMin,
      dig1    => nib_DecMin,
      dig2    => nib_UniHr,
      dig3    => nib_DecHr,
      puntos  => "0000",      
      seg     => seg,        
      an      => an,          
      dp      => dp            
    );

end Behavioral;
