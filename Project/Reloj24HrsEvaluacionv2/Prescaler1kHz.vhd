library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Prescaler1kHz is
    Port (
        clk_in  : in  std_logic;
        rst     : in  std_logic;
        CE_out  : out std_logic 
    );
end Prescaler1kHz;
architecture Behavioral of Prescaler1kHz is
    constant DIVISOR : integer := 50_000; 
    signal count : integer range 0 to DIVISOR-1 := 0;
begin
process(clk_in, rst)
begin
    if rst='1' then
        count  <= 0;
        CE_out <= '0';
    elsif rising_edge(clk_in) then
        if count = DIVISOR-1 then
            count  <= 0;
            CE_out <= '1';    
        else
            count  <= count + 1;
            CE_out <= '0';
        end if;
    end if;
end process;
end Behavioral;