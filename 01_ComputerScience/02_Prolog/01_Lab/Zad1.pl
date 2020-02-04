/* Ćwiczenie 1 */
/* Baza wiedzy: */
rodzic(kasia,robert).
rodzic(tomek,robert).
rodzic(tomek, eliza).

kobieta(kasia).
kobieta(eliza).

mezczyzna(tomek).
mezczyzna(robert).

/* Zapytania: 
 * listing. -- wyswietlenie calej bazy wiedzy 
 * listing(predykat). -- wyswietlenie bazy wiedzy nt. predykat 
 * rodzic(_,robert). -- czy robert ma rodzica ? 
 * mezczyzna(X). -- Kto jest mezczyzna ? 
 * mezczyzna(tomek). -- Czy tomek jest mezczyzna ? 
 * mezczyzna(reksio). -- Czy reksio jest mezczyzna ? 
 * rodzic(kasia, robert). -- Czy kasia jest rodzicem roberta ? 
 * rodzic(kasia,X). -- Czyim rodzicem jest kasia ? 
 * rodzic(Y, robert). -- Kto jest rodzicem roberta ? 
 */

/* Pytania do ćwiczenia 1:
 * Czy zamiast X lub Y mozna wpisac inny symbol ? Jaki ?
 * Tak, dowolny zaczynajacy sie od duzej litery.
 */