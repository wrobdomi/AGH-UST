-- Lab. 4 --
-- Iloczyn kartezjanski
-- Zlaczenie theta, rownozlaczenie, zlaczenie naturalne
-- left join, right join, full join
-- 

-- -------------------- Zad. 4.1 ------------------------------------------ -- 

-- Zapytania --
-- k jest aliasem na klienci, wybieramy wszysztkich klientow ( 67 rekordow )
SELECT k.nazwa FROM klienci k;

-- zwroci 9715 = 67 * 145 rekordow, zapytanie tworzy iloczyn kartezjanski, wszystkich zamowien jest 145
SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z;

-- zwraca nazwy klientw i id zamowien dla kazdego klienta, dla jednego klienta moze byc wiele rekordow ( wiele zamowien ), 145 rekordow
SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z  
WHERE z.idklienta = k.idklienta;

-- zwraca to samo co zapytanie powyzej przy uzyciu zlaczenia naturalnego, 145 rekordow, laczy zamowienia i 
-- klientow przez wszytkie wspolne atrybuty w tym przypadu jest tylko jeden czyli idklienta
SELECT k.nazwa, z.idzamowienia FROM klienci k NATURAL JOIN zamowienia z;

-- realizacja tego samego przy uzyciu theta zlaczenia: join ... on ... , zwraca tak samo 145 rekordow niosacych ta sama informacje
SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z
ON z.idklienta=k.idklienta;

-- realizacja tego samego tym razem przy uzyciu rownozlaczenia, zwraca tak sam 145 rekordow z ta sama informacja
SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z
USING (idklienta);

-- 1. --
-- W którym zapytaniu występuje iloczyn kartezjański?
-- Iloczyn kartezjanski wystepuje w zapytaniu drugim 

-- 2. --
-- Które zapytanie dostarcza bezwartościowych danych?
-- Zapytanie drugie


-- -------------------- Zad. 4.2 ------------------------------------------ -- 

-- 1. --
-- uzywajac theta zlaczenia --
select k.nazwa, z.idzamowienia, z.datarealizacji
from klienci k join zamowienia z on ( k.idklienta = z.idklienta )
where k.nazwa like '%Antoni';
-- ten sam rezultat uzywajac zlaczenia naturlanego
select nazwa, idzamowienia, datarealizacji 
from klienci natural join zamowienia 
where nazwa like '%Antoni';
-- ten sam rezultat uzywajac rownozlaczeia
select k.nazwa, z.idzamowienia, z.datarealizacji
from klienci k join zamowienia z using(idklienta)
where k.nazwa like '%Antoni';


-- 2. --
-- uzywajac theta zlaczenia 
select z.idzamowienia, z.datarealizacji, k.ulica
from zamowienia z join klienci k on (k.idklienta = z.idklienta)
where k.ulica similar to '%[1-9]*/[1-9]*';

-- uzywajac zlaczenia naturalnego
select ulica, idzamowienia, datarealizacji 
from klienci natural join zamowienia
where ulica like '%/%';

-- ten sam rezultat uzywajac rownozlaczeia
select z.idzamowienia, z.datarealizacji, k.ulica
from zamowienia z join klienci k using(idklienta)
where k.ulica similar to '%[1-9]*/[1-9]*';


-- 3. --
-- uzywajac theta zlaczenia
select z.idzamowienia, z.datarealizacji, k.miejscowosc
from klienci k join zamowienia z on (k.idklienta = z.idklienta)
where k.miejscowosc = 'Kraków' and date_part('month', z.datarealizacji) = 11 and date_part('year', z.datarealizacji) = 2013;

-- uzywajac zlaczenia naturlanego 
select nazwa, ulica, miejscowosc, datarealizacji
from klienci natural join zamowienia
where extract(month from datarealizacji) = 11 and miejscowosc = 'Kraków'
order by 1;

-- uzywajac rownozlaczenia
select z.idzamowienia, z.datarealizacji, k.miejscowosc
from klienci k join zamowienia z using(idklienta)
where k.miejscowosc = 'Kraków' and date_part('month', z.datarealizacji) = 11 and date_part('year', z.datarealizacji) = 2013;


-- -------------------- Zad. 4.3 ------------------------------------------ -- 

