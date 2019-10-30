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
		delay : integer := 1000000 -- calculo do debounce t(s) = delay/clock 
	);
    port(   
		CLOCK_IN : in std_logic;
      BOTAO_IN : in std_logic;
      BOTAO_OUT : out std_logic
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
SIGNAL counter : INTEGER RANGE 0 TO DELAY:= 0;
signal flag: std_logic := '0';

---------------
-- implementacao
---------------
begin

BOTAO_OUT <= flag;


PROCESS(CLOCK_IN)

BEGIN
	IF rising_edge(CLOCK_IN) THEN
		IF (counter < delay) and (BOTAO_IN /= flag)  THEN
			counter <= counter + 1;
		ELSIF counter = delay THEN
			counter <= 0;
			flag <= BOTAO_IN;
		ELSE
			counter <= 0;
		END IF;
	END IF;
	
END PROCESS;


end rtl;