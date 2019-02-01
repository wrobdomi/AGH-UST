% Dopisac predykat sklej do pliku listy-1.pl
% Patrz -> listy.pl

% sklej([a,b],[c,d],X).
% sklej bierze z pierwszego argumentu zawsze pierwszy element i dodaje go na 
% poczatek trzeciego argumentu. W ostatniej iteracji, czyli w warunku stopu caly drugi argument jest 
% dodawany na koniec trzeciego argumentu, wracajac do gory coraz to szersza koncowka
% jest dodawana do listy:
% [c,d]
% [b,c,d]
% [a,b,c,d]
% Call: (7) sklej([a, b], [c, d], _G2367) ? creep
%   Call: (8) sklej([b], [c, d], _G2449) ? creep
%   Call: (9) sklej([], [c, d], _G2452) ? creep
%   Exit: (9) sklej([], [c, d], [c, d]) ? creep
%   Exit: (8) sklej([b], [c, d], [b, c, d]) ? creep
%   Exit: (7) sklej([a, b], [c, d], [a, b, c, d]) ? creep


% sklej([a,b], X, [c,d]).
%   nie unifikuje sie od razu, bo w drugim wywolaniu jest X=a, 
%   z pierwszego argumentu, a z trzeciego jest poxniej X=c
%   Call: (7) sklej([a, b], _G2366, [c, d]) ? creep
%   Fail: (7) sklej([a, b], _G2366, [c, d]) ? creep


% sklej([a,b], X, [a,b,c,d]).
% oczywiste, zgodnie z dzialaniem predykatu wyjasnionym na poczatku
%   Call: (7) sklej([a, b], _G2372, [a, b, c, d]) ? creep
%   Call: (8) sklej([b], _G2372, [b, c, d]) ? creep
%   Call: (9) sklej([], _G2372, [c, d]) ? creep
%   Exit: (9) sklej([], [c, d], [c, d]) ? creep
%   Exit: (8) sklej([b], [c, d], [b, c, d]) ? creep
%   Exit: (7) sklej([a, b], [c, d], [a, b, c, d]) ? creep
% X = [c, d].


% sklej(A, B, [a,b,c,d,e]).
%   Call: (7) sklej(_G2368, _G2369, [a, b, c, d, e]) ? creep
%   Exit: (7) sklej([], [a, b, c, d, e], [a, b, c, d, e]) ? creep
% A = [],
% B = [a, b, c, d, e] .

% [trace]  ?- sklej(A, B, [a,b,c,d,e]).
% zgodnie z dzialaniem patrzymy na mozliwosci ktore doprowadza
% do sklejenie do postaci tablicy [a,b,c,d,e]
%    Call: (7) sklej(_G2368, _G2369, [a, b, c, d, e]) ? creep
%    Exit: (7) sklej([], [a, b, c, d, e], [a, b, c, d, e]) ? creep
% A = [],
% B = [a, b, c, d, e] 
% ;
%   Redo: (7) sklej(_G2368, _G2369, [a, b, c, d, e]) ? creep
%   Call: (8) sklej(_G2470, _G2369, [b, c, d, e]) ? creep
%   Exit: (8) sklej([], [b, c, d, e], [b, c, d, e]) ? creep
%   Exit: (7) sklej([a], [b, c, d, e], [a, b, c, d, e]) ? creep
% A = [a],
% B = [b, c, d, e] ;
%   Redo: (8) sklej(_G2470, _G2369, [b, c, d, e]) ? creep
%   Call: (9) sklej(_G2473, _G2369, [c, d, e]) ? creep
%   Exit: (9) sklej([], [c, d, e], [c, d, e]) ? creep
%   Exit: (8) sklej([b], [c, d, e], [b, c, d, e]) ? creep
%   Exit: (7) sklej([a, b], [c, d, e], [a, b, c, d, e]) ? creep
% A = [a, b],
% B = [c, d, e] ;
%   Redo: (9) sklej(_G2473, _G2369, [c, d, e]) ? creep
%   Call: (10) sklej(_G2476, _G2369, [d, e]) ? creep
%   Exit: (10) sklej([], [d, e], [d, e]) ? creep
%   Exit: (9) sklej([c], [d, e], [c, d, e]) ? creep
%   Exit: (8) sklej([b, c], [d, e], [b, c, d, e]) ? creep
%   Exit: (7) sklej([a, b, c], [d, e], [a, b, c, d, e]) ? creep
% A = [a, b, c],
% B = [d, e] ;
%   Redo: (10) sklej(_G2476, _G2369, [d, e]) ? creep
%   Call: (11) sklej(_G2479, _G2369, [e]) ? creep
%   Exit: (11) sklej([], [e], [e]) ? creep
%   Exit: (10) sklej([d], [e], [d, e]) ? creep
%   Exit: (9) sklej([c, d], [e], [c, d, e]) ? creep
%   Exit: (8) sklej([b, c, d], [e], [b, c, d, e]) ? creep
%   Exit: (7) sklej([a, b, c, d], [e], [a, b, c, d, e]) ? creep
% A = [a, b, c, d],
% B = [e] ;
%   Redo: (11) sklej(_G2479, _G2369, [e]) ? creep
%   Call: (12) sklej(_G2482, _G2369, []) ? creep
%   Exit: (12) sklej([], [], []) ? creep
%   Exit: (11) sklej([e], [], [e]) ? creep
%   Exit: (10) sklej([d, e], [], [d, e]) ? creep
%   Exit: (9) sklej([c, d, e], [], [c, d, e]) ? creep
%   Exit: (8) sklej([b, c, d, e], [], [b, c, d, e]) ? creep
%   Exit: (7) sklej([a, b, c, d, e], [], [a, b, c, d, e]) ? creep
% A = [a, b, c, d, e],
% B = [] ;
%   Redo: (12) sklej(_G2482, _G2369, []) ? creep
%   Fail: (12) sklej(_G2482, _G2369, []) ? creep
%   Fail: (11) sklej(_G2479, _G2369, [e]) ? creep
%   Fail: (10) sklej(_G2476, _G2369, [d, e]) ? creep
%   Fail: (9) sklej(_G2473, _G2369, [c, d, e]) ? creep
%   Fail: (8) sklej(_G2470, _G2369, [b, c, d, e]) ? creep
%   Fail: (7) sklej(_G2368, _G2369, [a, b, c, d, e]) ? creep
% false.

