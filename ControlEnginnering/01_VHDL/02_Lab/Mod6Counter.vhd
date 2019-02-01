library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Counter is
    Port ( CLK100MHZ : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR ( 15 downto 0 );
           SW : in STD_LOGIC_VECTOR ( 15 downto 0 )
        );
end Counter;

architecture Behavioral of Counter is

signal counter : STD_LOGIC_VECTOR ( 15 downto 0 ) := "0000000000000000";

begin

process(CLK100MHZ) 
  
variable count : integer := 0 ;
variable count_out : integer := 0 ;

begin
    if( rising_edge(CLK100MHZ) )then
        if( count < 8333333 ) then
            count := count + 1;
            count_out := 0;
        elsif ( count < 16666666 ) then
            count := count + 1;
            count_out := 1;
        else
            count := 0;
        end if;
    end if;
    
    if ( SW(0) = '1' ) then
        counter <= "0000000000000000";
    elsif( count_out = 1 AND count = 8333334 ) then
        counter <=  counter + '1';    
    end if;
    

end process;

LED <= counter;

end Behavioral;
