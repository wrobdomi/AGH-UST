% Predykat =..

?- A =.. [ala, ma, asa].
A = ala(ma, asa).

?- ala(ma,kota,w(ciapki(rozowe))) =.. A.
A = [ala, ma, kota, w(ciapki(rozowe))].


% Predykat functor

?- functor(ala(ma,kota),F,A).
F = ala,
A = 2.

?- CzyTo = ala, OLiczbie = 2, functor(ala(ma,kota),CzyTo,OLiczbie).
CzyTo = ala,
OLiczbie = 2.

?- CzyTo = kasia, OLiczbie = 2, functor(ala(ma,kota),CzyTo,OLiczbie).
false.

?- functor(ala(ma,kota),F,_), write('To jest funktor \''), write(F), write('\'').
To jest funktor 'ala'
F = ala.

?- functor(A, riverside, 3).
A = riverside(_G1748, _G1749, _G1750).


% Predykat arg

?- arg(X,ala_ma(kota,psa,schiza),A).
X = 1,
A = kota ;
X = 2,
A = psa ;
X = 3,
A = schiza.

?- arg(2,ala_ma(kota,psa,schiza),A).
A = psa.

?- functor(A, riverside, 4), arg(1,A,voices), arg(4,A,head).
A = riverside(voices, _G2065, _G2066, head).


