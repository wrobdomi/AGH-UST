% Dopisac predykat dlugosc do pliku listy.pl
% Patrz -> listy.pl

% Sprawdzic i przemyslec dzialanie ponizszych
% dlugosc([a,b,c],X).
% Na poczatku pierwszy predykat sie nie unifikuje,
% unifikuje sie drugi, za kazdym razem wola on pierwszy,
% ale on sie nie unifikuje i znowu wolany jest drugi
% który sie unifikuje i tak az do pustej listy
% Wazne: Na kazdym poziomie jest przypisanie
% X = Dlug = _0n, gdzie n to numer poziomu,
% kazdy poziom ma w tym przykladzie oddzielna zmienna

%  Call: (7) dlugosc([a, b, c], _G1825) ? creep
%  Call: (8) dlugosc([b, c], _G1910) ? creep
%  Call: (9) dlugosc([c], _G1910) ? creep
%  Call: (10) dlugosc([], _G1910) ? creep
%  Exit: (10) dlugosc([], 0) ? creep
%  Call: (10) _G1912 is 0+1 ? creep
%  Exit: (10) 1 is 0+1 ? creep
%  Exit: (9) dlugosc([c], 1) ? creep
%  Call: (9) _G1915 is 1+1 ? creep
%  Exit: (9) 2 is 1+1 ? creep
%  Exit: (8) dlugosc([b, c], 2) ? creep
%  Call: (8) _G1825 is 2+1 ? creep
%  Exit: (8) 3 is 2+1 ? creep
%  Exit: (7) dlugosc([a, b, c], 3) ? creep

%
%
