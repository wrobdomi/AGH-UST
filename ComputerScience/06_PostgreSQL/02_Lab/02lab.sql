-- Lab. 2 --
-- ORDER BY ... ASC, ORDER BY ... DESC
-- WHERE ... IN, WHERE ... NOT IN ...
-- WHERE ... AND ... , WHERE ... OR ...
-- BETWEEN ... AND ... , NOT BETWEEN ... AND ...


-- -------------------- Zad. 2.1 ------------------------------------------ -- 

-- 1. --
SELECT nazwa, ulica, miejscowosc
FROM klienci
ORDER BY nazwa ASC;

-- 2. --
SELECT nazwa, ulica, miejscowosc
FROM klienci
ORDER BY miejscowosc DESC, nazwa ASC;

-- mozna tez zastosowac numery kolumn odpowiadajace
-- nazwom kolumn uzytym po slowie SELECT:
SELECT nazwa, ulica, miejscowosc
FROM klienci
ORDER BY 3 DESC, 1 ASC;

-- 3. --
SELECT nazwa, miejscowosc 
FROM klienci
ORDER BY miejscowosc DESC, nazwa ASC;

-- lub z uzyciem OR:
SELECT nazwa, miejscowosc
FROM klienci 
WHERE miejscowosc = 'Kraków' OR miejscowosc = 'Warszawa'
ORDER BY miejscowosc DESC, nazwa ASC;

-- 4. --
SELECT nazwa, miejscowosc 
FROM klienci
ORDER BY miejscowosc DESC;

-- 5. --
SELECT nazwa
FROM klienci
WHERE miejscowosc = 'Kraków'
ORDER BY nazwa;

-- -------------------- Zad. 2.2 ------------------------------------------ -- 

-- 1. --
SELECT nazwa, masa
FROM czekoladki
WHERE masa > 20;

-- 2. --
SELECT nazwa, masa, koszt
FROM czekoladki
WHERE masa > 20 AND koszt > 0.25 ;

-- 3. --
SELECT nazwa, masa, koszt * 100 AS "Koszt w gr"
FROM czekoladki
WHERE masa > 20 AND koszt * 100 > 25;

-- 4. --
SELECT nazwa, czekolada, nadzienie, orzechy
FROM czekoladki
WHERE 
(czekolada = 'mleczna' AND nadzienie ='maliny')
OR 
(czekolada = 'mleczna' AND nadzienie ='truskawki') 
OR 
( orzechy = 'laskowe' AND czekolada <> 'gorzka');

-- lub ladniej:
SELECT nazwa, czekolada, nadzienie, orzechy
FROM czekoladki
WHERE 
(czekolada = 'mleczna' AND nadzienie IN ('maliny','truskawki')) 
OR 
(orzechy = 'laskowe' AND czekolada != 'gorzka');

-- 5. --
SELECT nazwa, koszt
FROM czekoladki 
WHERE 
koszt > 0.25;

-- 6. --								 
SELECT nazwa, czekolada 
FROM czekoladki 
WHERE czekolada IN ('mleczna', 'biała');

-- -------------------- Zad. 2.3 ------------------------------------------ -- 		

-- 1. --
SELECT 124 * 7 + 45;									 

-- 2.--
SELECT 2^20;

-- 3. --
SELECT sqrt(3);

-- 4. --
SELECT pi();

-- -------------------- Zad. 2.4 ------------------------------------------ -- 		

-- 1. --
SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE 
masa BETWEEN 15 AND 24
-- 2. --
SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE 
koszt BETWEEN 0.25 AND 0.35;

-- 3. --
SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE 
(masa BETWEEN 25 AND 35) OR (koszt BETWEEN 0.15 AND 0.24);

-- -------------------- Zad. 2.5 ------------------------------------------ -- 

-- 1. --
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE orzechy IS NOT NULL;

-- 2. --
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE orzechy IS NULL;

-- 3. --
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE ( orzechy IS NOT NULL ) OR ( nadzienie IS NOT NULL);

-- 4. --
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE 
czekolada IN ('biała', 'mleczna')
AND
orzechy IS NULL;

-- 5. --
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE 
czekolada NOT IN ('biała', 'mleczna')
AND
((orzechy IS NOT NULL) OR (nadzienie IS NOT NULL));

-- 6. --
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE 
nadzienie IS NOT NULL;

-- 7. --
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE 
nadzienie IS NULL;

-- 8. --
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE 
orzechy IS NULL AND nadzienie IS NULL;

-- 9. --
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE 
czekolada IN ('mleczna', 'biała') AND  nadzienie IS NULL;

-- -------------------- Zad. 2.6 ------------------------------------------ -- 

-- 1. --
SELECT nazwa, masa, koszt 
FROM czekoladki
WHERE 
masa BETWEEN 15 AND 24
OR 
koszt BETWEEN 0.15 AND 0.24;

-- 2. --
SELECT nazwa, masa, koszt 
FROM czekoladki
WHERE
(masa BETWEEN 15 AND 24 AND koszt BETWEEN 0.15 AND 0.24 )
OR 
(masa BETWEEN 25 AND 35 AND koszt BETWEEN 0.25 AND 0.35 );
						   
-- 3. --
SELECT nazwa, masa, koszt 
FROM czekoladki
WHERE
masa BETWEEN 15 AND 24 AND koszt BETWEEN 0.15 AND 0.24; 

-- 4. --
SELECT nazwa, masa, koszt 
FROM czekoladki
WHERE
masa BETWEEN 25 AND 35 AND koszt NOT BETWEEN 0.25 AND 0.35; 
						   
-- 5. --
SELECT nazwa, masa, koszt 
FROM czekoladki
WHERE
(masa BETWEEN 25 AND 35 AND koszt NOT BETWEEN 0.15 AND 0.24 )
AND
(masa BETWEEN 25 AND 35 AND koszt NOT BETWEEN 0.25 AND 0.35 );

-- -------------------- Zad. 2.7 ------------------------------------------ -- 
--\a format unaligned\aligned
--\f '*' field separator *-anything you want
--\H format html\aligned
--\o [file.format] redirect to file

-- -------------------- Zad. 2.8 ------------------------------------------ -- 
--1 In script \o [file.txt] and select. To use script -> psql <file.sql> <- in it's directory
--2 Add \H for html format

						   
						   

										 
										 
										 
										 