-- Lab. 11 --
-- plpgsql

-- -------------------- 11.1.1 ------------------------------------------ -- 

CREATE OR REPLACE FUNCTION masaPudelka(IN idP CHAR(4))
RETURNS NUMERIC(10,2) AS
$$
	DECLARE
		masa NUMERIC(10,2);
	BEGIN
		SELECT sum(z.sztuk*c.masa) INTO masa
	   	FROM pudelka p
	   	JOIN zawartosc z USING(idpudelka)
	   	JOIN czekoladki c USING(idczekoladki)
		WHERE p.idpudelka = idP 
   		GROUP BY idpudelka;
   		
	   	RETURN masa;
	   	
	END
$$ LANGUAGE plpgsql;
												   
-- -------------------- 11.1.2 ------------------------------------------ --
												   
CREATE OR REPLACE FUNCTION liczbaCzekoladek(IN idP CHAR(4))
RETURNS Integer AS
$$
	DECLARE
		liczba Integer;
	BEGIN
		
		SELECT sum(z.sztuk) INTO liczba
		FROM pudelka p
		JOIN zawartosc z USING(idpudelka)
		WHERE p.idpudelka = idP
		GROUP BY idpudelka;
	
		RETURN liczba; 
														
	END
$$ LANGUAGE plpgsql;
						
														
-- -------------------- 11.2.1 ------------------------------------------ --		

CREATE OR REPLACE FUNCTION zysk(idp CHAR(4))														
RETURNS NUMERIC(10,2) AS
$BODY$
	DECLARE 									 
		cenap numeric(7,2);
		kosztw numeric(10,2);
	 	roznica numeric(10,2);
	BEGIN									 
 	SELECT p.cena INTO cenap
 	FROM pudelka p WHERE p.idpudelka = idp;
										 
 	SELECT sum(kosztczeko) INTO kosztw FROM
	( 
		SELECT sum( z.sztuk * c.koszt ) AS kosztczeko
		FROM pudelka p 
		JOIN zawartosc z USING(idpudelka)
		JOIN czekoladki c USING(idczekoladki)
		WHERE p.idpudelka = idp
	) rel;
										 										 
	kosztw := kosztw + 0.90;
	
	roznica := cenap - kosztw;
	RETURN roznica;
										 
 	END
$BODY$ LANGUAGE plpgsql;

										 
-- -------------------- 11.2.2 ------------------------------------------ --	

SELECT SUM(zysk(a.idpudelka)*a.sztuk)
FROM
	zamowienia z
 	NATURAL JOIN artykuly a
WHERE 
	z.datarealizacji >= '2013-11-11'
	AND z.datarealizacji <= '2013-11-17'
										 
-- -------------------- 11.3.1 ------------------------------------------ --	

CREATE OR REPLACE FUNCTION sumaZamowien(idk INTEGER)
RETURNS NUMERIC(10,2) AS
$BODY$
										 
	DECLARE
 		suma NUMERIC(10,2);	
										 
	BEGIN
										 
 		SELECT sum(zysk(pudelkop)*sztuki) INTO suma
		FROM
	 	(
			SELECT a.idpudelka AS pudelkop, a.sztuk AS sztuki
			FROM klienci k 
			JOIN zamowienia z USING(idklienta)
			JOIN artykuly a USING(idzamowienia)
			WHERE k.idklienta = idk
		) rel ;
			
	 	RETURN suma;
	END
$BODY$ LANGUAGE plpgsql
		 
-- lub liczac tylko cene pudelek										

CREATE OR REPLACE FUNCTION sumaZamowien(in arg1 INTEGER)
RETURNS INTEGER AS
$$
DECLARE 
    wynik INTEGER;
BEGIN
    SELECT SUM(a.sztuk*p.cena) INTO wynik
    FROM
        zamowienia z
        NATURAL JOIN artykuly a
        NATURAL JOIN pudelka p
    WHERE z.idklienta = arg1;

    RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT sumaZamowien(1);

										 
-- -------------------- 11.3.2 ------------------------------------------ --	
	
CREATE OR REPLACE FUNCTION rabat(idk INTEGER)
RETURNS INTEGER AS
$BODY$
	DECLARE
 		rabat INTEGER;
		wartosc INTEGER;
 	BEGIN
										 
	 	SELECT SUM(a.sztuk*p.cena) INTO wartosc
		FROM
			zamowienia z
			NATURAL JOIN artykuly a
			NATURAL JOIN pudelka p
		WHERE z.idklienta = idk;
										 
		CASE
	 		WHEN wartosc BETWEEN 101 AND 200 THEN rabat := 4;
 			WHEN wartosc BETWEEN 201 AND 400 THEN rabat := 7;
	 		WHEN wartosc > 400 THEN rabat := 8;
	 		ELSE rabat := 0;
		END CASE;
										 
 		RETURN rabat;
										 
 	END
