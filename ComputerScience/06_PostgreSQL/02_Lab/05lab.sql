-- Lab. 5 --
-- GROUP BY, HAVING
-- SUM, COUNT(), COUNT( DISTINCT ...), MAX(), AVG()
-- ROW_NUMBER() OVER ( ORDER BY ... )
-- subqueires

-- -------------------- Zad. 5.1 ------------------------------------------ -- 

-- 1. --
select count(*) from czekoladki; 

-- 2. --
select count(*) from czekoladki where nadzienie is not null;
select count(nadzienie) from czekoladki;

-- 3. --
select idpudelka, sum(sztuk) from zawartosc
group by idpudelka order by 2 desc limit 1;

-- 4. --
SELECT idpudelka, SUM(sztuk)
FROM zawartosc
GROUP BY idpudelka;

-- 5. --
SELECT z.idpudelka, SUM(z.sztuk)
FROM zawartosc z JOIN czekoladki c USING (idczekoladki)
WHERE c.orzechy IS NULL
GROUP BY z.idpudelka;

-- 6. --
SELECT z.idpudelka, SUM(z.sztuk)
FROM zawartosc z JOIN czekoladki c USING (idczekoladki)
WHERE c.czekolada = 'mleczna' 
GROUP BY z.idpudelka;


-- -------------------- Zad. 5.2 ------------------------------------------ -- 

-- 1. --
SELECT z.idpudelka, SUM(z.sztuk*c.masa) AS "masa pudelka"
FROM zawartosc z JOIN czekoladki c USING (idczekoladki)
GROUP BY z.idpudelka;


-- 2. --
SELECT z.idpudelka, SUM(z.sztuk*c.masa) AS "masa pudelka"
FROM zawartosc z JOIN czekoladki c USING (idczekoladki)
GROUP BY z.idpudelka
ORDER BY SUM(z.sztuk*c.masa) 
DESC NULLS LAST
LIMIT 1;


-- 3. --
SELECT avg(dane.masa)
FROM ( 
	SELECT z.idpudelka, sum(c.masa*z.sztuk) AS masa
	FROM zawartosc z JOIN czekoladki c USING(idczekoladki)
	GROUP BY z.idpudelka
) AS dane;


-- 4. --
SELECT z.idpudelka, avg(c.masa) AS "Srednia"
FROM zawartosc z JOIN czekoladki c USING (idczekoladki)
GROUP BY z.idpudelka;


-- -------------------- Zad. 5.3 ------------------------------------------ -- 

-- 1. --
SELECT z.datarealizacji, count(z.idzamowienia)
FROM zamowienia z
GROUP BY z.datarealizacji;

-- 2. --
SELECT count(*)
FROM zamowienia;

-- 3. --
SELECT sum(suma.koszt)
FROM (
	SELECT z.idzamowienia, sum(a.sztuk*p.cena) AS "koszt"
	FROM zamowienia z JOIN artykuly a USING(idzamowienia)
	JOIN pudelka p USING(idpudelka)
	GROUP BY z.idzamowienia
	) AS "suma";

-- 4. --
SELECT klienci.nazwa, klienci.liczba, klienci.cena
FROM (
	SELECT k.nazwa AS "nazwa", count(DISTINCT idzamowienia) AS "liczba", sum(a.sztuk*p.cena) AS "cena"
	FROM klienci k NATURAL JOIN zamowienia z NATURAL JOIN artykuly a JOIN pudelka p USING (idpudelka)
	GROUP BY k.nazwa
) AS "klienci";

 
-- -------------------- 5.4 ------------------------------------------ -- 

-- 1. --
SELECT count(*), idczekoladki
FROM zawartosc
GROUP BY idczekoladki
ORDER BY count(*) DESC NULLS LAST
LIMIT 1;

-- 2. --
SELECT sum(sztuk), idpudelka
FROM zawartosc JOIN czekoladki USING(idczekoladki)
WHERE orzechy IS NULL
GROUP BY idpudelka
ORDER BY count(*) DESC NULLS LAST
LIMIT 4;

-- 3. --
SELECT c.idczekoladki, count(z.idpudelka)
FROM czekoladki c LEFT JOIN zawartosc z USING(idczekoladki)
GROUP BY c.idczekoladki
ORDER BY 2 ASC
LIMIT 4;

-- 4. --
-- lub count(*) zamiast sum()
SELECT sum(a.sztuk), a.idpudelka
FROM artykuly a
GROUP BY a.idpudelka
ORDER BY 1 DESC NULLS LAST
LIMIT 1;



-- ------------------------- 5.5 ------------------------------------- --

-- 1. --
SELECT count(idzamowienia), date_part('quarter', datarealizacji) AS "kwaratal"
FROM zamowienia
GROUP BY date_part('quarter', datarealizacji);

-- 2. --
SELECT count(idzamowienia), date_part('month', datarealizacji) AS "miesiac"
FROM zamowienia
GROUP BY date_part('month', datarealizacji);

-- 3. --
SELECT count(idzamowienia), date_part('week', datarealizacji) AS "tydzien"
FROM zamowienia
GROUP BY date_part('week', datarealizacji);

-- 4. --
SELECT count(z.idzamowienia), k.miejscowosc
FROM klienci k JOIN zamowienia z USING(idklienta)
GROUP BY k.miejscowosc;




-- ------------------------- 5.6 ------------------------------------------ --

-- 1. --
SELECT sum(tab.masapudelka)
FROM (
	SELECT p.idpudelka, sum(p.stan*c.masa*z.sztuk) AS "masapudelka"
	FROM pudelka p JOIN zawartosc z USING (idpudelka)
	JOIN czekoladki c USING (idczekoladki)
	GROUP BY p.idpudelka
	) AS "tab";
	
-- 2. --
SELECT sum(p.stan * p.cena)
FROM pudelka p;

-- ------------------------- 5.7 ------------------------------------- --

-- 1. --
SELECT p.idpudelka, p.cena - sum(z.sztuk*c.koszt) AS "zysk"
FROM pudelka p JOIN zawartosc z USING(idpudelka) JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka;

-- 2. --
SELECT sum(a.sztuk * jednostkowy.zysk) 
FROM (
	( SELECT p.idpudelka, p.cena - sum(z.sztuk*c.koszt) AS "zysk"
	FROM pudelka p JOIN zawartosc z USING(idpudelka) JOIN czekoladki c USING(idczekoladki)
	GROUP BY p.idpudelka ) AS "jednostkowy"
	JOIN artykuly a USING(idpudelka)
);

-- 3. --
SELECT sum(rel.stan * rel.zysk)
FROM (
	SELECT p.idpudelka, p.stan, p.cena - sum(z.sztuk*c.koszt) AS "zysk"
	FROM pudelka p JOIN zawartosc z USING(idpudelka) JOIN czekoladki c USING(idczekoladki)
	GROUP BY p.idpudelka ) AS "rel";
	
-- ------------------------- 5.8 ------------------------------------- --

-- 1. --
select row_number() over (order by idpudelka) as nr, idpudelka
from pudelka;

