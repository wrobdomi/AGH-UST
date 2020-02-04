
% Zapisac predykat a2b do pliku listy-1.pl
% Patrz -> listy.pl

% a2b([a,a,a],[b,b,b]).
% Z pierwszym predykatem sie nie unifikuje wiec
% przechodzi do drugiego, Uwaga: w drugim jest pierwszym
% argumentem stala a w pierwszej i b w drugiej liscie
% dlatego musi byc a i b na poczatku tych list aby sie to
% unifikowalo, lista jest skracana o jedno a i jedno b
% w kazdej iteracji az dochodzi do pustych list
% i zwraca true do wyzszego poziomu

% Call: (7) a2b([a, a, a], [b, b, b]) ? creep
% Call: (8) a2b([a, a], [b, b]) ? creep
% Call: (9) a2b([a], [b]) ? creep
% Call: (10) a2b([], []) ? creep
% Exit: (10) a2b([], []) ? creep
% Exit: (9) a2b([a], [b]) ? creep
% Exit: (8) a2b([a, a], [b, b]) ? creep
% Exit: (7) a2b([a, a, a], [b, b, b]) ? creep


% a2b([a,a,a,a],[b,b,b]).
% podobnie jak wyzej, ale tym razem przy koncu
% przy wejsciu do drugiego predykatu mamy w jedenej liscie
% [a], a druga jest [], to sie nie unifikuje i zwraca false
% do wyzszych wywolan

% Call: (7) a2b([a, a, a, a], [b, b, b]) ? creep
% Call: (8) a2b([a, a, a], [b, b]) ? creep
% Call: (9) a2b([a, a], [b]) ? creep
% Call: (10) a2b([a], []) ? creep
% Fail: (10) a2b([a], []) ? creep
% Fail: (9) a2b([a, a], [b]) ? creep
% Fail: (8) a2b([a, a, a], [b, b]) ? creep
% Fail: (7) a2b([a, a, a, a], [b, b, b]) ? creep
% false.


% a2b([a,s,d],[b,s,d]).
% Tutaj jest ten problem, że stala s
% sie nie unifikuje z a, ani b
% wiec juz przy drugm wywolaniu
% sie nie unifikuja i zwracane jest false


% a2b([a,a,a,a],X).
% Call: (7) a2b([a, a, a, a], _G1828) ? creep
% Call: (8) a2b([a, a, a], _G1909) ? creep
% Call: (9) a2b([a, a], _G1912) ? creep
% Call: (10) a2b([a], _G1915) ? creep
% Call: (11) a2b([], _G1918) ? creep
% Exit: (11) a2b([], []) ? creep
% Exit: (10) a2b([a], [b]) ? creep
% Exit: (9) a2b([a, a], [b, b]) ? creep
% Exit: (8) a2b([a, a, a], [b, b, b]) ? creep
% Exit: (7) a2b([a, a, a, a], [b, b, b, b]) ? creep
% X = [b, b, b, b].
% Chodzi o to, że najpierw X = [b,Tb], a w kolejnych
% wywolaniach drugiego predykatu Tb jest przypisywane do
% nowego  [ b | Tb ]


% Dokladnie tak jak wyzej, ale teraz
% druga zmienna jest przypisywana w ten sposob
% a2b(X,[b,b]).
% Call: (7) a2b(_G1821, [b, b]) ? creep
% Call: (8) a2b(_G1897, [b]) ? creep
% Call: (9) a2b(_G1900, []) ? creep
% Exit: (9) a2b([], []) ? creep
% Exit: (8) a2b([a], [b]) ? creep
% Exit: (7) a2b([a, a], [b, b]) ? creep
% X = [a, a].


% a2b(X,Y).
% Call: (7) a2b(_G1815, _G1816) ? creep
% Exit: (7) a2b([], []) ? creep
% Zmienne unifikuja sie z pustymi listami,
% obie zmienne dostaja ta sama wartosc i sa 
% pustymi listami, po pierwszym predykacie
% dostajemy true


