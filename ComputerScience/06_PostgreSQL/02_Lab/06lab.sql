-- Lab. 6 --
-- INSERT INTO table (...) VALUES (...)
-- DELETE FROM tabela WHERE ...
-- UPDATE tabela SET artrybut1 = wartosc1, atrybut2 = wartosc2, ...
-- 

-- -------------------- 6.1 ------------------------------------------ -- 

-- 1. --
INSERT INTO czekoladki 
VALUES ('W98', 'Biały Kieł', 'biała', 'laskowe', 'marcepan', 
		'Rozpływające się w rękach i kieszeniach', 45, 20);

-- 2. --
INSERT INTO klienci
VALUES(90, 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad',
	   '31-471', '031 423 45 38');

INSERT INTO klienci
VALUES(91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad',
	   '31-471', '031 423 45 38');
	   
INSERT INTO klienci
VALUES(92, 'Kimono Franek', 'Karateków 8', 'Mistrz',
	   '30-029', '501 498 324');

-- 3. --
INSERT INTO klienci 
	( SELECT '93', 'Iza Matusiak', ulica, miejscowosc, kod, telefon  
	   FROM klienci 
	   WHERE nazwa = 'Matusiak Edward');
	   



-- -------------------- 6.2 ------------------------------------------ -- 

-- 1. --
INSERT INTO czekoladki
VALUES('X91', 'Nieznana Nieznajoma', null, null, null,
	   'Niewidzialna czekoladka wspomagajaca odchudzanie', 26, 0);

INSERT INTO czekoladki
VALUES('M98', 'Mleczny Raj', 'mleczna', null, null,
	   'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem', 26, 36);



-- -------------------- 6.3 ------------------------------------------ -- 

-- 1. --
DELETE FROM czekoladki
WHERE idczekoladki = 'M98';

-- 2. --
DELETE FROM czekoladki
WHERE idczekoladki = 'X91';

-- 3. --
INSERT INTO czekoladki(idczekoladki, nazwa, czekolada, orzechy, nadzienie, opis, koszt, masa)
VALUES('X91', 'Nieznana Nieznajoma', null, null, null,
	   'Niewidzialna czekoladka wspomagajaca odchudzanie', 26, 0);

INSERT INTO czekoladki(idczekoladki, nazwa, czekolada, orzechy, nadzienie, opis, koszt, masa)
VALUES('M98', 'Mleczny Raj', 'mleczna', null, null,
	   'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem', 26, 36);



 
-- -------------------- 6.4 ------------------------------------------ -- 

-- 1. --
UPDATE klienci
SET nazwa = 'Nowak Iza'
WHERE nazwa = 'Matusiak Iza';

-- 2. --
UPDATE czekoladki
SET koszt = 0.9 * koszt
WHERE idczekoladki IN ('W98','M98','X91');

-- 3. --
UPDATE czekoladki
SET koszt = ( SELECT koszt FROM czekoladki WHERE idczekoladki = 'W98' )
WHERE nazwa = 'Nieznana Nieznajoma';;

-- 4. --
UPDATE klienci 
SET miejscowosc = 'Piotrograd'
WHERE miejscowosc = 'Leningrad';

-- 5. --
UPDATE czekoladki
SET koszt = koszt + 15
WHERE idczekoladki SIMILAR TO '_9[1-9]';



-- ------------------------- 6.5 ------------------------------------- --

-- 1. --
DELETE FROM klienci
WHERE nazwa SIMILAR TO '%Matusiak';

-- 2. --
DELETE FROM klienci
WHERE idklienta > 91;

-- 3. --
DELETE FROM klienci
WHERE koszt >= 0.45 OR masa >= 36 OR masa = 0;




