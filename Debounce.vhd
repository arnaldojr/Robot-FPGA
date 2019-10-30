--
-- Elementos de Sistemas - Robo FPGA - Logica Combinacional
-- Rafael . Corsi @ insper . edu . br
-- Arnaldo A V J @ insper . edu . br 
--
-- Arquivo exemplo de Debounce de tecla mecanica 
-- para a placa DE0-CV utilizada no curso de  
-- elementos de sistemas do 3s da eng. da computacao

----------------------------
-- Bibliotecas ieee       --
----------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


----------------------------
-- Entrada e saidas do bloco
----------------------------
entity Debounce is
	generic(
		Debounce_time : integer := 10000000 -- calculo do debounce t(s) = delay/clock 
	);
    port(   
		CLOCK_IN : in std_logic;
      BOTAO_IN : in STD_LOGIC_VECTOR(1 downto 0);
      BOTAO_OUT : out STD_LOGIC_VECTOR(1 downto 0)
		);
end Debounce;

----------------------------
-- Implementacao do bloco -- 
----------------------------
architecture rtl of Debounce is
-----------------
-- Componentes --
-----------------

--------------
-- signals
--------------
SIGNAL counter : INTEGER RANGE 0 TO Debounce_time:= 0;
signal flag: STD_LOGIC_VECTOR(1 downto 0) := "00";

---------------
-- implementacao
---------------
begin

BOTAO_OUT <= flag;


PROCESS(CLOCK_IN)

BEGIN
	IF rising_edge(CLOCK_IN) THEN
		IF (counter < Debounce_time) and (BOTAO_IN /= flag)  THEN
			counter <= counter + 1;
		ELSIF counter = Debounce_time THEN
			counter <= 0;
			flag <= BOTAO_IN;
		ELSE
			counter <= 0;
		END IF;
	END IF;
	
END PROCESS;


end rtl;
