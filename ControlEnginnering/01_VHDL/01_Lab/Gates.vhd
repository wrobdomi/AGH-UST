
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity bramki is
    Port ( SW : in STD_LOGIC_VECTOR (1 downto 0); -- zadeklarowane jako in na potrzeby symulacji, ma byc inout
           LED : out STD_LOGIC_VECTOR (6 downto 0));
end bramki;

architecture Behavioral of bramki is

begin
LED(0) <= SW(0) AND SW(1) ;
LED(1) <= NOT ( SW(0) AND SW(1) );
LED(2) <= SW(0) OR SW(1);
LED(3) <= NOT ( SW(0) OR SW(1) );
LED(4) <= SW(0) XOR SW(1);
LED(5) <= NOT ( SW(0) XOR SW(1) );
LED(6) <= NOT SW(1);

end Behavioral;
