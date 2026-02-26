library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.funPackage.all;

entity ContGen is
	generic (cuentaFinal:integer:=4);--Mximo nmero que alcanza la cuenta
	port (clk: in std_logic;		--Seal de reloj
			CE: in std_logic;				--Clock Enable
			RST: in std_logic;			--RESET Sncrono
			conteo: out std_logic_vector (nbitsFun(cuentaFinal)-1 downto 0);	--Cuenta
			CEO: out std_logic); 			--Clock Enable Output
end ContGen;

architecture Behavioral of ContGen is
		signal countaux: std_logic_vector (nbitsFun(cuentaFinal)-1 downto 0):=(others=>'0');	--Cuenta auxiliar
		signal TC: std_logic; 			--TC: Bandera de la cuenta mxima
	begin
		conteo <= countaux;			--Al puerto cuenta se conecta la cuenta auxiliar
		TC <= '1' when countaux=cuentaFinal else '0'; --Terminal Count: 
		process(clk)	
			begin
			if rising_edge(clk) then				--Flanco positivo de clk 
				if RST='1' then						--Si est activo el RESET
				countaux <= (others=>'0');			--Se Resetea cuenta
				elsif CE='1' then						--CE='1'
					if TC='1' then						--Si se llega a la cuenta Final
						countaux <= (others=>'0');	--Se Resetea cuenta
					else									--Si no
						countaux <= countaux + 1;	--Se sigue incrementando la cuenta
					end if;
				end if;
			end if;
		end process;
		--La salida CEO
		CEO <= '1' when TC='1' and CE='1' else '0';		--Habilitador de la cuenta externa
end Behavioral;

