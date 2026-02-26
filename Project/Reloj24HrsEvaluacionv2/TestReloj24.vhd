library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_Reloj24Completo is
end test_Reloj24Completo;

architecture tb of test_Reloj24Completo is


    signal clk_in     : std_logic := '0';
    signal rst        : std_logic := '0';
    signal UnidadesHr : std_logic_vector(3 downto 0);
    signal DecenasHr  : std_logic_vector(1 downto 0);
    signal UnidadesMin: std_logic_vector(3 downto 0);
    signal DecenasMin : std_logic_vector(2 downto 0);
	 constant T_clk     : time := 10 ns;
	 
  begin
  UUT : entity work.Reloj24Completo(Behavioral)
        port map(
            clk_in      => clk_in,
            rst         => rst,
            UnidadesHr  => UnidadesHr,
            DecenasHr   => DecenasHr,
            UnidadesMin => UnidadesMin,
            DecenasMin  => DecenasMin
        );
		  
     clk_process: process
    begin
        while true loop
            clk_in <= '0';
            wait for T_clk/2;
            clk_in <= '1';
            wait for T_clk/2;
        end loop;
    end process;
	 
    rst_process: process
    begin
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait;
    end process;
	 
    simulation_stop: process
    begin
        wait for 1500 * T_clk;
        report "Simulation Finished" severity note;
        wait;
    end process;
	 
end architecture tb;
