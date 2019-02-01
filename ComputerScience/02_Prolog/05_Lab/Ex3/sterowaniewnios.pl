% Zastosowanie cut:

c(1).
c(2).

a(X) :- c(X), !.

?- a(X), write(X), fail.
1
false.

% Dla porownania bez cat: 

c(1).
c(2).

a(X) :- c(X).


?- a(X), write(X), fail.
12
false.


% Cut odcina mozliwosc cofania sie programu do predykatow
% ktore sa przed nim

[trace]  ?- a(1).
   Call: (7) a(1) ? creep
   Call: (8) c(1) ? creep
   Exit: (8) c(1) ? creep
   Call: (8) d(1) ? creep
   Fail: (8) d(1) ? creep
   Fail: (7) a(1) ? creep
false.

[trace]  ?- a(2).
   Call: (7) a(2) ? creep
   Call: (8) c(2) ? creep
   Exit: (8) c(2) ? creep
   Call: (8) d(2) ? creep
   Exit: (8) d(2) ? creep
   Exit: (7) a(2) ? creep
true.

[trace]  ?- a(X).
   Call: (7) a(_G1266) ? creep
   Call: (8) c(_G1266) ? creep
   Exit: (8) c(1) ? creep
   Call: (8) d(1) ? creep
   Fail: (8) d(1) ? creep
   Fail: (7) a(_G1266) ? creep
false.



% Pomimo wolania fail i ponowenego wejscia w a, nie mozna zmienic wartosci X
c(1).
c(2).
c(3).
d(1).
d(2).
d(3).

a(X,Y) :- c(X), !, d(Y).

?- a(X,Y), write('X = '), write(X), write(', Y = '), writeln(Y),  fail.
X = 1, Y = 1
X = 1, Y = 2
X = 1, Y = 3
false.


% Testowanie predykatu nalezy

nalezy(X, [X|Reszta]) :- write(X).

nalezy(Element, [_|Ogon]) :-
	nalezy(Element, Ogon).
	
?- nalezy(a,[a,b,c]),fail.
a
false.

?- nalezy(a,[a,b,a,c]),fail.
aaaaa
false.

% uzywajac cut: 

nalezy(X, [X|Reszta]) :- !, write(X).

nalezy(Element, [_|Ogon]) :-
	nalezy(Element, Ogon).
	
?- nalezy(a,[a,b,c]),fail.
a
false.

?- nalezy(a,[a,b,a,c]),fail.
aaa
false.

% predykat max z uzyciem i bez uzycia cut
% W pierwszym przypadku zawsze wykonają się dwa predykaty
% w drugium wykona się tylko pierwsze jeśli X >= Y
max1(X,Y,X) :- X >= Y.
max1(X,Y,Y) :- X < Y.

max2(X,Y,X) :- X >= Y, !.
max2(_,Y,Y).

[trace]  ?- max1(2,3,X).
   Call: (7) max1(2, 3, _G2123) ? creep
   Call: (8) 2>=3 ? creep
   Fail: (8) 2>=3 ? creep
   Redo: (7) max1(2, 3, _G2123) ? creep
   Call: (8) 2<3 ? creep
   Exit: (8) 2<3 ? creep
   Exit: (7) max1(2, 3, 3) ? creep
X = 3.

[trace]  ?- max2(2,3,X).
   Call: (7) max2(2, 3, _G2123) ? creep
   Call: (8) 2>=3 ? creep
   Fail: (8) 2>=3 ? creep
   Redo: (7) max2(2, 3, _G2123) ? creep
   Exit: (7) max2(2, 3, 3) ? creep
X = 3.