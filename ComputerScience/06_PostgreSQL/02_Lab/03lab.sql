-- Lab. 3 --
-- date_part, extract, 
-- like, similar to, between ... and
-- union, intersect, except
-- coalesce, nullif

-- -------------------- Zad. 3.1 ------------------------------------------ -- 

-- 1. --
select idzamowienia, datarealizacji
from zamowienia 
where datarealizacji between '2013-11-12' and '2013-11-20';

-- 2. --
select idzamowienia, datarealizacji
from zamowienia 
where ( datarealizacji between '2013-12-01' and '2013-12-06' ) 
or  ( datarealizacji between '2013-12-01' and '2013-12-20' );

-- 3. --
-- uzywajac 'similar to', bez uzycia extract / date_part
select idzamowienia, datarealizacji
from zamowienia
where datarealizacji::text similar to '2013-12-%';
-- uzywajac 'like', bez uzycia extract / date_part
select idzamowienia, datarealizacji
from zamowienia
where datarealizacji::text like '2013-12-%';

-- 4. --
select idzamowienia, datarealizacji from zamowienia 
where extract(month from datarealizacji) = 11 
and extract( year from datarealizacji ) = 2013;

-- 5. --
-- uzywajac or
select idzamowienia, datarealizacji from zamowienia 
where ( extract(month from datarealizacji) = 11 
or extract( month from datarealizacji ) = 12 ) 
and extract( year from datarealizacji ) = 2013;
-- bardziej elegancko, uzywajac in
select idzamowienia, datarealizacji from zamowienia 
where  extract(month from datarealizacji) in (11,12)  
and extract( year from datarealizacji ) = 2013;
-- uzywajac date_part
select idzamowienia, datarealizacji from zamowienia
where date_part('month', datarealizacji) in (11,12)
and date_part('year', datarealizacji) = 2013;
-- uzywajac similar to
select idzamowienia, datarealizacji from zamowienia
where extract(day from  datarealizacji) in (17,18,19);

-- 6. --
-- uzywajac extract
select idzamowienia, datarealizacji from zamowienia
where extract(day from  datarealizacji) in (17,18,19);
-- uzywajac date_part
select idzamowienia, datarealizacji from zamowienia
where date_part('day', datarealizacji) in (17,18,19);

-- 7. -- 
-- uzycie week
select date_part('week' , date '2014-10-30'); -- zwraca numer tygodnia w ktorym
											  -- zawiera sie dzien w danym roku
-- uzywajac extract
select idzamowienia, datarealizacji 
from zamowienia
where extract(week from datarealizacji) in ( 46, 47);
-- uzywajac date_part
select idzamowienia, datarealizacji 
from zamowienia
where date_part('week', datarealizacji) in ( 46, 47);

-- -------------------- Zad. 3.2 ------------------------------------------ -- 

-- 1. --
-- uzywajac similar to
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to 'S%';
-- uzywajac like
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa like 'S%';

-- 2. --
-- uzywajac similar to
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to 'S%i';
-- uzywajac like
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa like 'S%i';

-- 3. --
-- uzywajac similar to
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to 'S% m%';
-- uzywajac like
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa like 'S% m%';

-- 4. --
-- like nie obsluguje lub ani []
-- uzywajac similar to i |
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to '(A|B|C)%';
-- uzywajac similar to i []
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to '[ABC]%';

-- 5. --
-- uzywajac []
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to '%[Oo]rzech%';
-- uzywajac |
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to '%(O|o)rzech%';

-- 6. --
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to '(S%m%)';

-- 7. --
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to '(%maliny%|%truskawki%)';

-- 8. --
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa not similar to '([D-K]|S|T)%'; -- pamietac o % na koncu

-- 9. --
-- uzywajac similar to
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to 'Słod%';
-- uzywajac like
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa like 'Słod%';

-- 10. -- 
select nazwa, idczekoladki, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to '([A-Z]|[a-z])+';

-- alternatywnie not simila to '% %'

-- -------------------- Zad. 3.3 ------------------------------------------ -- 

-- 1. --
select miejscowosc              
from klienci 
where miejscowosc like '_% %_'; -- wiecej niz jedno slowo, obowiazkowa spacja

select miejscowosc              
from klienci 
where miejscowosc like '_%%_'; -- jedno lub wiecej slow, spacja nieobowiazkowa

-- 2. --
select * from klienci where telefon similar to '\d+ \d+ \d+ \d+'; -- \d jest rowne [0-9]
-- uzywajac klas
select * from klienci where telefon similar to '[[:digit:]]+ [[:digit:]]+ [[:digit:]]+ [[:digit:]]+';

-- 3. --
select * from klienci where telefon similar to '[[:digit:]]+ [[:digit:]]+ [[:digit:]]+';

-- -------------------- Zad. 3.4 ------------------------------------------ -- 

-- 1. --
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where masa between 15 and 24
union
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where koszt between 0.15 and 0.24;

-- 2. --
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where masa between 25 and 35
except
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where koszt between 0.25 and 0.35;