% sklej([1,2,3],[a,b,c],X).
%   Call: (7) sklej([1, 2, 3], [a, b, c], _G2403) ? creep
%   Call: (8) sklej([2, 3], [a, b, c], _G2491) ? creep
%   Call: (9) sklej([3], [a, b, c], _G2494) ? creep
%   Call: (10) sklej([], [a, b, c], _G2497) ? creep
%   Exit: (10) sklej([], [a, b, c], [a, b, c]) ? creep
%   Exit: (9) sklej([3], [a, b, c], [3, a, b, c]) ? creep
%   Exit: (8) sklej([2, 3], [a, b, c], [2, 3, a, b, c]) ? creep
%   Exit: (7) sklej([1, 2, 3], [a, b, c], [1, 2, 3, a, b, c]) ? creep
% X = [1, 2, 3, a, b, c].

% sklej([1,2,3],[a(e),b(f),c(d,g)],X).
%   Call: (7) sklej([1, 2, 3], [a(e), b(f), c(d, g)], _G2780) ? creep
%   Call: (8) sklej([2, 3], [a(e), b(f), c(d, g)], _G2875) ? creep
%   Call: (9) sklej([3], [a(e), b(f), c(d, g)], _G2878) ? creep
%   Call: (10) sklej([], [a(e), b(f), c(d, g)], _G2881) ? creep
%   Exit: (10) sklej([], [a(e), b(f), c(d, g)], [a(e), b(f), c(d, g)]) ? creep
%   Exit: (9) sklej([3], [a(e), b(f), c(d, g)], [3, a(e), b(f), c(d, g)]) ? creep
%   Exit: (8) sklej([2, 3], [a(e), b(f), c(d, g)], [2, 3, a(e), b(f), c(d, g)]) ? creep
%   Exit: (7) sklej([1, 2, 3], [a(e), b(f), c(d, g)], [1, 2, 3, a(e), b(f), c(d, g)]) ? creep
% X = [1, 2, 3, a(e), b(f), c(d, g)].

