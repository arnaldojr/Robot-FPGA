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
entity TopLevel is
	generic(
		 DELAY : INTEGER := 100000);
	port(
		CLOCK_50 	: in STD_LOGIC;
		SW				: in std_logic_vector(3 downto 0); --DIRECAO_IN(1 downto 0); ENABLE_IN(3 downto 2)
		KEY			: in std_logic_vector(1 downto 0); --BUMPER_IN(1 downto 0)
		LEDR			: out std_logic_vector(7 downto 0); --BUMPER_OUT(1 downto 0)
		GPIO_0		: out STD_LOGIC_VECTOR(5 downto 0) -- DIRECAO_OUT(1 downto 0); ENABLE_OUT(5 downto 2)
		
		);
end entity;

----------------------------
-- Implementacao do bloco -- 
----------------------------
architecture rtl of TopLevel is

-----------------
-- Componentes --
-----------------
component RoboFPGA is
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
end component;

---------------------------------------------------------------------------------------------
-------------------------- DESCRIÇAO DAS ENTRADAS E SAIDAS----------------------------------- 
---------------------------------------------------------------------------------------------
--DIRECAO_IN(1)			: ENTRADA	: MOTOR1; DIRECAO: 0 = TRAZ, 1 = FRENTE 
--DIRECAO_IN(0)			: ENTRADA 	: MOTOR0; DIRECAO: 0 = TRAZ, 1 = FRENTE 
--DIRECAO_OUT(3 DOWNTO 2)	: SAIDA 	: MOTOR1; PINO INA E INB DO DRIVE L298
--DIRECAO_OUT(1 DOWNTO 0)	: SAIDA 	: MOTOR0; PINO INA E INB DO DRIVE L298
--
--ENABLE_IN(1)			: ENTRADA 	: MOTOR1; ATIVA SAIDA : 0 = DESATIVADO, 1 = ATIVADO
--ENABLE_IN(0)			: ENTRADA 	: MOTOR0; ATIVA SAIDA : 0 = DESATIVADO, 1 = ATIVADO
--ENABLE_OUT(1)			: SAIDA 	: MOTOR1; PWM PINO ENABLE DO DRIVE L298 	
--ENABLE_OUT(0)			: SAIDA 	: MOTOR0; PWM PINO ENABLE DO DRIVE L298 
--
--BUMPER_IN(1)			: ENTRADA 	: BUMPER1; SENSOR FIM DE CURSO
--BUMPER_IN(0)			: ENTRADA 	: BUMPER0; SENSOR FIM DE CURSO



--------------
-- signals
--------------


---------------
-- implementacao
---------------

begin
ROBO: RoboFPGA port map (
							CLOCK_IN => CLOCK_50,
							DIRECAO_IN => SW(1 downto 0),
							--DIRECAO_OUT	 => LEDR(7 downto 4), --GPIO_0(5 downto 2)
							DIRECAO_OUT	 => GPIO_0(5 downto 2),
							ENABLE_IN	 => SW(3 downto 2),	
							--ENABLE_OUT	 => LEDR(3 downto 2), --GPIO_0(1 downto 0)
							ENABLE_OUT	 => GPIO_0(1 downto 0),
							BUMPER_IN	 => KEY(1 downto 0),
							BUMPER_OUT  => LEDR(1 downto 0)
							);
	
end rtl;
