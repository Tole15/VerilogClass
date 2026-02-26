library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.compPackage.all;

entity contBCD29 is
	Port (clk: in std_logic;
			Unidades: out std_logic_vector (3 downto 0);
			Decenas: out std_logic_vector (1 downto 0);
			CEO: out std_logic);
end contBCD29;

architecture Behavioral of contBCD29 is
	signal CEO_uni:std_logic;

begin
	--Contador de unidades de 0 a 9
	cont_uni: ContGen 	generic map(cuentaFinal=>9)
			Port map (clk=>clk, 
			CE=>'1', 
			RST=>'0', 
			conteo=>Unidades, 
			CEO=>CEO_uni);	
	--Contador de unidades de 0 a 2
	cont_dec: ContGen 	generic map(cuentaFinal=>2)
			Port map(clk=>clk, 
				CE=>CEO_uni, 
				RST=>'0', 
				conteo=>Decenas, 
				CEO=>CEO);
end Behavioral;

