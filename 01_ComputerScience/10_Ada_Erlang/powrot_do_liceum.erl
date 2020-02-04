-module(powrot_do_liceum).
-export([pole/1, objetosc/1, len/1, amin/1, myMin/2, amax/1, myMax/2, konwTemp/2]).
 
pole({kwadrat,X,Y}) ->  X*Y;
pole({kolo,X}) -> 3.14*X*X;

% dodane pola i objetnosci
pole({trojkat,A,H}) -> 0.5*A*H;
pole({trapez,A,B,H}) -> 0.5*(A+B)/H.

% obliczanie objetosci bryl 
objetosc({kula, R}) -> (4/3)*3.14*R*R*R;
objetosc({szescian, A}) -> A*A*A;
objetosc({prostopadloscian, A, B, H}) -> A*B*H;
objetosc({walec, R, H}) -> 3.14 * R * R * H.

% oblicz dlugosc listy
len([]) -> 0;
len([H|T]) -> 1 + len(T).

% najmniejszy element listy

amin([H|T]) -> myMin(H, T).

myMin(Min, [H|T]) when Min < H -> myMin(Min, T);
myMin(Min, [H|T]) when Min >= H -> myMin(H, T);
myMin(Min, []) -> Min.

% najwiekszy element listy

amax([H|T]) -> myMax(H, T).

myMax(Max, [H|T]) when Max > H -> myMax(Max, T);
myMax(Max, [H|T]) when Max =< H -> myMax(H, T);
myMax(Max, []) -> Max.


% konwersja temperatury
konwTemp({from, value}, to) ->
	case from of 
		'k' ->
			case to of
				'c' -> value + 173;
				'f' -> value - 173
			end;
		'c' -> 
			case to of
				'k' -> value + 173;
				'f' -> value - 173
			end;
		'f' -> 
			case to of
				'k' -> value + 173;
				'f' -> value - 173
			end
	end.
				



% sortowanie przez wstawianie
