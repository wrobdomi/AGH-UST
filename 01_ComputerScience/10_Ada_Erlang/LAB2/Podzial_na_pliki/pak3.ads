with Ada.Text_IO,Ada.Float_Text_IO;
use Ada.Text_IO,Ada.Float_Text_IO;

with Ada.Calendar;
use Ada.Calendar;

with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

package pak3 is

   T1, T2: Time; -- czasy bezwzgledne
   D: Duration;  -- czas względny,
   -- miejsce na deklaracje
   -- Podpukt 1 - Zadeklaruj typ...
   type Vector is array (Integer range<>) of Float;
   -- Podpunkt 2 - Zadeklaruj i zainicjalizuj...
   myVector : Vector := (5.0, 7.4, 3.5, 3.0, 5.5, 7.1, 3.9);


   -- Podpunkt 3 - Napisz procedure wypisujaca...
   procedure printVector(v: in out Vector);

   procedure fillVectorWithRandom(v: in out Vector);

   function checkIfSorted(v: in Vector) return Boolean;

   procedure insertionSortVector(v: in out Vector);


end pak3;
