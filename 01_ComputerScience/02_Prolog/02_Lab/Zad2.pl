/* Ćwiczenie 2 */
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


/* Zapytania: 
 * rodzic(X,robert),mezczyzna(X). -- kto jest ojcem roberta ?
 * rodzic(Y,robert),kobieta(Y). -- kto jest matka roberta ?
 */

/* Pytania do ćwiczenia 2:
 * Czy kolejnosc wpisywania linii ma znaczenie ?
 * Ma, predykaty sa sprawdzane od gory do dolu
 */
