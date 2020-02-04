with Ada.Text_IO,Ada.Float_Text_IO;
use Ada.Text_IO,Ada.Float_Text_IO;

with Ada.Calendar;
use Ada.Calendar;

with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

with pak3;
use pak3;


procedure Main is

begin
   -- Podpunkt 7 - Dopisz do programu instrukcje do pomiaru czasu...
   T1 := Clock;
   Put_Line("Rozwiazania zadan");
   printVector(myVector);
   fillVectorWithRandom(myVector);
   printVector(myVector);
   Put_Line("Wektor posortowany rosnaco:");
   Put_Line(checkIfSorted(myVector)'Image);
   insertionSortVector(myVector);
   printVector(myVector);
   Put_Line("Wektor posortowany rosnaco:");
   Put_Line(checkIfSorted(myVector)'Image);
   T2 := Clock;
   D := T2 - T1;
   Put_Line("Czas obliczen = " & D'Img & "[s]");
end Main;
