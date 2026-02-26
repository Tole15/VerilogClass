--
--	Package para funciones y procedimientos

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package funPackage is
--
	function nbitsFun (cuentaFinal: integer) return integer;
--
end funPackage;

package body funPackage is
--
	function nbitsFun (cuentaFinal: integer) return integer is
			variable n:integer:=1;
		begin
			while (cuentaFinal > 2**n-1) loop
				n := n +1;
			end loop;
			return n;
	end function nbitsFun;
--
end funPackage;
