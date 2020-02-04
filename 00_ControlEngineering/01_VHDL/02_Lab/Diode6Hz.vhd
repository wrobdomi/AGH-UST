library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Counter is
    Port ( CLK100MHZ : in STD_LOGIC; -- input Clock
           LED : out STD_LOGIC_VECTOR (15 downto 0 )
           ); 
end Counter; 


architecture Behavioral of Counter is

signal count : STD_LOGIC_VECTOR ( 23 downto 0 ) := "000000000000000000000000";

begin

process(CLK100MHZ) 
  
begin
    if( rising_edge(CLK100MHZ) )then
        count <= count + '1';
    end if;
end process;  


LED <= count(23 downto 8);       
    
end Behavioral;
