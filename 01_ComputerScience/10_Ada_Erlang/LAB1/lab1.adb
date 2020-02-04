-- Lab1.adb
-- komentarz do konca linii

-- wykorzystany pakiet 
with Ada.Text_IO;
use Ada.Text_IO;

-- procedura glowna - dowolna nazwa (ale taka jak nazwa pliku)
procedure Lab1 is

-- czesc deklaracyjna  
  
  -- funkcja - forma pelna
  function Max2(A1, A2 : in Float ) return Float is
  begin
    if A1 > A2 then return A1;
    else return A2; 
    end if;
  end Max2;    

  -- funkcja wyrazeniowa 
  -- forma uproszczona funkcji
  -- jej tresc jest tylko wyrazeniem w nawiasie   
  
  function Add(A1, A2 : Float) return Float is
    (A1 + A2);
       
  function Max(A1, A2 : in Float ) return Float is
     (if A1 > A2 then A1 else A2);    
   
  -- Fibonacci      
  function Fibo(N : Natural) return Natural is   
    (if N = 0 then 1 elsif N in 1|2 then  1 else Fibo(N-1) + Fibo(N-2) );   
  
    -- procedura 
    -- zparametryzowany ciag instrukcji  
  procedure Print_Fibo(N: Integer) is
  begin
    if N <1 or N>46 then raise Constraint_Error;
    end if;
    Put_Line("Ciag Fibonacciego dla N= " & N'Img);
    for I in 1..N loop
      Put( Fibo(I)'Img & " " );
    end loop;   
    New_Line;
  end Print_Fibo;    
   
    -- Obliczanie sredniej
   function Mean(A1, A2: in Float ) return Float is
      ((A1 + A2) / 2.0);
    
   -- Obliczanie silni iteracyjnie
   function Silnia(A1: in Integer) return Integer is
      Tmp: Integer := 1;
   begin
      if A1 <= 0 then
         return Tmp;
      end if; 
      for I in 1..A1 loop
         Tmp := Tmp * I;
      end loop;
      return Tmp;
   end Silnia;
   
   -- Obliczanie silni rekurencyjnie
   function SilniaRekurencyjnie(A1: in Integer) return Integer is
   Tmp: Integer;
   begin
      if A1 = 0 then
         return 1;
      end if;
      Tmp := A1 * SilniaRekurencyjnie(A1 - 1);
      return Tmp;
   end SilniaRekurencyjnie;
   
-- ponizej tresc procesury glownej   
begin
  Put_Line("Suma = " & Add(3.0, 4.0)'Image ); 
  Put_Line( "Max =" & Max(6.7, 8.9)'Img);
  Put_Line( "Max2 =" & Max2(6.7, 8.9)'Img);
  Print_Fibo(12);
  Put_Line("Srednia liczb 10.0 i 7.0 to " &Mean(10.0, 7.0)'Image); 
  Put_Line("Silnia iteracyjnie liczby 4 to " & Silnia(4)'Image); 
  Put_Line("Silnia rekurencyjnie liczby 4 to " & SilniaRekurencyjnie(4)'Image); 
end Lab1;  