% sklej(Przed,[5|Po],[1,2,3,4,5,6,7,8,9]).
%   Call: (7) sklej(_G3035, [5|_G3006], [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
%   Call: (8) sklej(_G3152, [5|_G3006], [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
%   Call: (9) sklej(_G3155, [5|_G3006], [3, 4, 5, 6, 7, 8, 9]) ? creep
%   Call: (10) sklej(_G3158, [5|_G3006], [4, 5, 6, 7, 8, 9]) ? creep
%   Call: (11) sklej(_G3161, [5|_G3006], [5, 6, 7, 8, 9]) ? creep
%   Exit: (11) sklej([], [5, 6, 7, 8, 9], [5, 6, 7, 8, 9]) ? creep
%   Exit: (10) sklej([4], [5, 6, 7, 8, 9], [4, 5, 6, 7, 8, 9]) ? creep
%   Exit: (9) sklej([3, 4], [5, 6, 7, 8, 9], [3, 4, 5, 6, 7, 8, 9]) ? creep
%   Exit: (8) sklej([2, 3, 4], [5, 6, 7, 8, 9], [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
%   Exit: (7) sklej([1, 2, 3, 4], [5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
% Przed = [1, 2, 3, 4],
% Po = [6, 7, 8, 9] .


% sklej(_,[A,5,B|_],[1,2,3,4,5,6,7,8,9]).
%   Call: (7) sklej(_G3041, [_G3005, 5, _G3011|_G3012], [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
%   Call: (8) sklej(_G3170, [_G3005, 5, _G3011|_G3012], [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
%   Call: (9) sklej(_G3173, [_G3005, 5, _G3011|_G3012], [3, 4, 5, 6, 7, 8, 9]) ? creep
%   Call: (10) sklej(_G3176, [_G3005, 5, _G3011|_G3012], [4, 5, 6, 7, 8, 9]) ? creep
%   Exit: (10) sklej([], [4, 5, 6, 7, 8, 9], [4, 5, 6, 7, 8, 9]) ? creep
%   Exit: (9) sklej([3], [4, 5, 6, 7, 8, 9], [3, 4, 5, 6, 7, 8, 9]) ? creep
%   Exit: (8) sklej([2, 3], [4, 5, 6, 7, 8, 9], [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
%   Exit: (7) sklej([1, 2, 3], [4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
% A = 4,
% B = 6 .

% sklej(A,[x,x,x|_],[a,b,x,x,c,x,x,x,d,e]).
%   Call: (7) sklej(_G3044, [x, x, x|_G3012], [a, b, x, x, c, x, x, x|...]) ? creep
%   Call: (8) sklej(_G3158, [x, x, x|_G3012], [b, x, x, c, x, x, x, d|...]) ? creep
%   Call: (9) sklej(_G3161, [x, x, x|_G3012], [x, x, c, x, x, x, d, e]) ? creep
%   Call: (10) sklej(_G3164, [x, x, x|_G3012], [x, c, x, x, x, d, e]) ? creep
%   Call: (11) sklej(_G3167, [x, x, x|_G3012], [c, x, x, x, d, e]) ? creep
%   Call: (12) sklej(_G3170, [x, x, x|_G3012], [x, x, x, d, e]) ? creep
%   Exit: (12) sklej([], [x, x, x, d, e], [x, x, x, d, e]) ? creep
%   Exit: (11) sklej([c], [x, x, x, d, e], [c, x, x, x, d, e]) ? creep
%   Exit: (10) sklej([x, c], [x, x, x, d, e], [x, c, x, x, x, d, e]) ? creep
%   Exit: (9) sklej([x, x, c], [x, x, x, d, e], [x, x, c, x, x, x, d, e]) ? creep
%   Exit: (8) sklej([b, x, x, c], [x, x, x, d, e], [b, x, x, c, x, x, x, d|...]) ? creep
%   Exit: (7) sklej([a, b, x, x, c], [x, x, x, d, e], [a, b, x, x, c, x, x, x|...]) ? creep
% A = [a, b, x, x, c] .


% Dopisac i przetestowac predykat nalezy1 -> patrz listy.pl
% nalezy1(X,[a,b,c,d]).
%   Call: (7) nalezy1(_G3047, [a, b, c, d]) ? creep
%   Call: (8) sklej(_G3138, [_G3047|_G3129], [a, b, c, d]) ? creep
%   Exit: (8) sklej([], [a, b, c, d], [a, b, c, d]) ? creep
%   Exit: (7) nalezy1(a, [a, b, c, d]) ? creep
%X = a ;
%   Redo: (8) sklej(_G3138, [_G3047|_G3129], [a, b, c, d]) ? creep
%   Call: (9) sklej(_G3132, [_G3047|_G3129], [b, c, d]) ? creep
%   Exit: (9) sklej([], [b, c, d], [b, c, d]) ? creep
%   Exit: (8) sklej([a], [b, c, d], [a, b, c, d]) ? creep
%   Exit: (7) nalezy1(b, [a, b, c, d]) ? creep
%X = b ;
%   Redo: (9) sklej(_G3132, [_G3047|_G3129], [b, c, d]) ? creep
%   Call: (10) sklej(_G3135, [_G3047|_G3129], [c, d]) ? creep
%   Exit: (10) sklej([], [c, d], [c, d]) ? creep
%   Exit: (9) sklej([b], [c, d], [b, c, d]) ? creep
%   Exit: (8) sklej([a, b], [c, d], [a, b, c, d]) ? creep
%   Exit: (7) nalezy1(c, [a, b, c, d]) ? creep
%X = c ;
%   Redo: (10) sklej(_G3135, [_G3047|_G3129], [c, d]) ? creep
%   Call: (11) sklej(_G3138, [_G3047|_G3129], [d]) ? creep
%   Exit: (11) sklej([], [d], [d]) ? creep
%   Exit: (10) sklej([c], [d], [c, d]) ? creep
%   Exit: (9) sklej([b, c], [d], [b, c, d]) ? creep
%   Exit: (8) sklej([a, b, c], [d], [a, b, c, d]) ? creep
%   Exit: (7) nalezy1(d, [a, b, c, d]) ? creep
%X = d ;
%   Redo: (11) sklej(_G3138, [_G3047|_G3129], [d]) ? creep
%   Call: (12) sklej(_G3141, [_G3047|_G3129], []) ? creep
%   Fail: (12) sklej(_G3141, [_G3047|_G3129], []) ? creep
%   Fail: (11) sklej(_G3138, [_G3047|_G3129], [d]) ? creep
%   Fail: (10) sklej(_G3135, [_G3047|_G3129], [c, d]) ? creep
%   Fail: (9) sklej(_G3132, [_G3047|_G3129], [b, c, d]) ? creep
%   Fail: (8) sklej(_G3138, [_G3047|_G3129], [a, b, c, d]) ? creep
%   Fail: (7) nalezy1(_G3047, [a, b, c, d]) ? creep
%false.







