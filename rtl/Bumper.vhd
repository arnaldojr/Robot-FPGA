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
use IEEE.STD_LOGIC_1164.ALL;





----------------------------
-- Entrada e saidas do bloco
----------------------------
entity Bumper is
	generic(
		Debounce_time : integer := 10000000 -- calculo do debounce t(s) = delay/clock 
	);
	port ( 
			CLOCK_IN : in std_logic;
			b:   in  STD_LOGIC_VECTOR(1 downto 0);
			q:   out STD_LOGIC_VECTOR(1 downto 0)
			
	);
end entity;


----------------------------
-- Implementacao do bloco -- 
----------------------------
architecture rtl of Bumper is

-----------------
-- Componentes --
-----------------
component Debounce is
	generic(
		Debounce_time : integer := 10000000 -- calculo do debounce t(s) = delay/clock 
	);
    port(   
		CLOCK_IN : in std_logic;
      BOTAO_IN : in STD_LOGIC_VECTOR(1 downto 0);
      BOTAO_OUT : out STD_LOGIC_VECTOR(1 downto 0)
		);
end component;

--------------
-- signals
--------------


---------------
-- implementacao
---------------
begin

S2: Debounce port map (	CLOCK_IN => CLOCK_IN,
								BOTAO_IN => b,
								BOTAO_OUT => q
							);	


end rtl;
