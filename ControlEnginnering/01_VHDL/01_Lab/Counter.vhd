
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Counter is
    Port ( CLK : in STD_LOGIC; -- input Clock
           SW : in STD_LOGIC;  -- Choose counter direction
           LED : out STD_LOGIC_VECTOR (7 downto 0)); -- Display counted impulses 
end Counter; -- RESET signal can be added if wanted


architecture Behavioral of Counter is

signal CLK_OUT : STD_LOGIC;
signal count : STD_LOGIC_VECTOR ( 7 downto 0 ) := "00000000";

begin

-- the following process is supposed to transform input clock frequency
-- into output frequency. In this case input frequency is 100 MHz
-- and output frequency is 1 Hz 
process(CLK) -- process 'frequency divider' : if not needed make a comment line 52 to 66 
variable cnt : integer;     
begin
    if(CLK'Event AND CLK = '1') then
        if( cnt < 500000000 ) then -- fin / fout = 100 MHz / 1 Hz = 100 M -> 100 M / 2 - 1 = 49999999
            cnt := 0;
            CLK_OUT <= '1';
         else
             cnt := cnt + 1;
             CLK_OUT <= '0';
        end if;
    end if;
end process;  

-- the following process is supposed to be a counter that can 
-- count up and down depending on state of a switch signal SW 

process( CLK_OUT, SW)
begin 
  if( CLK_OUT'Event AND CLK_OUT = '1') then
    if ( SW = '1' AND count < "11111111" ) then 
        count  <= count + '1';
    elsif ( SW = '0' AND count > "00000000" ) then 
        count <= count - '1';
    end if;
    end if;
end process; 

LED <= count; -- In case it does not work try the following
              -- LED <= not coun        
    
end Behavioral;
