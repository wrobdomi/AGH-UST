nalezy(X,[X|_]).
nalezy(X,[_|Yogon]) :-
	nalezy(X,Yogon).

dlugosc([],0).
dlugosc([_|Ogon],Dlug) :-
	dlugosc(Ogon,X),
	Dlug is X+1.

a2b([],[]).
a2b([a|Ta],[b|Tb]) :-
	a2b(Ta,Tb).

sklej([],X,X).
sklej([X|L1],L2,[X|L3]) :-
	sklej(L1,L2,L3).

nalezy1(X,L) :-
	sklej(_,[X|_],L).

ostatni(Element,Lista) :-
	sklej(_,[Element],Lista).

dodaj(X,L,[X|L]).

usun(X, [X|Reszta], Reszta).
usun(X, [Y|Ogon], [Y|Reszta]) :-
	usun(X,Ogon,Reszta).

wstaw(X,L,Duza) :-
	usun(X,Duza,L).

nalezy2(X,L) :-
	usun(X,L,_).

zawiera(S,L) :-
	sklej(_,L2,L),
	sklej(S,_,L2).





usunTrzyOstatnie(L,L1) :-
	sklej(L1,[_,_,_],L).

usunTrzyPierwsze(L,L1) :-
	sklej([_,_,_|L1], [], L).

usunTrzyPierwszeOstatnie(L,L1) :-
	sklej([_,_,_|L1], [_,_,_], L). 

parzyste([]).
parzyste([X|Yogon]) :-
	nieparzyste(Yogon).

nieparzyste([_]).
nieparzyste([X|Yogon]) :-
	parzyste(Yogon).

palindrom(L1) :-
	odwroc(L1,W),
	L1 = W.

przesun([X|Yogon],L2) :-
	sklej(Yogon, [X], L2).

znaczy(0,zero).
znaczy(1,jeden).
znaczy(2,dwa).
znaczy(3,trzy).
znaczy(4,cztery).
znaczy(5,piec).
znaczy(6,szesc).
znaczy(7,siedem).
znaczy(8,osiem).
znaczy(9,dziewiec).

przeloz([],[]).

przeloz([Glowa|Ogon],[X|Y]) :-
	znaczy(Glowa,X),
	przeloz(Ogon,Y).

podziel([X],[X], []).
podziel([X|Yogon], [X|L1], L2) :-
	podziel(Yogon, L2, L1).


podzbior(X,[]).

podzbior([G|O],[G|O1]) :-
	podzbior(O,O1).

podzbior([G|O],L1) :-
	podzbior(O,L1).

moneta(1).
moneta(2).
moneta(5).
moneta(10).

rozmien2(0, []).

rozmien2(Kwota, [M|Yogon]) :-
	moneta(M),
	R is Kwota - M,
	R >= 0,
	rozmien2(R,Yogon).