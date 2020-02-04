-- Lab. 1 --
-- psql console 

-- -------------------- Zad. 1.1 ------------------------------------------ -- 

\l 	wyświetla listę baz danych
\dt 	wyświetla listę tabel w bieżącej BD
\d nazwa_tabeli 	wyświetla strukturę tabeli
\? 	wyświetla pomoc odnośnie poleceń psql
\h 	wyświetla pomoc odnośnie SQL
\q 	kończy pracę z psql
\i nazwa_pliku 	wykonuje skrypt
\dn 	wyświetla nazwy schematów 

select nazwa, opis from czekoladki;

select nazwa, cena, stan from pudelka;

select * from klienci;

-- -------------------- Zad. 1.2 ------------------------------------------ -- 

set search_path to siatkowka;
\dt
select imie, nazwisko from siatkarki;
set search_path to public;
select imie, nazwisko from siatkarki;
set search_path to public, siatkowka;
\dt