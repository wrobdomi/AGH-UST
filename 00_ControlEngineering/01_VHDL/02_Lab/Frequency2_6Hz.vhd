library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Counter is
    Port ( CLK100MHZ : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (15 downto 0)
           );
end Counter; 

architecture Behavioral of Counter is
begin

process(CLK100MHZ) 
  
variable count : integer := 0 ;

begin
    if( rising_edge(CLK100MHZ) )then
        if( count < 8333333 ) then
            count := count + 1;
            LED <= "0000000000000000";
        elsif ( count < 16666666 ) then
            count := count +1;
            LED <= "1111111111111111";
        else
            count := 0;
    end if;
    end if;
end process;

end Behavioral;
