% Dopisac predykat dodaj, patrz listy.pl
% Sprawdzic i przemyslec dzialanie ponizszych:

dodaj(a,[c,d],X).
   Call: (7) dodaj(a, [c, d], _G1823) ? creep
   Exit: (7) dodaj(a, [c, d], [a, c, d]) ? creep
X = [a, c, d].


dodaj([a,b],[c,d],X).
   Call: (7) dodaj([a, b], [c, d], _G1829) ? creep
   Exit: (7) dodaj([a, b], [c, d], [[a, b], c, d]) ? creep
X = [[a, b], c, d].

