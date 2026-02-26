library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dec7seg is
port (dig:in std_logic_vector(3 downto 0);
		sel: in std_logic_vector(1 downto 0);
		p: in std_logic;
		seg: out std_logic_vector(1 to 7);
		an: out std_logic_vector(3 downto 0);
		dp: out std_logic);
end dec7seg;

architecture Behavioral of dec7seg is
begin

seg<= "0000001"when dig="0000" else
		"1001111" when dig="0001" else
		"0010010" when dig="0010" else
		"0000110" when dig="0011" else
		"1001100" when dig="0100" else
		"0100100" when dig="0101" else
		"0100000" when dig="0110" else
		"0001111" when dig="0111" else
		"0000000" when dig="1000" else
		"0001100" when dig="1001" else
		"0001000" when dig="1010" else
		"1100000" when dig="1011" else
		"0110001" when dig="1100" else
		"1000010" when dig="1101" else
		"0110000" when dig="1110" else
		"0111000";

an <= "1110" when sel="00" else
		"1101" when sel="01" else
		"1011" when sel="10" else
		"0111";

dp <= not p;

end Behavioral;

