library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Diody is
    Port ( SW : in STD_LOGIC_VECTOR (15 downto 0); -- Pamiêtaæ, ze tu ma byæ inout
           LED : out STD_LOGIC_VECTOR (15 downto 0));
end Diody;

architecture Behavioral of Diody is
begin
LED <= SW;

end Behavioral;
