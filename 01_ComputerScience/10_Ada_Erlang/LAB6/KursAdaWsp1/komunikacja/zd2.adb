-- idzad.adb

with Ada.Text_IO;
use Ada.Text_IO;

-- import random generator library
with Ada.Numerics.Integer_Random;
use Ada.Numerics.Integer_Random; 

procedure Zd2 is

RNG : Generator; 

task type Zadanie is
  entry UtworzLosowo(input: Integer);	
end Zadanie	;

task body Zadanie is	
begin
  accept UtworzLosowo(input: Integer) do
    Moj_Id := Id;
  end UtworzLosowo; 	
  Put_Line("Moje Id = " & Moj_Id'Img);  
end Zadanie;

subtype Zakres is Integer range 1..10; 
Zadania: array(Zakres) of Zadanie;

begin
  Put_Line("P_PG ");
  for I in Zakres loop
  	Zadania(I).UtworzLosowo(I);  			
  end loop;
  Put_Line("K_PG ");

end Zd2;
	  	