-- 3. --
-- konieczne nawiasy
(                                       
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where koszt between 0.15 and 0.24                                                    
intersect 
select idczekoladki, nazwa, masa, koszt             
from czekoladki
where masa between 15 and 24 
)
union                                   
( 
select idczekoladki, nazwa, masa, koszt
from czekoladki 
where masa between 25 and 35 
intersect                    
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where koszt between 0.25 and 0.35 
);

-- 4. --
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where masa between 15 and 24
intersect 
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where koszt between 0.15 and 0.24;

-- 5. --
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where masa between 25 and 35                                                        
except 
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where koszt between 0.15 and 0.24 
except
select idczekoladki, nazwa, masa, koszt 
from czekoladki
where koszt between 0.29 and 0.35;

-- -------------------- Zad. 3.5 ------------------------------------------ --

-- 1. --
select idklienta from klienci
except
select idklienta from zamowienia;

-- 2. --
select idpudelka from pudelka
except 
select idpudelka from artykuly;

-- 3. --
select nazwa from klienci 
where nazwa similar to '%(Rz|rz)%'
union
select nazwa from czekoladki 
where nazwa similar to '%(Rz|rz)%'
union
select nazwa from pudelka
where nazwa similar to '%(Rz|rz)%';

-- 4. --
select idczekoladki
from czekoladki
except
select idczekoladki
from zawartosc;

-- -------------------- Zad. 3.6 ------------------------------------------ --

-- 1. --
select idmeczu,
( gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0) ) as "suma gospodarze", 
( goscie[1] + goscie[2] + goscie[3] + coalesce(goscie[4], 0) + coalesce(goscie[5], 0)) as "suma goscie" 
from statystyki; 

-- 2. --
select idmeczu,
( gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4],0) + coalesce(gospodarze[5],0) ) as "Suma punktow",
( goscie[1] + goscie[2] + goscie[3] + coalesce(goscie[4], 0) + coalesce(goscie[5],0) ) as "Suma goscie" 
from statystyki
where goscie[5] + gospodarze[5] > 29; -- min wynik to 16:14 
																		
-- 3. --
select idmeczu, 
( case when ( gospodarze[1] > goscie[1]) then 1 else 0 end +
case when ( gospodarze[2] > goscie[2] ) then 1 else 0 end + 
case when ( gospodarze[3] > goscie[3] ) then 1 else 0 end +
case when ( gospodarze[4] > goscie[4] ) then 1 else 0 end +
case when ( gospodarze[5] > goscie[5] ) then 1 else 0 end)
|| ':' || 
( case when ( gospodarze[1] < goscie[1] ) then 1 else 0 end + 
case when ( gospodarze[2] < goscie[2] ) then 1 else 0 end +
case when ( gospodarze[3] < goscie[3] ) then 1 else 0 end + 
case when ( gospodarze[4] < goscie[4] ) then 1 else 0 end + 
case when ( gospodarze[5] < goscie[5] ) then 1 else 0 end )
as "wynik"
from statystyki;																		
															
-- 4. --
select idmeczu,
( gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0) ),
( goscie[1] + goscie[2] + goscie[3] + coalesce(goscie[4], 0) + coalesce(goscie[5], 0) )
from statystyki 
where ( gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce( gospodarze[4],0 ) + coalesce( gospodarze[5],0 ) ) > 100;

-- 5. --
select idmeczu, gospodarze[1] as "Pierwszy set",                                                                                                                                    
( gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0 ) + coalesce(gospodarze[5], 0 ) ) as "Suma w meczu"
from statystyki
where sqrt(gospodarze[1]+goscie[1]) < log(2, ( gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4],0) + coalesce(gospodarze[5],0) + goscie[1] + goscie[2] + goscie[3] + coalesce(goscie[4],0) + coalesce(goscie[5],0)  ));

-- -------------------- Zad. 3.7 ------------------------------------------ --
psql wrobdomi < myQuery > tabela.html 
-- plik myQuery:										  
set search_path to siatkowka;
\echo <!DOCTYPE html>
\echo <html>
\echo <body>
\echo
\echo <h1>Wynik</h1>
\H -- format .html
\pset border 2 -- szerokosc tabeli
select idmeczu, gospodarze[1] as "Pierwszy set",
( gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0 ) + coalesce(gospodarze[5], 0 ) ) as "Suma w meczu"
from statystyki
where sqrt(gospodarze[1]+goscie[1]) < log(2, ( gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4],0) + coalesce(gospodarze[5],0) + goscie[1] + goscie[2] + goscie[3] + coalesce(goscie[4],0) + coalesce(goscie[5],0)  ));
\echo
\echo </body>
\echo </html>
										  
-- -------------------- Zad. 3.8 ------------------------------------------ --
 psql wrobdomi < zad38Query.sql > wynik.txt
-- plik zad38Query:
set search_path to siatkowka;
\a
\t
\pset fieldsep ','
select idmeczu, gospodarze[1] as "Pierwszy set",                                                                                                                                     
( gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0 ) + coalesce(gospodarze[5], 0 ) ) as "Suma w meczu"
from statystyki
where sqrt(gospodarze[1]+goscie[1]) < log(2, ( gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4],0) + coalesce(gospodarze[5],0) + goscie[1] + goscie[2] + goscie[3] + coalesce(goscie[4],0) + coalesce(goscie[5],0)  ));
											  

