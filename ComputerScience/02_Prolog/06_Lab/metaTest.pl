?- listing(kobieta).
kobieta(kasia).
kobieta(ania).
kobieta(basia).
kobieta(gosia).

true.

?- call(kobieta(X)).
X = kasia ;
X = ania ;
X = basia ;
X = gosia.

?- clause(kobieta(X),B).
X = kasia,
B = true ;
X = ania,
B = true ;
X = basia,
B = true ;
X = gosia,
B = true.

?- listing(matka).
matka(A, B) :-
	rodzic(A, B),
	kobieta(A).

true.

?- Kto = kasia, call(matka(Kto, Kogo)), write(Kto), write(' jest matka '), write(Kogo).
kasia jest matka robert
Kto = kasia,
Kogo = robert.

?- Matka = kasia, Dziecko = robert, clause(matka(Matka,Dziecko),Kiedy), write(Matka), write( ' jest matka '), write(Dziecko), write(' wtedy gdy '), write(Kiedy).
kasia jest matka robert wtedy gdy rodzic(kasia,robert),kobieta(kasia)
Matka = kasia,
Dziecko = robert,
Kiedy = (rodzic(kasia, robert), kobieta(kasia)).

?- [meta].
true.

?- [rodzina1].
true.

?- odpowiedz.
' matka ' czy 'ojciec'? ojciec
kogo ? robert
ojciec(_G1763,robert)tomek
true.

[trace]  ?- rozwiaz1(matka(kasia,X)).
   Call: (7) rozwiaz1(matka(kasia, _G1816)) ? creep
   Call: (8) matka(kasia, _G1816) ? creep
   Call: (9) rodzic(kasia, _G1816) ? creep
   Exit: (9) rodzic(kasia, robert) ? creep
   Call: (9) kobieta(kasia) ? creep
   Exit: (9) kobieta(kasia) ? creep
   Exit: (8) matka(kasia, robert) ? creep
   Exit: (7) rozwiaz1(matka(kasia, robert)) ? creep
X = robert.

[trace]  ?- rozwiaz1((matka(kasia,X), matka(Y,robert))).
   Call: (7) rozwiaz1((matka(kasia, _G1816), matka(_G1818, robert))) ? creep
   Call: (9) matka(kasia, _G1816) ? creep
   Call: (10) rodzic(kasia, _G1816) ? creep
   Exit: (10) rodzic(kasia, robert) ? creep
   Call: (10) kobieta(kasia) ? creep
   Exit: (10) kobieta(kasia) ? creep
   Exit: (9) matka(kasia, robert) ? creep
   Call: (9) matka(_G1818, robert) ? creep
   Call: (10) rodzic(_G1818, robert) ? creep
   Exit: (10) rodzic(kasia, robert) ? creep
   Call: (10) kobieta(kasia) ? creep
   Exit: (10) kobieta(kasia) ? creep
   Exit: (9) matka(kasia, robert) ? creep
   Exit: (7) rozwiaz1((matka(kasia, robert), matka(kasia, robert))) ? creep
X = robert,
Y = kasia ;
   Redo: (10) rodzic(_G1818, robert) ? creep
   Exit: (10) rodzic(tomek, robert) ? creep
   Call: (10) kobieta(tomek) ? creep
   Fail: (10) kobieta(tomek) ? creep
   Fail: (9) matka(_G1818, robert) ? creep
   Fail: (7) rozwiaz1((matka(kasia, _G1816), matka(_G1818, robert))) ? creep
false.


[trace]  ?- rozwiaz2((matka(kasia,X), matka(Y,robert))).
   Call: (7) rozwiaz2((matka(kasia, _G1846), matka(_G1848, robert))) ? creep
   Call: (8) rozwiaz2(matka(kasia, _G1846)) ? creep
^  Call: (9) clause(matka(kasia, _G1846), _G1953) ? creep
^  Exit: (9) clause(matka(kasia, _G1846), (rodzic(kasia, _G1846), kobieta(kasia))) ? creep
   Exit: (8) rozwiaz2(matka(kasia, _G1846)) ? creep
   Call: (8) rozwiaz2(matka(_G1848, robert)) ? creep
^  Call: (9) clause(matka(_G1848, robert), _G1967) ? creep
^  Exit: (9) clause(matka(_G1848, robert), (rodzic(_G1848, robert), kobieta(_G1848))) ? creep
   Exit: (8) rozwiaz2(matka(_G1848, robert)) ? creep
   Exit: (7) rozwiaz2((matka(kasia, _G1846), matka(_G1848, robert))) ? creep
true .

?- rozwiaz3((matka(kasia,X), matka(Y,robert))).
Wywoluje: matka(kasia,_G2271)
Wywoluje: rodzic(kasia,_G2271)
Wyjscie:   rodzic(kasia,robert)
Wywoluje: kobieta(kasia)
Wyjscie:   kobieta(kasia)
Wyjscie:   matka(kasia,robert)
Wywoluje: matka(_G2273,robert)
Wywoluje: rodzic(_G2273,robert)
Wyjscie:   rodzic(kasia,robert)
Wywoluje: kobieta(kasia)
Wyjscie:   kobieta(kasia)
Wyjscie:   matka(kasia,robert)
X = robert,
Y = kasia ;
Wyjscie:   rodzic(tomek,robert)
Wywoluje: kobieta(tomek)
false.