-- 1. --
-- uzywajac theta zlaczenia 
-- UWAGA: konieczne jest zastsowanie distinct, poniewaz zapytanie ma na celu uzyskane informacji o klientach,
-- natomiast theta zlaczenia zwraca iloczyn kartezjanski wiec zwrociby pary klient-zamowienia, gdzie
-- bylyby wszystkie zamowienia sprzed 5 lat dla danego klienta
select distinct date_part('year', z.datarealizacji) as "Rok", k.nazwa, k.ulica, k.miejscowosc
from klienci k join zamowienia z on(z.idklienta = k.idklienta)
where z.datarealizacji >= current_date - interval '5 years';

-- uzywajac zlaczenia naturalnego, pamietac o koniecznosci distinct
select distinct nazwa, ulica, miejscowosc, extract(year from datarealizacji) as "Rok" 
from klienci natural join zamowienia
where datarealizacji >= current_date - interval '5 years';

-- uzywajac rownozlaczenia
select distinct date_part('year', z.datarealizacji) as "Rok", k.nazwa, k.ulica, k.miejscowosc
from klienci k join zamowienia z using(idklienta)
where z.datarealizacji >= current_date - interval '5 years';

-- 2. --
-- uzywaja theta zlaczenia 
select k.nazwa, k.ulica, k.miejscowosc, p.nazwa 
from klienci k join zamowienia z on (k.idklienta = z.idklienta) join artykuly a on (z.idzamowienia = a.idzamowienia) join pudelka p on ( a.idpudelka = p.idpudelka) 
where p.nazwa in ('Kremowa fantazja','Kolekcja jesienna');

-- uzywajac zlaczenia naturalnego oraz rownozlaczenia
-- UWAGA : ostatnie ze wzlaczen nie moze byc naturalne, poniewaz klienci i pudelka maja ten sam atybut ( nazwa ) 
-- ktory jest rozny w obu tablicach, natural join dalby zero wynikow, bo nazwa sie nigdzie nie zgadza,
-- dlatego tez nalezy uwazac na natural join, bo moze przesstac dzialac gdy ktos w przyszlosci doda
-- do tabeli atrybut o takiej samej nazwie
select k.nazwa, k.ulica, k.miejscowosc, p.nazwa 
from klienci k natural join zamowienia z natural join artykuly a join pudelka p using (idpudelka) 
where p.nazwa in ('Kremowa fantazja','Kolekcja jesienna');

-- 3. --
 -- uzywajac natural joinselect distinct idklienta, nazwa, ulica, miejscowosc 
select distinct idklienta, nazwa, ulica, miejscowosc 
from klienci natural join zamowienia 
order by 1;

-- uzywajac theta zlaczenia
-- Uwaga, jeśli bierzemy idzamowienia to musi byc distinct on, bo samo distinct nie odrzuci roznych zamowien
select distinct on(k.idklienta) k.idklienta, k.nazwa, k.ulica, k.miejscowosc, z.idzamowienia
from klienci k join zamowienia z on ( k.idklienta = z.idklienta )
order by 1;

-- 4. --
-- uzywajac full join
select distinct idklienta, nazwa, ulica, miejscowosc
from klienci full join zamowienia using(idklienta)
where idzamowienia is null
order by 1;

-- uzywajac left join
-- distinct musi byc aby nie powtarzac klientow 
select distinct idklienta, nazwa, ulica, miejscowosc
from klienci left join zamowienia using(idklienta)
where idzamowienia is null;

-- uzywajac right join
select distinct z.idklienta, k.nazwa, k.ulica, k.miejscowosc
from zamowienia z right join klienci k on k.idklienta = z.idklienta
where idzamowienia is null
order by 1;

-- 5. --
select distinct on (k.idklienta) k.idklienta, k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji
from klienci k join zamowienia z using(idklienta) 
where date_part('year', z.datarealizacji) = 2013 and date_part('month', z.datarealizacji) = 11 
order by 1;

-- 6. --
-- uzywajac theta zlaczenia
select k.nazwa, k.idklienta, k.ulica, z.idzamowienia, p.idpudelka, p.nazwa, a.sztuk
from klienci k join zamowienia z on (k.idklienta = z.idklienta) join artykuly a on (z.idzamowienia = a.idzamowienia)
join pudelka p on (a.idpudelka = p.idpudelka) 
where (p.nazwa = 'Kremowa fantazja' or p.nazwa = 'Kolekcja jesienna') and a.sztuk = 2;

