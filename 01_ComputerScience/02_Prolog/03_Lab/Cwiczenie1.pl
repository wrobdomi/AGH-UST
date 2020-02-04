% Prosze sprawdzic ponizsze unifikacje

% 1 
% X = [a,b,c].
% Poprawnie, X = [a,b,c].

% 2
% [X|Y] = [a,b,c].
% Poprawnie, X = a, Y = [b,c].

% 3
% [[a,b],c]=[X,Y].
% Poprawnie, X = [a, b], Y = c.

% 4
% [a(b),c(X)]=[Z,c(a)].
% Poprawnie, X = a, Z = a(b).

% 5 
% [X|Y]=[a].
% Poprawnie, X = a, Y = [].


% Wybieranie trzeciego elementu z listy
% trzeci([A,B,C|Reszta],C) = trzeci([a,b,c,d,e],X).
% A = a,
% B = b,
% C = X, X = c,
% Reszta = [d, e].

% Wybieranie czwartego elementu z listy
% czwarty([A,B,C,D|Reszta],D) = czwarty([1,2,3,4,5,6,7],D).
% A = 1,
% B = 2,
% C = 3,
% D = 4,
% Reszta = [5, 6, 7].

% Zdefiniowac predykat porownujacy dwa wybrane elementy listy 
% np. 3 i 4
% Patrz -> porownaj.pl

% Zdefiniowac predykat zamieniajacy 2 wybrane elementy listy 
% np. 3 i 4
% Patrz -> zamien.pl	
