----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2017 16:03:03
-- Design Name: 
-- Module Name: Licznik7SG - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Licznik7SG is
Port ( 
    SEG : out STD_LOGIC_VECTOR( 7 downto 0 );
    AN : inout STD_LOGIC_VECTOR(7 downto 0);
    CLK100MHZ : in STD_LOGIC
    );
end Licznik7SG;

architecture Behavioral of Licznik7SG is

shared variable count : INTEGER := 0;
shared variable bcd_v : STD_LOGIC_VECTOR( 3 downto 0) := "0000";
shared variable bcd1 : STD_LOGIC_VECTOR( 3 downto 0) := "0000";
shared variable bcd2 : STD_LOGIC_VECTOR( 3 downto 0) := "0000";
shared variable bcd3 : STD_LOGIC_VECTOR( 3 downto 0) := "0000";
shared variable seg_v : STD_LOGIC_VECTOR( 7 downto 0) := "00000000";
signal flag1 : STD_LOGIC;
signal flag2 : STD_LOGIC;
signal flag3 : STD_LOGIC;


procedure CONV_BCD_7SEG( variable BCD_NUM : in STD_LOGIC_VECTOR(3 downto 0);
                         variable SEG_NUM : out STD_LOGIC_VECTOR(7 downto 0)
                          ) is
begin             -- BCD CODE         -- 7 SEG CODE
  if     BCD_NUM = "0000" then SEG_NUM := "11000000";    --0    7 SEG DISPLAY VECTOR IS " DP GFEDCBA "
  elsif  BCD_NUM = "0001" then SEG_NUM := "11111001";    --1          A
  elsif  BCD_NUM = "0010" then SEG_NUM := "10100100";    --2       -------
  elsif  BCD_NUM = "0011" then SEG_NUM := "10110000";    --3     F |     | B
  elsif  BCD_NUM = "0100" then SEG_NUM := "10011001";    --4       |  G  |
  elsif  BCD_NUM = "0101" then SEG_NUM := "10010010";    --5       -------
  elsif  BCD_NUM = "0110" then SEG_NUM := "10000010";    --6     E |     | C
  elsif  BCD_NUM = "0111" then SEG_NUM := "11111000";    --7       |     |   --
  elsif  BCD_NUM = "1000" then SEG_NUM := "10000000";    --8       -------   -- DP
  elsif  BCD_NUM = "1001" then SEG_NUM := "10010000";    --9          D
  else SEG_NUM := "01110111"; -- DOT      
  end if;     
  
end CONV_BCD_7SEG;
                         

begin

process(CLK100MHZ, flag1, flag2, flag3) 
begin


    if( rising_edge(CLK100MHZ) )then
        if( count < 100000000 ) then
            count := count + 1;
        end if;
        if ( count = 100000000 ) then
            bcd_v := bcd_v + 1;
        if(bcd_v < 10) then
            CONV_BCD_7SEG(bcd_v, seg_v);
            AN <= "11111110";
            SEG <= seg_v;
            flag1 <= '0';
         end if;
         if(bcd_v = 10) then
            bcd_v := "0000";
            CONV_BCD_7SEG(bcd_v, seg_v);
            AN <= "11111110";
            SEG <= seg_v;
            flag1 <= '1';
         end if;
        end if;
      end if;
        
        if( rising_edge(flag1) ) then
            bcd1 := bcd1 + 1;
            bcd_v := "0000";
            if(bcd1<10) then
                CONV_BCD_7SEG(bcd1, seg_v);
                AN <= "11111101";
                SEG <= seg_v;
                flag2 <= '0';
            end if;
            if(bcd1 = 10) then
                bcd1 := "0000";
                CONV_BCD_7SEG(bcd1, seg_v);
                AN <= "11111101";
                SEG <= seg_v;
                flag2 <= '1';
            end if;
        end if;
        
        if( rising_edge(flag2) ) then
            bcd2 := bcd2 + 1;
            bcd1 := "0000";
            if(bcd2<10) then
                CONV_BCD_7SEG(bcd2, seg_v);
                AN <= "11111011";
                SEG <= seg_v;
                flag3 <= '0';
             end if;
             if(bcd2 = 10) then
                bcd2 := "0000";
                CONV_BCD_7SEG(bcd2, seg_v);
                AN <= "11111011";
                SEG <= seg_v;
                flag3 <= '1';
              end if;
        end if;
        
        if( rising_edge(flag3) ) then
            bcd3 := bcd3 + 1;
            bcd2 := "0000";
            if(bcd3<10) then
                CONV_BCD_7SEG(bcd3, seg_v);
                AN <= "11110111";
                SEG <= seg_v;
            end if;
            if(bcd3 = 10) then
                bcd3 := "0000";
                CONV_BCD_7SEG(bcd3, seg_v);
                AN <= "11110111";
                SEG <= seg_v;
            end if;
         end if;
        

end process;

end Behavioral;
