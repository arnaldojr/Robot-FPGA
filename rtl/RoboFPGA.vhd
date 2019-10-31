--
-- Elementos de Sistemas - Robo FPGA - Logica Combinacional
-- Rafael . Corsi @ insper . edu . br
-- Arnaldo A V J @ insper . edu . br 
--
-- Arquivo exemplo para acionar o robo FPGA  com a 
-- placa DE0-CV utilizada no curso de elementos de 
-- sistemas do 3s da eng. da computacao

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
entity RoboFPGA is
	generic(
		 DELAY : INTEGER := 100000
		 );
	port(
		CLOCK_IN :in std_logic;
		DIRECAO_IN	: in std_logic_vector(1 downto 0);
		DIRECAO_OUT	: out std_logic_vector(3 downto 0);
		ENABLE_IN	: in std_logic_vector(1 downto 0);
		ENABLE_OUT	: out std_logic_vector(1 downto 0);
		BUMPER_IN	: in std_logic_vector(1 downto 0);
		BUMPER_OUT	: out std_logic_vector(1 downto 0)		
		);
end entity;
---------------------------------------------------------------------------------------------
-------------------------- DESCRIÇAO DAS ENTRADAS E SAIDAS----------------------------------- 
---------------------------------------------------------------------------------------------
--DIRECAO_IN(1)				: ENTRADA	: MOTOR1; DIRECAO: 0 = TRAZ, 1 = FRENTE 
--DIRECAO_IN(0)				: ENTRADA 	: MOTOR0; DIRECAO: 0 = TRAZ, 1 = FRENTE 
--DIRECAO_OUT(3 DOWNTO 2)	: SAIDA 		: MOTOR1; PINO INA E INB DO DRIVE L298
--DIRECAO_OUT(1 DOWNTO 0)	: SAIDA 		: MOTOR0; PINO INA E INB DO DRIVE L298
--
--ENABLE_IN(1)					: ENTRADA 	: MOTOR1; ATIVA SAIDA : 0 = DESATIVADO, 1 = ATIVADO
--ENABLE_IN(0)					: ENTRADA 	: MOTOR0; ATIVA SAIDA : 0 = DESATIVADO, 1 = ATIVADO
--ENABLE_OUT(1)				: SAIDA 		: MOTOR1; PWM PINO ENABLE DO DRIVE L298 	
--ENABLE_OUT(0)				: SAIDA 		: MOTOR0; PWM PINO ENABLE DO DRIVE L298 
--
--BUMPER_IN(1)					: ENTRADA 	: BUMPER1; SENSOR FIM DE CURSO
--BUMPER_IN(0)					: ENTRADA 	: BUMPER0; SENSOR FIM DE CURSO


----------------------------
-- Implementacao do bloco -- 
----------------------------
architecture rtl of RoboFPGA is

-----------------
-- Componentes --
-----------------
component MotorDC is
	generic(
		 DELAY : INTEGER := 10000);
	port(
		CLOCK_IN 	: in STD_LOGIC;
		DIRECAO		: in std_logic;
		DUTY			: in std_logic_vector(3 downto 0);
		DIRECAO_OUT	: out STD_LOGIC_VECTOR(1 downto 0); 
		PWM_OUT		: out std_logic
	);
end component;

component Bumper is
	generic(
		Debounce_time : integer := 10000000 -- calculo do debounce t(s) = Debounce_time/clock 
	);
    port(   
		CLOCK_IN : in std_logic;
		b:   in  STD_LOGIC_VECTOR(1 downto 0);
		q:   out STD_LOGIC_VECTOR(1 downto 0)
		);
end component;



--------------
-- signals
--------------
signal DUTY_OUT1: STD_LOGIC_VECTOR(3 downto 0) := "0000"; --DUTY DE 50%
signal DUTY_OUT0: STD_LOGIC_VECTOR(3 downto 0) := "0000"; --DUTY DE 50%

---------------
-- implementacao
---------------
begin

DUTY_OUT1 <=	"0101" WHEN (ENABLE_IN(1) ='1') else
					"0000";
					
DUTY_OUT0 <=	"0101" WHEN (ENABLE_IN(0) ='1') else
					"0000";

S0: MotorDC port map (	CLOCK_IN => CLOCK_IN, 
								DIRECAO => DIRECAO_IN(1),
								DUTY => DUTY_OUT1,
								DIRECAO_OUT=> DIRECAO_OUT(3 DOWNTO 2),
								PWM_OUT => ENABLE_OUT(1)
							);
								
S1: MotorDC port map (	CLOCK_IN => CLOCK_IN, 
								DIRECAO => DIRECAO_IN(0),
								DUTY => DUTY_OUT0,
								DIRECAO_OUT => DIRECAO_OUT(1 DOWNTO 0),
								PWM_OUT => ENABLE_OUT(0)
							);


S2: Bumper port map (	CLOCK_IN => CLOCK_IN,
								b => BUMPER_IN,
								q => BUMPER_OUT
							);						
							
							
							
end rtl;