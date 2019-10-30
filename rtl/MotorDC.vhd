--
-- Elementos de Sistemas - Robo FPGA - Logica Combinacional
-- Rafael . Corsi @ insper . edu . br
-- Arnaldo A V J @ insper . edu . br 
--
-- Arquivo exemplo para acionar o moto DC atraves do 
-- drive L298n com placa DE0-CV utilizada no curso de  
-- elementos de sistemas do 3s da eng. da computacao

----------------------------
-- Bibliotecas ieee       --
----------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

----------------------------
-- Entrada e saidas do bloco
----------------------------
entity MotorDC is
	generic(
		 DELAY : INTEGER := 100000);
	port(
		CLOCK_IN 	: in STD_LOGIC;
		DIRECAO		: in std_logic;
		DUTY			: in std_logic_vector(3 downto 0);
		DIRECAO_OUT	: out STD_LOGIC_VECTOR(1 downto 0); -- SAIDA GPIO_0(0) - in1
		PWM_OUT		: out std_logic

	);
end entity;

----------------------------
-- Implementacao do bloco -- 
----------------------------
architecture rtl of MotorDC is

--------------
-- signals
--------------
SIGNAL T : INTEGER := DELAY;
SIGNAL counter : INTEGER RANGE 0 TO DELAY;
SIGNAL PWM : INTEGER;

---------------
-- implementacao
---------------

begin

DIRECAO_OUT(0) <=  DIRECAO;
DIRECAO_OUT(1) <= NOT DIRECAO;

PWM <=	 	0 		when ( DUTY(3 downto 0)= "0000") else
		DELAY/10 	when ( DUTY(3 downto 0)= "0001") else
		DELAY*2/10	when ( DUTY(3 downto 0)= "0010") else
		DELAY*3/10 	when ( DUTY(3 downto 0)= "0011") else
		DELAY*4/10 	when ( DUTY(3 downto 0)= "0100") else
		DELAY/2 		when ( DUTY(3 downto 0)= "0101") else
		DELAY*6/10 	when ( DUTY(3 downto 0)= "0110") else
		DELAY*7/10 	when ( DUTY(3 downto 0)= "0111") else
		DELAY*8/10 	when ( DUTY(3 downto 0)= "1000") else
		DELAY*9/10 	when ( DUTY(3 downto 0)= "1001") else
		DELAY 		when ( DUTY(3 downto 0)= "1010") else
		DELAY/2;
		
		
divisor: PROCESS(CLOCK_IN)

BEGIN
	IF rising_edge(CLOCK_IN) THEN
		IF counter < T THEN
			counter <= counter + 1;
		ELSE 
			counter <= 0;
		END IF;
		
		IF counter <= PWM THEN
			PWM_OUT <= '1';
		ELSE 
			PWM_OUT <= '0';
		END IF;
	END IF;
	
END PROCESS divisor;

end rtl;
