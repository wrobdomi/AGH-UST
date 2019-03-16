----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.10.2017 10:04:07
-- Design Name: 
-- Module Name: Project1 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Project1 is
    Port ( SEG : inout STD_LOGIC_VECTOR (7 downto 0);
           AN : inout STD_LOGIC_VECTOR (7 downto 0));
end Project1;

architecture Behavioral of Project1 is

begin
SEG <= "10000010";
AN <= "11111110";

end Behavioral;

