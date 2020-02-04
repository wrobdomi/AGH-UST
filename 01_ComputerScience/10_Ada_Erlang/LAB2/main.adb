with Ada.Text_IO,Ada.Float_Text_IO;
use Ada.Text_IO,Ada.Float_Text_IO;

with Ada.Calendar;
use Ada.Calendar;

with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;




procedure Main is

T1, T2: Time; -- czasy bezwzgledne
D: Duration;  -- czas względny,
-- miejsce na deklaracje
-- Podpukt 1 - Zadeklaruj typ...
type Vector is array (Integer range<>) of Float;
-- Podpunkt 2 - Zadeklaruj i zainicjalizuj...
myVector : Vector := (5.0, 7.4, 3.5, 3.0, 5.5, 7.1, 3.9);

-- Podpunkt 3 - Napisz procedure wypisujaca...
procedure printVector(v: in out Vector) is
begin
	Put("Vector( ");
	for I in v'First..v'Last loop
		Put(v(I)'Image);
	end loop;
	Put(" )");
	New_Line;
end printVector;

-- Podpunkt 4 - Napisz procedure wypelniajaca wektor losowymi...
procedure fillVectorWithRandom(v: in out Vector) is
	ranFloat: Float := 0.0;
	Gen: Generator; -- z pakietu Ada.Numerics.Float_Random
begin
	Reset(Gen);
	for I in v'First..v'Last loop
		ranFloat := Random(Gen);
		v(i) := ranFloat;
	end loop;
end fillVectorWithRandom;

-- Podpunkt 5 - Napisz funkcje sprawdzajaca posortowanie rosnace...
function checkIfSorted(v: in Vector) return Boolean is
begin
	return (for all I in v'First..(v'Last-1) => v(I) <= v(I+1));
end checkIfSorted;


-- Podpunkt 6 - Napisz funkcje sortujaca...
procedure insertionSortVector(v: in out Vector) is
      insertedValue: Float := 0.0;
      index: Integer := 0;
begin
      for I in (v'First+1)..v'Last loop
         insertedValue := v(I);
         index := I - 1;
         -- Put(I'Image);
         while index > v'First and v(index) > insertedValue loop
            v(index+1) := v(index);
            index := index - 1;
         end loop;
         v(index+1) := insertedValue;
      end loop;
end insertionSortVector;




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
