nalezy1(X,[X|_]) :- write(X).
nalezy1(X,[_|O]) :- 
	nalezy1(X,O).

nalezy2(X,[X|_]) :- !, write(X).
nalezy2(X,[_|O]) :- 
	nalezy2(X,O).

max1(X,Y,X) :- X >= Y.
max1(X,Y,Y) :- X < Y.

max2(X,Y,X) :- X >= Y, !.
max2(_,Y,Y).

not(P) :- P,!,fail.
not(_).
