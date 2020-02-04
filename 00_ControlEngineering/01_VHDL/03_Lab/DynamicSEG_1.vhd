library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DynamicSEG_1 is 
-- Deklaracja sygna��w wej�ciowych i wyj�ciowych      
Port (    CLK100MHZ: in STD_LOGIC;    
SEG: inout STD_LOGIC_VECTOR (7 downto 0);    
AN : inout STD_LOGIC_VECTOR (7 downto 0)    
);     
end DynamicSEG_1; 
 
architecture behavioral of DynamicSEG_1 is 
 
variable count_clk : integer := 0; -- Zmienna do liczenia  
 
begin           
if (rising_edge(CLK100MHZ)) then         
    if (count_clk < 125000) then -- Przez dan� cz�� czasu                  
        count_clk := count_clk + 1; -- Zwi�kszamy licznik                
        SEG <= "10101010";  -- Ustawiamy dane diody na wy�wietlaczu nr 1                  
        AN <= "11111110";             
    elsif (counter < 250000) then                 
        count_clk := count_clk + 1;                 
        SEG <= "01010101";                 
        AN <= "11111101"; -- Nast�pnie na wy�wietlaczu nr 2 itd.              
    elsif (counter < 375000) then 
-- Cz�stotliwo�� zmian jest na tyle szybka, �e oko nie widzi r�nicy w zmianach    
        count_clk := count_clk + 1; -- kt�re zachodz� pomi�dzy wy�wietlaczami i wszystko wida� jakby   
        SEG <= "11110000"; -- by�o wy�wietlane statycznie                  
        AN <= "11111011"; 
    elsif (counter < 500000) then                 
        count_clk := count_clk + 1;                 
        SEG <= "00001111";                 
        AN <= "11110111";             
    else                 
        count_clk := 0;             
    end if;         
end if;           

end process;   
 
end behavioral; 
