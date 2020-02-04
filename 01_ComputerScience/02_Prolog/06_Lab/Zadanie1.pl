% Zadanie1

% Predykat var
var(X). 	% true, bo X nie ma ustalnej wartości
nonvar(X). 	% false, bo X nie ma ustalonej wartości 
var(X),X=2.	% true, bo najpierw jest wolane var(X), wtedy jeszcze
	   	% X nie ma wartosci
X=2,var(X). 	% false bo X ma wartosc 2

% Predykat atom
?- atom(X).
false.

?- atom(3).
false.

?- atom(a).
true.

?- atom(+).
true.

?- atom(:=).
true.

?- atom('ala').
true.

% Predykat atomic
?- atomic(a).
true.

?- atomic(3).
true.

?- atomic(+).
true.

?- atomic(X).
false.

% Predykat number
?- number(ala).
false.

?- number(3).
true.

?- number(3.13).
true.

% Predykat integer
?- integer(3).
true.

?- integer(3.14).
false.

?- integer(ala).
false.

% Predykat float
?- float(3).
false.

?- float(3.14).
true.

?- float(ala).
false.

% Predykat compound
[trace]  ?- compound(ala).
false.

[trace]  ?- compound(ala(ma,kota)).
true.

[trace]  ?- compound(3).
false.

[trace]  ?- compound([]).
false.

[trace]  ?- compound([1]).
true.