-- uzywajac natural join 
select k.nazwa, k.ulica, k.miejscowosc, a.sztuk, p.nazwa
from klienci k natural join zamowienia z natural join artykuly a join pudelka p using(idpudelka)
where a.sztuk >= 2 and p.nazwa in ('Kremowa fantazja','Kolekcja jesienna');

-- 7. --
-- uzywajac natural join 
select distinct c.orzechy, k.nazwa, k.ulica, k. miejscowosc
from klienci k natural join zamowienia z natural join artykuly a join pudelka p using(idpudelka) join zawartosc w using(idpudelka) join czekoladki c using(idczekoladki)
where c.orzechy like

 
-- -------------------- 4.4 ------------------------------------------ -- 
-- 1. --
select p.nazwa, p.opis, c.nazwa, c.opis
from pudelka p
left join zawartosc z using (idpudelka) join
czekoladki c using(idczekoladki);

-- 2. --
select p.nazwa, p.opis, c.nazwa, c.opis
from pudelka p
join zawartosc z using (idpudelka) join 
czekoladki c using(idczekoladki) 
where p.idpudelka = 'heav'

-- 3. --
select p.nazwa, p.opis, c.nazwa, c.opis
from pudelka p
join zawartosc z using (idpudelka) join 
czekoladki c using(idczekoladki) 
where p.idpudelka like '%Kolekcja%';


-- -------------------- Zad. 4.5 ------------------------------------------ --

-- 1. --
select p.nazwa, p.opis, p.cena, c.idczekoladki
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using (idczekoladki)
where c.idczekoladki like 'd09';

-- 2. --
select p.nazwa, p.opis, p.cena, c.idczekoladki, c.nazwa
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using (idczekoladki)
where c.nazwa like 'S%';

-- 3. --
select p.nazwa, p.opis, p.cena, c.idczekoladki, c.nazwa, z.sztuk
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using (idczekoladki)
where z.sztuk >= 4;

-- 4. --
select p.nazwa, p.opis, p.cena, c.idczekoladki, c.nazwa, z.sztuk
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using (idczekoladki)
where c.nadzienie = 'truskawki'

-- 5. --
-- Uwaga: W tym zapytaniu konieczny jest distinct, bo bez niego bedzie odejmowac 
-- tylko dla danego pudelka te krotki gdzie czekolada jest gorzka, anie wszyzstkie 
-- krotki dla daneg pudelka

select distinct p.nazwa, p.opis, p.cena
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using (idczekoladki)
except
select distinct p.nazwa, p.opis, p.cena
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using(idczekoladki)
where c.czekolada = 'gorzka';

-- 6. --
select p.nazwa, p.opis, p.cena, c.nazwa
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using (idczekoladki)
where c.nazwa = 'Gorzka truskawkowa' and z.sztuk >= 3;

-- 7. --
select distinct p.nazwa, p.opis, p.cena
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using (idczekoladki)
except
select distinct p.nazwa, p.opis, p.cena
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using(idczekoladki)
where c.orzechy is not null;

-- 8. --
select p.nazwa, p.opis, p.cena, c.nazwa
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using (idczekoladki)
where c.nazwa = 'Gorzka truskawkowa';

-- 9. --
select p.nazwa, p.opis, p.cena, c.nazwa
from pudelka p join zawartosc z using(idpudelka)
join czekoladki c using (idczekoladki)
where c.nadzienie is null;


-- -------------------- Zad. 4.6 ------------------------------------------ --

-- 1. --
select c1.idczekoladki as "ID1", c1.nazwa, c1.koszt as "Koszt1", c2.idczekoladki as "ID2", c2.koszt as "Koszt2"
from czekoladki c1, czekoladki c2
where c2.idczekoladki like 'd08' and c1.koszt > c2.koszt;

-- 2. --
-- Czy nie powinno byc  k2 != Alicja Górka ? 
select distinct k2.nazwa
from klienci k1 natural join zamowienia z1 natural join artykuly a1,
klienci k2 natural join zamowienia z2 natural join artykuly a2
where k1.nazwa = 'Alicja Górka' and a1.idpudelka = a2.idpudelka;

-- 3. -- 
select k1.nazwa 
from klienci k1 join zamowienia z1 using (idklienta) join artykuly using (idzamowienia),
klienci k2 join zamowienia z2 using (idklienta) join atykuly using (idzamowienia) 
where k1.miejscowosc = 'Katowice'

 

