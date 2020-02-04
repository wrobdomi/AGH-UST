% Dopisac predykat nalezy do pliku listy-1.pl
% Patrz -> listy.pl

% Sprawdzic i przemyslec dzialanie ponizszych:

% nalezy(c,[a,b,c,d]).
% unifikacja nie zachodzi z pierwszym, ale
% zachodzi z drugim, w koncu zachodzi z pierwszym gdy 
% c jest na poczatku
% true, c jest stala 
% zawierajaca sie w liscie
% Call: (7) nalezy(c, [a, b, c, d]) ? creep
% Call: (8) nalezy(c, [b, c, d]) ? creep
% Call: (9) nalezy(c, [c, d]) ? creep
% Exit: (9) nalezy(c, [c, d]) ? creep
% Exit: (8) nalezy(c, [b, c, d]) ? creep
% Exit: (7) nalezy(c, [a, b, c, d]) ? creep


% nalezy(x,[a,b,c,d])
% unifikacja nigdy nie zachodzi w pierwszym 
% w koncu nie zachodzi z zadnym gdy jest pusta lista
% false, x jest stala
% nie zawierajaca sie w liscie
% Call: (7) nalezy(x, [a, b, c, d]) ? creep
% Call: (8) nalezy(x, [b, c, d]) ? creep
% Call: (9) nalezy(x, [c, d]) ? creep
% Call: (10) nalezy(x, [d]) ? creep
% Call: (11) nalezy(x, []) ? creep
% Fail: (11) nalezy(x, []) ? creep
% Fail: (10) nalezy(x, [d]) ? creep
% Fail: (9) nalezy(x, [c, d]) ? creep
% Fail: (8) nalezy(x, [b, c, d]) ? creep
% Fail: (7) nalezy(x, [a, b, c, d]) ? creep


% nalezy(X,[a,b,c,d]).
% unifikacja z pierwszym sie powiedzie dla X = a
% pozniej redo, czyli ;, czyli przechodzimy do drugiego
% unifikacja z drugim sie powiedzie, wywola pierwszy
% unifikacja z pierwszym sie powiedzie zwroci X = b
% poziom wyzej zwroci X = b
% pozniej redo, czyli przechodzimy do drugiego od momentu
% gdy c jest pierwsze, unifikacja z drugim sie powiedzie
% i z pierwszym takze, zwraca true, poziom wyzej zwraca true
% i jeszcze poziom wyzej zwraca true itd.
%all: (7) nalezy(_G1827, [a, b, c, d]) ? creep
%   Exit: (7) nalezy(a, [a, b, c, d]) ? creep
%X = a ;
%   Redo: (7) nalezy(_G1827, [a, b, c, d]) ? creep
%   Call: (8) nalezy(_G1827, [b, c, d]) ? creep
%   Exit: (8) nalezy(b, [b, c, d]) ? creep
%   Exit: (7) nalezy(b, [a, b, c, d]) ? creep
%X = b ;
%   Redo: (8) nalezy(_G1827, [b, c, d]) ? creep
%   Call: (9) nalezy(_G1827, [c, d]) ? creep
%   Exit: (9) nalezy(c, [c, d]) ? creep
%   Exit: (8) nalezy(c, [b, c, d]) ? creep
%   Exit: (7) nalezy(c, [a, b, c, d]) ? creep
%X = c ;
%   Redo: (9) nalezy(_G1827, [c, d]) ? creep
%   Call: (10) nalezy(_G1827, [d]) ? creep
%   Exit: (10) nalezy(d, [d]) ? creep
%   Exit: (9) nalezy(d, [c, d]) ? creep
%   Exit: (8) nalezy(d, [b, c, d]) ? creep
%   Exit: (7) nalezy(d, [a, b, c, d]) ? creep
%X = d ;
%   Redo: (10) nalezy(_G1827, [d]) ? creep
%   Call: (11) nalezy(_G1827, []) ? creep
%   Fail: (11) nalezy(_G1827, []) ? creep
%   Fail: (10) nalezy(_G1827, [d]) ? creep
%   Fail: (9) nalezy(_G1827, [c, d]) ? creep
%   Fail: (8) nalezy(_G1827, [b, c, d]) ? creep
%   Fail: (7) nalezy(_G1827, [a, b, c, d]) ? creep
%false.


% nalezy(x,a).
% false
% w pierwszym unifikacja sie nie powiedzie, przechodzi do drugiego
% tutaj takze unifikacja sie nie powiedzie
% zwraca false


% nalezy(X,a).
% tak jak wyzej, czyli
% w pierwszym unifikacja sie nie powiedzie, przechodzi do drugiego
% tutaj takze unifikacja sie nie powiedzie
% zwraca false

