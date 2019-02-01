-- Lab. 10 --
-- Subqueries
-- IN, NOT IN
-- EXISTS, NOT EXISTS
-- ANY, ALL
-- WITH 

-- -------------------- 10.2 ------------------------------------------ -- 

-- 1. --
SELECT idzamowienia, datarealizacji
FROM zamowienia 
WHERE idklienta IN
	( 	
		SELECT idklienta 
		FROM klienci
		WHERE nazwa LIKE '%Antoni%'	
	);

-- 2. --
SELECT datarealizacji, idzamowienia 
FROM zamowienia
WHERE idklienta IN
	(
		SELECT idklienta 
		FROM klienci 
		WHERE ulica SIMILAR TO '%[1-9]*/[1-9]*'
	);

-- 3. --

SELECT z.datarealizacji, z.idzamowienia
FROM zamowienia z
WHERE extract(month FROM z.datarealizacji) = 11 AND extract(year FROM z.datarealizacji) = 2013 
	AND z.idklienta IN 
	(
		SELECT idklienta FROM klienci
		WHERE miejscowosc = 'Kraków'
	);

-- -------------------- 10.3 ------------------------------------------ -- 

-- 1. --
SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k
WHERE k.idklienta IN
	(
		SELECT z.idklienta 
		FROM zamowienia z
		WHERE z.datarealizacji = '2013-11-12'
	);

-- 2. --
SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k
WHERE k.idklienta IN
	(
		SELECT z.idklienta 
		FROM zamowienia z
		WHERE extract(year from z.datarealizacji) = 2013 AND extract(month from z.datarealizacji) = 11
	);
	
-- 3. --
SELECT DISTINCT nazwa, ulica, miejscowosc
FROM
	(
		SELECT k.nazwa, k.ulica, k.miejscowosc
		FROM klienci k JOIN zamowienia z USING(idklienta)
		JOIN artykuly a USING(idzamowienia) 
		JOIN pudelka p USING(idpudelka)
		WHERE p.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna')
	) r;	
	
-- lub 

SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k
WHERE EXISTS 
	(
		SELECT 1 FROM zamowienia z
		JOIN artykuly a USING(idzamowienia)
		JOIN pudelka p USING(idpudelka)
		WHERE z.idklienta = k.idklienta AND p.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna')
	);
	
-- 4. --
SELECT DISTINCT nazwa, ulica, miejscowosc
FROM
	(
		SELECT k.nazwa, k.ulica, k.miejscowosc
		FROM klienci k JOIN zamowienia z USING(idklienta)
		JOIN artykuly a USING(idzamowienia) 
		JOIN pudelka p USING(idpudelka)
		WHERE p.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna') AND
		a.sztuk >= 2
	) r;

-- lub 

SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k
WHERE EXISTS 
	(
		SELECT 1 FROM zamowienia z
		JOIN artykuly a USING(idzamowienia)
		JOIN pudelka p USING(idpudelka)
		WHERE z.idklienta = k.idklienta AND p.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna')
		AND a.sztuk >= 2
	);

-- 5. --
SELECT DISTINCT nazwa, ulica, miejscowosc
FROM
	(
		SELECT k.nazwa, k.ulica, k.miejscowosc
		FROM klienci k JOIN zamowienia z USING(idklienta)
		JOIN artykuly a USING(idzamowienia) 
		JOIN pudelka p USING(idpudelka)
		JOIN zawartosc z
	) r;

-- 6. --
SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k 
WHERE EXISTS 
	(
		SELECT 1 
		FROM zamowienia z 
		WHERE z.idklienta = k.idklienta
	);
	
-- lub 

SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k
NATURAL JOIN zamowienia z;

-- 7. --
SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k
WHERE NOT EXISTS 
	(
		SELECT 1 
		FROM zamowienia z
		WHERE k.idklienta = z.idklienta
	);
	

	
-- -------------------- 10.4 ------------------------------------------ -- 

-- 1. --
SELECT DISTINCT p.nazwa, p.opis, p.cena
FROM pudelka p
WHERE p.idpudelka IN
	(
		SELECT z.idpudelka
		FROM zawartosc z 
		JOIN czekoladki c USING(idczekoladki)
		WHERE idczekoladki = 'd09'
	);
	
-- 2. --
SELECT DISTINCT p.nazwa, p.opis, p.cena
FROM pudelka p
WHERE EXISTS
	(
		SELECT 1
		FROM zawartosc z 
		JOIN czekoladki c USING(idczekoladki)
		WHERE z.idpudelka = p.idpudelka
		AND c.nazwa = 'Gorzka truskawkowa'
	);


-- 3. --
SELECT DISTINCT p.nazwa, p.opis, p.cena
FROM pudelka p
WHERE EXISTS 
	(
		SELECT 1
		FROM zawartosc z 
		JOIN czekoladki c USING(idczekoladki)
		WHERE z.idpudelka = p.idpudelka
		AND c.nazwa LIKE 'S%'
	);


-- 4. --
SELECT DISTINCT p.nazwa, p.opis, p.cena
FROM pudelka p
WHERE EXISTS
	(
		SELECT 1
		FROM zawartosc z
		WHERE z.idpudelka = p.idpudelka
		AND z.sztuk >= 4
	);


