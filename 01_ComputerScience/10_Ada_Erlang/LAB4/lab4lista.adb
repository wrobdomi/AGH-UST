with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

with Ada.Numerics.Discrete_Random;


procedure Lab4Lista is

   package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
   use Random_Int;
   
   Gen: Generator;
   
type Element is
  record 
    Data : Integer := 0;
    Next : access Element := Null;
  end record; 

  -- deklaracja wskaznika slowem access
  -- access / acceess all (zwalnianie pamieci + mozna zmienic wartosc, najczesciej stosowane) 
  -- / access consant (bez zmiany wartosci)
   type Elem_Ptr is access all Element;
   
   foundElement : Elem_Ptr := Null;
   removed1: Boolean;
   removed2: Boolean;

procedure Print(List : access Element) is
  L : access Element := List;
begin
  if List = Null then
    Put_Line("List EMPTY!");
  else
    Put_Line("List:"); 
  end if; 
  while L /= Null loop
    Put(L.Data, 4); -- z pakietu Ada.Integer_Text_IO
    New_Line;
    L := L.Next;
  end loop; 
end Print;

-- Wstawianie na poczatek listy
procedure Insert(List : in out Elem_Ptr; D : in Integer) is
  E : Elem_Ptr := new Element; 
begin
  E.Data := D;
  E.Next := List;
  -- lub E.all := (D, List);
  List := E;
end Insert;

-- wstawianie jako funkcja - wersja krótka
function Insert(List : access Element; D : in Integer) return access Element is 
  ( new Element'(D,List) ); 


-- do napisania !! 
procedure Insert_Sort(List : in out Elem_Ptr; D : in Integer) is 
	E : Elem_Ptr := List;
	Eprev : Elem_Ptr := List; 
	Enew : Elem_Ptr := new Element'(D, Null);
begin
	-- napisz procedurę wstawiającą element zachowując posortowanie (rosnące) listy
	if List = Null then
		Insert(List, D);
	elsif D < E.Data then
		Insert(List, D);
	else
		while E /= Null loop
			-- Put_Line("AA");
			if D > E.Data then
				-- Put_Line("B");
				Eprev := E;
				E := E.Next;
			else 
				-- Put_Line("C");
				Enew.Next := E; 
				Eprev.Next := Enew;
				exit;
			end if;
			if E = Null then
				Enew.Next := Null;
				Eprev.Next := Enew;
				exit;
			end if;
		end loop;
	end if;

	
	
	
	
null;
end Insert_Sort;
   
   
   
procedure generate_Random(List : in out Elem_Ptr; M : in Integer; N : in Integer) is 
    ranVal: Integer := 0;  
begin      
      for I in 1..N loop
         ranVal := Random(Gen) mod M;
         Insert_Sort(List, ranVal);
      end loop;
end generate_Random;      

   
function searchList(List : in Elem_Ptr; findIt : in Integer) return Elem_Ptr is
E : Elem_Ptr := List;
begin
      while E /= Null loop
         if E.Data = findIt then
            return E;
         else 
            E := E.Next;
         end if;
      end loop;
      return Null;
end searchList;
   
function deleteElement(List : in out Elem_Ptr; deleteIt : in Integer) return Boolean is
      Current: Elem_Ptr := List;
      Previous: Elem_Ptr := Null;
     
 begin
      if Current = Null then
         return False;
      end if;
      
      if Current.Data = deleteIt then
         List := List.Next;
         Put_Line("Element removed");
         return True;
      end if;
      
      Previous := Current;
      Current := Current.Next;
      while Current /= Null loop
         if Current.Data = deleteIt then
            Previous.Next := Current.Next;
             Put_Line("Element removed");
            return True;
         end if;
         Previous := Current;
         Current := Current.Next;
      end loop;
         
      Put_Line("Element not found");
      return False;
      
end deleteElement;

Lista : Elem_Ptr := Null;

begin
	-- Print empty list
  Print(Lista);
  
  -- Insert first element
  Insert_Sort(Lista, 5);
  Print(Lista);
  
  
  Insert_Sort(Lista, 21);
  Print(Lista);
  
  Insert_Sort(Lista, 20); 
  Print(Lista);
  
  -- Insert first element
  Insert_Sort(Lista, 3);
  Print(Lista);
  
   -- Generate random values
  generate_Random(Lista, 20, 5);
   Print(Lista);
   
   -- Find values
   foundElement := searchList(Lista, 20);
   if foundElement = Null then
      Put_Line("Element not found !");
   else
      Put_Line("Element found !");
   end if;
   foundElement := searchList(Lista, 60);
   if foundElement = Null then
      Put_Line("Element not found !");
   else
      Put_Line("Element found !");
   end if;
   
   -- Removing elements
   removed1 := deleteElement(Lista, 5);
   Print(Lista);
   removed2 := deleteElement(Lista, 60);
   Print(Lista);
   
   
  
end Lab4Lista;
