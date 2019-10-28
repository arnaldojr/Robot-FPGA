
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Bumper is
	port ( 
			b:   in  STD_LOGIC_VECTOR(1 downto 0);
			q:   out STD_LOGIC_VECTOR(1 downto 0)
			
	);
end entity;

architecture rtl of Bumper is
begin
	
	q <= b;

end rtl;