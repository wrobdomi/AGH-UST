-- prot3.adb
-- komunikacja asynchroniczna przez bufor
-- kolejka FIFO

with Ada.Text_IO;
use Ada.Text_IO;

procedure Prot3 is
 	
type MyCharArray is array (1 .. 5) of Character; 
type MyChars is array (1 .. 10) of Character;

-- obiekt chroniony 
protected Buf is
  entry Wstaw(C : Character);
  entry Pobierz(C : out Character);
  private
   CurrentIndex : Integer := 0;
   BufforMax : Integer := 5;
   Bc : MyCharArray;
end Buf;

protected body Buf is
  entry Wstaw(C : Character) when CurrentIndex /= BufforMax is
  begin
	CurrentIndex := CurrentIndex + 1;
    Bc(CurrentIndex) := C;
  end Wstaw;
  entry Pobierz(C : out Character) when CurrentIndex /= 0 is
  begin
    C := Bc(CurrentIndex);
	CurrentIndex := CurrentIndex - 1;
  end Pobierz;
end Buf;
  


task Producent; 

task body Producent is
  Cl : Character := 'a';
  myCharsArr : MyChars := ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j');
begin
	for I in myCharsArr'Range loop   
  		Put_Line("$ wstawiam: znak = '" & myCharsArr(I) & "'");
  	  	Buf.Wstaw(myCharsArr(I));
  	  	Put_Line("$ wstawiłem...");
	end loop;
end Producent;


task Konsument; 

task body Konsument is
  Cl : Character := ' ';
begin  
	for I in Integer range 0 .. 10 loop  
  		Put_Line("# pobiorę...");
  		Buf.Pobierz(Cl);
  		Put_Line("# pobrałem: znak = '" & Cl & "'" );
  	end loop;
end Konsument;

begin
  Put_Line("@ jestem w procedurze glownej");
end Prot3;
  