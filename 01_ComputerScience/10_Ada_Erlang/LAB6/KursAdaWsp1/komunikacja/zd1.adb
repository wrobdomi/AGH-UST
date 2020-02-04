-- spotkania2.adb

with Ada.Text_IO;
use Ada.Text_IO;

-- import random generator library
with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random; 

-- import funkcji matematycznych
with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

procedure Zd1 is
	
RNG : Generator; 

task GenerowaniePunktow is
  entry Start;  	
end GenerowaniePunktow;

task Obliczenia is 
  entry Start;
  entry Koniec;
  entry We(X:Float; Y:Float);
end Obliczenia;

task body GenerowaniePunktow is
	X: Float;
	Y: Float;
begin
  accept Start;
  for K in 1..10 loop
	  X := Random(RNG);
	  Y := Random(RNG);	
	  Obliczenia.We(X, Y);
  end loop;	  
  Obliczenia.Koniec;
end GenerowaniePunktow;

task body Obliczenia is
  odlegloscOdPoczatku: Float;
  odlegloscPomiedzyKolejnymi: Float;
  xPoprzedni: Float := 0.0;
  yPoprzedni: Float := 0.0;
begin
  accept Start;
  loop
    select 
     accept We(X: in Float; Y: in Float) do
	     odlegloscOdPoczatku := SQRT(X**2+Y**2);
		 odlegloscPomiedzyKolejnymi := SQRT((X-xPoprzedni)**2+(Y-ypoprzedni)**2);
		 xPoprzedni := X;
		 yPoprzedni := y;
     end We;
	   Put_Line("Odleglosc od poczatku=" & odlegloscOdPoczatku'Img);
	   Put_Line("Odleglosc pomiedzy kolejnymi=" & odlegloscPomiedzyKolejnymi'Img);
	   Put_Line("...");
    or 
	   accept Koniec;
 	   exit;
    end select;
  end loop;
  
  Put_Line("Koniec obliczen");
end Obliczenia;

begin
  GenerowaniePunktow.Start;
  Obliczenia.Start; 
  Put_Line("Koniec_PG "); 
end Zd1;
	  	