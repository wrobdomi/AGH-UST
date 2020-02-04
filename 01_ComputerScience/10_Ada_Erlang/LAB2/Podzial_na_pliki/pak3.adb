package body pak3 is

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

end pak3;
