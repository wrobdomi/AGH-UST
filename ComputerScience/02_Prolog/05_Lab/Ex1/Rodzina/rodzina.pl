/* Pobrac program r-fam.pl
Przegladnac calosc,
Zadac pytania : */


% Jakie sa osoby w bazie ?
istnieje(X).

% Jakie sa dzieci w bazie ?
dziecko(X).

% Pokazac pensje wszystkich osob.
istnieje(X),pensja(X,P).

% Jakie dzieci urodzily sie w 1979r ?
dziecko(X),data_urodzenia(X,data(_,_,Y)),Y == 1979.

% Znalezc wszystkie zony, ktore pracuja.
zona(osoba(I,N,_,pracuje(_,_))).

% Znalezc osoby urodzone przed 1950 r, ktorych pensja jest rowna 3000
istnieje(osoba(I,N,data(_,_,R),pracuje(_,P))),R<1950,P==3000.

% Korzystajac z wiedzy zdobytej na poprzednim laboratorium, prosze policzyc
% zarobki wszystkich osob:
bagof(X,istnieje(X),L),zarobki(L,Z).

% Dopisac kolejne dwie rodziny do reprfam.pl