$BODY$ LANGUAGE plpgsql;

-- -------------------- 11.4 ------------------------------------------ --

CREATE OR REPLACE FUNCTION podwyzka()
RETURNS VOID AS
$BODY$
	DECLARE czeko RECORD;
	DECLARE zaw RECORD;		
 	DECLARE podwyzka NUMERIC(5,2);
 		
	BEGIN
 		FOR czeko IN SELECT * FROM czekoladki
		LOOP
			
		 	IF czeko.koszt < 0.20 
			THEN podwyzka := 0.03;
	 		ELSIF czeko.koszt BETWEEN 0.20 AND 0.29
			THEN podwyzka := 0.04;	
			ELSE podwyzka := 0.05;
		 	END IF;
					
			UPDATE czekoladki SET koszt = koszt + podwyzka 
		 	WHERE czekoladki.idczekoladki = czeko.idczekoladki;										 
										 
										 
 			FOR zaw IN SELECT * FROM zawartosc WHERE idczekoladki = czeko.idczekoladki
			LOOP
				UPDATE pudelka SET cena = cena + zaw.sztuk * podwyzka WHERE idpudelka = zaw.idpudelka;
		 	END LOOP;
										 
	 	END LOOP;
 	END
										 
$BODY$ LANGUAGE plpgsql;
						
										 
-- -------------------- 11.5 ------------------------------------------ -- 

CREATE OR REPLACE FUNCTION obnizka()
RETURNS VOID AS
$BODY$
	DECLARE czeko RECORD;
	DECLARE zaw RECORD;
	DECLARE obniz NUMERIC(4,2);
										 
 	BEGIN
		
	 	FOR czeko IN SELECT * FROM czekoladki
		LOOP
			
			CASE 
		 		WHEN czeko.koszt < 0.23 THEN obniz := 0.03;
	 			WHEN czeko.koszt BETWEEN 0.23 AND 0.33 THEN obniz := 0.04;
			 	ELSE obniz := 0.05;
		 	END CASE;
				
 			UPDATE czekoladki SET koszt = koszt - obniz WHERE idczekoladki = czeko.idczekoladki;
										 
 			FOR zaw IN SELECT * FROM zawartosc WHERE idczekoladki = czeko.idczekoladki
			LOOP
		 		UPDATE pudelka SET cena = cena - obniz * zaw.sztuk WHERE idpudelka = zaw.idpudelka;
			END LOOP;							 
										 
										 
		END LOOP;
										 
	END
										 
$BODY$ LANGUAGE plpgsql;
							
										 
-- -------------------- 11.6.1 ------------------------------------------ -- 	
									 
CREATE OR REPLACE FUNCTION zamowienia(idk INTEGER)
RETURNS SETOF RECORD AS
$BODY$
	BEGIN
		RETURN QUERY
	 	SELECT idzamowienia, idklienta, datarealizacji
	 	FROM klienci JOIN zamowienia USING(idklienta)
		WHERE idklienta = idk;
	END
$BODY$ LANGUAGE plpgsql;
										 
-- -------------------- 11.7 ------------------------------------------ -- 	
										 
CREATE OR REPLACE FUNCTION kwiaciarnia.rabat(in arg1 VARCHAR(10))
RETURNS INTEGER AS
$$
DECLARE wynik INTEGER;
DECLARE wartoscZamowien INTEGER;
DECLARE wartoscHistorii INTEGER;
DECLARE wartoscSuma INTEGER;
BEGIN
    SELECT SUM(cena) INTO wartoscZamowien
    FROM
        kwiaciarnia.zamowienia
    WHERE idklienta = arg1;

    SELECT SUM(cena) INTO wartoscHistorii
    FROM
        kwiaciarnia.historia
    WHERE idklienta = arg1 AND termin > CURRENT_DATE - interval '7 days';

    wartoscSuma := wartoscZamowien + wartoscHistorii;

    IF wartoscZamowien BETWEEN 1 AND 100 THEN
        wynik := 5;
    ELSIF wartoscZamowien BETWEEN 101 AND 400 THEN
        wynik := 10;
    ELSIF wartoscZamowien BETWEEN 401 AND 700 THEN
        wynik := 15;
    ELSIF wartoscZamowien > 700 THEN
        wynik := 20;
    ELSE
        wynik := 0;
    END IF;

    RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT kwiaciarnia.rabat('msowins');