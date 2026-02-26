-- Paquete que contiene definiciones de componentes genéricos para temporización, contadores, displays y registros

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.funPackage.all;

package compPackage is
-- Componente Prescaler: Genera una señal de habilitación (CE) mediante la división de la frecuencia de entrada.
  -- El parámetro DIVISOR define el número de ciclos de reloj necesarios para obtener un pulso de enable 
  -- (por defecto, equivale a 1 segundo a 50MHz).
  component Prescaler is
      generic (
        DIVISOR : integer := 50_000_000  -- Número de ciclos para un pulso de 1 segundo a 50MHz
      );
      port (
		  clk_in : in  std_logic;
        rst    : in  std_logic;
        CE_out : out std_logic
      );
  end component;

  -- Componente ContGen: Contador genérico configurable que cuenta hasta un valor máximo definido por cuentaFinal.
  -- Genera una salida de cuenta de ancho variable y una señal de habilitación de salida (CEO).
  component ContGen is
  generic (
      cuentaFinal : integer := 4  -- Valor máximo que alcanza la cuenta
    );
    port (
      clk    : in  std_logic;                           -- Señal de reloj
      CE     : in  std_logic;                           -- Habilitación del contador
      RST    : in  std_logic;                           -- Reset sincrónico
		conteo : out std_logic_vector(nbitsFun(cuentaFinal)-1 downto 0);  -- Salida de la cuenta
      CEO    : out std_logic                          -- Señal de habilitación de salida
    );
  end component;
  
  -- Componente dec7seg: Decodificador para display de 7 segmentos.
  -- Convierte un dígito binario de 4 bits en la representación adecuada para un display de 7 segmentos.
  component dec7seg is
      port(
        dig : in  std_logic_vector(3 downto 0);  -- Dígito en binario (4 bits)
        sel : in  std_logic_vector(1 downto 0);  -- Selección del dígito
        p   : in  std_logic;                     -- Señal de control
		  seg : out std_logic_vector(1 to 7);       -- Salidas para los 7 segmentos
        an  : out std_logic_vector(3 downto 0);    -- Señales de activación de los ánodos
        dp  : out std_logic                      -- Salida para el punto decimal
      );
  end component;
  
 -- Componente registro_p: Registro paralelo de 4 bits.
  -- Captura y almacena datos de entrada en paralelo, utilizando señales de reloj, reset y habilitación.
  component registro_p is
      port(
          D   : in  std_logic_vector(3 downto 0); -- Datos de entrada en paralelo
          CLK : in  std_logic;                    -- Señal de reloj
          CLR : in  std_logic;                    -- Reset sincrónico
			 CE  : in  std_logic;                    -- Habilitación del registro
          Q   : out std_logic_vector(3 downto 0)  -- Datos almacenados (salida)
      );
  end component;
  
  -- Componente registro_sp: Registro serial-paralelo de 4 bits.
  -- Convierte una secuencia de datos seriales en una salida de 4 bits en paralelo, controlado por reloj, reset y habilitación.
  component registro_sp is
      port(
          SLI : in  std_logic;                    -- Entrada de datos en serie
          CLK : in  std_logic;                    -- Señal de reloj
          CLR : in  std_logic;                    -- Reset sincrónico
			 CE  : in  std_logic;                    -- Habilitación del registro
          Q   : out std_logic_vector(3 downto 0)  -- Salida de datos en paralelo
      );
  end component;
  
  -- Componente reg_ps: Registro con funcionalidad de desplazamiento y carga.
  -- Permite seleccionar entre cargar datos en paralelo o desplazar los datos existentes,
  -- controlado por la señal SHIFT_LOAD.
  COMPONENT reg_ps
    PORT(
         CLK        : IN  std_logic;                 -- Señal de reloj
         CE         : IN  std_logic;                 -- Habilitación del registro
         CLR        : IN  std_logic;                 -- Reset sincrónico
			SHIFT_LOAD : IN  std_logic;                 -- Selección entre desplazamiento (0) o carga (1)
         D          : IN  std_logic_vector(3 downto 0); -- Datos de entrada
         SLO        : OUT std_logic                  -- Salida serial resultante del desplazamiento
    );
  END COMPONENT;

  end compPackage;

package body compPackage is


end compPackage;
  
  
  
  