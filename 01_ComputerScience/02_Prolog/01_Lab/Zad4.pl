/* Ćwiczenie 4 */
/* Baza wiedzy: */
rodzic(kasia,robert).
rodzic(tomek,robert).
rodzic(tomek, eliza).
rodzic(robert,anna).
rodzic(robert,magda).
rodzic(magda,jan).

kobieta(kasia).
kobieta(eliza).
kobieta(magda).
kobieta(anna).

mezczyzna(jan).
mezczyzna(tomek).
mezczyzna(robert).

famme(kasia).
homme(krzys).
parent(kasia, krzys).

matka(X,Y) :-
    rodzic(X,Y),
    kobieta(X).

ojciec(X,Y) :-
    rodzic(X,Y),
    mezczyzna(X).

brat(X,Y) :-
    mezczyzna(X),
    rodzic(Z,X),
    rodzic(Z,Y),
    X \= Y.

siostra(X,Y) :-
    kobieta(X),
    rodzic(Z,X),
    rodzic(Z,Y),
    X \= Y.

dziadek(X,Y) :-
    mezczyzna(X),
    rodzic(X,Z),
    rodzic(Z,Y).

babcia(X,Y) :-
    kobieta(X),
    rodzic(X,Z),
    rodzic(Z,Y).


/* Zapytania: 
 * matka(robert,X). -- kto jest matka roberta ? 
 * ojciec(robert,X). -- czyim ojcem jest robert ?
 * ojciec(X, robert). -- kto jest ojcem roberta ?
 * brat(X,eliza). -- kto jest bratem elizy ?
 * siostra(X,robert). -- kto jest siostra roberta ? 
 * dziadek(X,jan). -- kto jest dziadkiem jana ?
 * dziadek(X,magda). -- kto jest dziadkiem magdy ?
 * babcia(X,magda). -- kto jest babcia magdy ?
 */

/* Pytania do ćwiczenia 4:
 * Jaki pojawia sie problem przy bracie / siostrze ?
 * Potrzebna jest trzecia zmienna oznaczajaca rodzica, nie trzeba jej podawac w paramatrach
 */