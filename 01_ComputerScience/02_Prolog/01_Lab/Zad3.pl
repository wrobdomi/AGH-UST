/* Ćwiczenie 3 */
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

/* Zapytania: 
 * parent(Y,krzys). -- daje kasia
 * parent(Y, robert). -- daje false
 */

/* Pytania do ćwiczenia 3:
 * Czy nazwa uzytych symboli wplywa na dzialanie programu ?
 * Nazwa okresla stałą lub predykat, które są rozróżnialne przez prolog
 * Jakie sa ograniczenia na uzywane symbole ?
 * 
 */
