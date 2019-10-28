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
entity TopLevel is
	generic(
		 DELAY : INTEGER := 100000);
	port(
		CLOCK_50 	: in STD_LOGIC;
		SW				: in std_logic_vector(9 downto 0);
		KEY			: in std_logic_vector(1 downto 0);
		LEDR			: out std_logic_vector(1 downto 0);
		GPIO_0		: out STD_LOGIC_VECTOR(5 downto 0)
		
		);
end entity;

----------------------------
-- Implementacao do bloco -- 
----------------------------
architecture rtl of TopLevel is

-----------------
-- Componentes --
-----------------
component MotorDC is
	generic(
		 DELAY : INTEGER := 100000);
	port(
		CLOCK_IN 	: in STD_LOGIC;
		DIRECAO		: in std_logic;
		DUTY			: in std_logic_vector(3 downto 0);
		DIRECAO_OUT	: out STD_LOGIC_VECTOR(1 downto 0); -- SAIDA GPIO_0(0) - in1
		PWM_OUT		: out std_logic
	);
end component;

component Bumper is
	port ( 
			b:   in  STD_LOGIC_VECTOR(1 downto 0);
			q:   out STD_LOGIC_VECTOR(1 downto 0)
	);
end component;


--------------
-- signals
--------------


---------------
-- implementacao
---------------

begin
S0: MotorDC port map (	CLOCK_IN => CLOCK_50, 
								DIRECAO => SW(4),
								DUTY(3 DOWNTO 0) => SW(3 DOWNTO 0),
								DIRECAO_OUT(1 DOWNTO 0) => GPIO_0(1 DOWNTO 0),
								PWM_OUT => GPIO_0(2)
							);
								
S1: MotorDC port map (	CLOCK_IN => CLOCK_50, 
								DIRECAO => SW(9),
								DUTY(3 DOWNTO 0) => SW(8 DOWNTO 5),
								DIRECAO_OUT(1 DOWNTO 0) => GPIO_0(4 DOWNTO 3),
								PWM_OUT => GPIO_0(5)
							);

S2: Bumper port map (	b => KEY,
								q => LEDR
							);

end rtl;