-- 5. --
SELECT DISTINCT p.nazwa, p.opis, p.cena
FROM pudelka p
WHERE EXISTS
	(
		SELECT 1
		FROM zawartosc z
		JOIN czekoladki c USING(idczekoladki)
		WHERE z.idpudelka = p.idpudelka
		AND z.sztuk >= 3 AND c.nazwa = 'Gorzka truskawkowa'
	);


-- 6. --
SELECT DISTINCT p.nazwa, p.opis, p.cena
FROM pudelka p
WHERE EXISTS
	(
		SELECT 1
		FROM zawartosc z
		JOIN czekoladki c USING(idczekoladki)
		WHERE z.idpudelka = p.idpudelka
		AND c.nadzienie = 'truskawki'
	);
	

-- 7. --
SELECT DISTINCT p.nazwa, p.opis, p.cena
FROM pudelka p
WHERE NOT EXISTS
	(
		SELECT 1
		FROM zawartosc z
		JOIN czekoladki c USING(idczekoladki)
		WHERE z.idpudelka = p.idpudelka
		AND c.czekolada = 'gorzka'
	);
	

-- 8. --
SELECT DISTINCT p.nazwa, p.opis, p.cena
FROM pudelka p
WHERE NOT EXISTS
	(
		SELECT 1
		FROM zawartosc z
		JOIN czekoladki c USING(idczekoladki)
		WHERE z.idpudelka = p.idpudelka
		AND c.orzechy IS NOT NULL
	);


-- 9. --
SELECT DISTINCT p.nazwa, p.opis, p.cena
FROM pudelka p
WHERE EXISTS
	(
		SELECT 1
		FROM zawartosc z
		JOIN czekoladki c USING(idczekoladki)
		WHERE z.idpudelka = p.idpudelka
		AND c.nadzienie IS NULL
	);

-- -------------------- 10.5 ------------------------------------------ -- 

-- 1. --
SELECT c.idczekoladki, c.nazwa
FROM czekoladki c
WHERE c.koszt >
	(
		SELECT koszt
		FROM czekoladki
		WHERE idczekoladki = 'd08'
	);

-- 2. --
SELECT DISTINCT k.nazwa 
FROM klienci k
JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia)
JOIN pudelka p USING(idpudelka)
WHERE p.idpudelka IN
	(
		SELECT DISTINCT pu.idpudelka 
		FROM klienci kl
		JOIN zamowienia za USING(idklienta)
		JOIN artykuly ar USING(idzamowienia)
		JOIN pudelka pu USING(idpudelka)
		WHERE kl.nazwa = 'Górka Alicja'
	)
AND k.nazwa <> 'Górka Alicja';

-- 3. --
SELECT DISTINCT k.nazwa 
FROM klienci k
JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia)
JOIN pudelka p USING(idpudelka)
WHERE p.idpudelka IN
	(
		SELECT DISTINCT pu.idpudelka 
		FROM klienci kl
		JOIN zamowienia za USING(idklienta)
		JOIN artykuly ar USING(idzamowienia)
		JOIN pudelka pu USING(idpudelka)
		WHERE kl.miejscowosc = 'Katowice'
	)
AND k.miejscowosc <> 'Katowice';


-- -------------------- 10.6 ------------------------------------------ -- 

-- 1. --
SELECT p.nazwa, sum(z.sztuk)
FROM pudelka p 
JOIN zawartosc z USING(idpudelka)
GROUP BY p.nazwa
HAVING sum(z.sztuk) = 
	(
		SELECT max(suma)
		FROM (	
			SELECT sum(zz.sztuk) AS suma 
			FROM zawartosc zz
			GROUP BY zz.idpudelka
			) r1
	);

-- 2. --

SELECT p.nazwa, sum(z.sztuk)
FROM pudelka p 
JOIN zawartosc z USING(idpudelka)
GROUP BY p.nazwa
HAVING sum(z.sztuk) = 
	(
		SELECT min(suma)
		FROM (	
			SELECT sum(zz.sztuk) AS suma 
			FROM zawartosc zz
			GROUP BY zz.idpudelka
			) r1
	);


-- 3. --
SELECT p.idpudelka , sum(z.sztuk)
FROM pudelka p
JOIN zawartosc z USING(idpudelka)
GROUP BY p.idpudelka
HAVING sum(z.sztuk) >
	( 
		SELECT avg(suma) 
		FROM 
		(
			SELECT sum(zz.sztuk) AS suma
			FROM zawartosc zz
			GROUP BY zz.idpudelka
		) p
	);
	
-- 4 --
SELECT p.nazwa, sum(z.sztuk)
FROM pudelka p 
JOIN zawartosc z USING(idpudelka)
GROUP BY idpudelka
HAVING sum(z.sztuk) =
		(
			SELECT min(suma)
			FROM (	
				SELECT sum(zzz.sztuk) AS suma 
				FROM zawartosc zzz
				GROUP BY zzz.idpudelka
				) r1
		)
		OR
		sum(z.sztuk) =
		(
			SELECT max(suma)
			FROM (	
				SELECT sum(zz.sztuk) AS suma 
				FROM zawartosc zz
				GROUP BY zz.idpudelka
				) r2
		);
	


