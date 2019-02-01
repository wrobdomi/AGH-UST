library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Diody_tb is
--  Port ( );
end Diody_tb;

architecture Behavioral of Diody_tb is
component Diody 
Port ( SW : in STD_LOGIC_VECTOR (15 downto 0);
           LED : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal SW_tb : STD_LOGIC_VECTOR ( 15 downto 0);
signal LED_tb : STD_LOGIC_VECTOR ( 15 downto 0);

begin
    mapping : Diody port map ( SW => SW_tb,
                               LED => LED_tb
                              );
process
begin
    SW_tb <= "0101010111111111";
    wait for 1 ns;
    SW_tb <= "1111111100001111";
    wait for 1 ns;
    SW_tb <= "1010101010101010";
    wait for 1 ns;
end process;
end Behavioral;
