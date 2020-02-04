% Dopisac predykat usun, patrz listy.pl
% Sprawdzic i przemyslec dzialania ponizszych
% Dopisac i przetestowac predykat wstaw, nalezy2, -> patrz listy.pl


usun(a,[a,b,a,c,a,a],X).
   Call: (7) usun(a, [a, b, a, c, a, a], _G1865) ? creep
   Exit: (7) usun(a, [a, b, a, c, a, a], [b, a, c, a, a]) ? creep
X = [b, a, c, a, a] .

[trace]  ?- usun(a,[a,b,c,d],X).
   Call: (7) usun(a, [a, b, c, d], _G2111) ? creep
   Exit: (7) usun(a, [a, b, c, d], [b, c, d]) ? creep
X = [b, c, d] .

[trace]  ?- usun(a,[a,b,a,c,a,a],X).
   Call: (7) usun(a, [a, b, a, c, a, a], _G2117) ? creep
   Exit: (7) usun(a, [a, b, a, c, a, a], [b, a, c, a, a]) ? creep
X = [b, a, c, a, a] ;
   Redo: (7) usun(a, [a, b, a, c, a, a], _G2117) ? creep
   Call: (8) usun(a, [b, a, c, a, a], _G2205) ? creep
   Call: (9) usun(a, [a, c, a, a], _G2208) ? creep
   Exit: (9) usun(a, [a, c, a, a], [c, a, a]) ? Unknown option (h for help)
   Exit: (9) usun(a, [a, c, a, a], [c, a, a]) ? creep
   Exit: (8) usun(a, [b, a, c, a, a], [b, c, a, a]) ? creep
   Exit: (7) usun(a, [a, b, a, c, a, a], [a, b, c, a, a]) ? creep
X = [a, b, c, a, a] ;
   Redo: (9) usun(a, [a, c, a, a], _G2208) ? creep
   Call: (10) usun(a, [c, a, a], _G2211) ? creep
   Call: (11) usun(a, [a, a], _G2214) ? creep
   Exit: (11) usun(a, [a, a], [a]) ? creep
   Exit: (10) usun(a, [c, a, a], [c, a]) ? creep
   Exit: (9) usun(a, [a, c, a, a], [a, c, a]) ? creep
   Exit: (8) usun(a, [b, a, c, a, a], [b, a, c, a]) ? creep
   Exit: (7) usun(a, [a, b, a, c, a, a], [a, b, a, c, a]) ? creep
X = [a, b, a, c, a] ;
   Redo: (11) usun(a, [a, a], _G2214) ? creep
   Call: (12) usun(a, [a], _G2217) ? creep
   Exit: (12) usun(a, [a], []) ? creep
   Exit: (11) usun(a, [a, a], [a]) ? creep
   Exit: (10) usun(a, [c, a, a], [c, a]) ? creep
   Exit: (9) usun(a, [a, c, a, a], [a, c, a]) ? creep
   Exit: (8) usun(a, [b, a, c, a, a], [b, a, c, a]) ? creep
   Exit: (7) usun(a, [a, b, a, c, a, a], [a, b, a, c, a]) ? creep
X = [a, b, a, c, a] ;
   Redo: (12) usun(a, [a], _G2217) ? creep
   Call: (13) usun(a, [], _G2220) ? creep
   Fail: (13) usun(a, [], _G2220) ? creep
   Fail: (12) usun(a, [a], _G2217) ? creep
   Fail: (11) usun(a, [a, a], _G2214) ? creep
   Fail: (10) usun(a, [c, a, a], _G2211) ? creep
   Fail: (9) usun(a, [a, c, a, a], _G2208) ? creep
   Fail: (8) usun(a, [b, a, c, a, a], _G2205) ? creep
   Fail: (7) usun(a, [a, b, a, c, a, a], _G2117) ? creep
false.




 usun(a,[a,b,c,d],X).
   Call: (7) usun(a, [a, b, c, d], _G2111) ? creep
   Exit: (7) usun(a, [a, b, c, d], [b, c, d]) ? creep
X = [b, c, d] ;
   Redo: (7) usun(a, [a, b, c, d], _G2111) ? creep
   Call: (8) usun(a, [b, c, d], _G2193) ? creep
   Call: (9) usun(a, [c, d], _G2196) ? creep
   Call: (10) usun(a, [d], _G2199) ? creep
   Call: (11) usun(a, [], _G2202) ? creep
   Fail: (11) usun(a, [], _G2202) ? creep
   Fail: (10) usun(a, [d], _G2199) ? creep
   Fail: (9) usun(a, [c, d], _G2196) ? creep
   Fail: (8) usun(a, [b, c, d], _G2193) ? creep
   Fail: (7) usun(a, [a, b, c, d], _G2111) ? creep




usun(c,[a,b,c,d],X).
   Call: (7) usun(c, [a, b, c, d], _G2111) ? creep
   Call: (8) usun(c, [b, c, d], _G2193) ? creep
   Call: (9) usun(c, [c, d], _G2196) ? creep
   Exit: (9) usun(c, [c, d], [d]) ? creep
   Exit: (8) usun(c, [b, c, d], [b, d]) ? creep
   Exit: (7) usun(c, [a, b, c, d], [a, b, d]) ? creep
X = [a, b, d] ;
   Redo: (9) usun(c, [c, d], _G2196) ? creep
   Call: (10) usun(c, [d], _G2199) ? creep
   Call: (11) usun(c, [], _G2202) ? creep
   Fail: (11) usun(c, [], _G2202) ? creep
   Fail: (10) usun(c, [d], _G2199) ? creep
   Fail: (9) usun(c, [c, d], _G2196) ? creep
   Fail: (8) usun(c, [b, c, d], _G2193) ? creep
   Fail: (7) usun(c, [a, b, c, d], _G2111) ? creep
false.





usun(c,X,[a,b,c,d]).
   Call: (7) usun(c, _G2392, [a, b, c, d]) ? creep
   Exit: (7) usun(c, [c, a, b, c, d], [a, b, c, d]) ? creep
X = [c, a, b, c, d] ;
   Redo: (7) usun(c, _G2392, [a, b, c, d]) ? creep
   Call: (8) usun(c, _G2475, [b, c, d]) ? creep
   Exit: (8) usun(c, [c, b, c, d], [b, c, d]) ? creep
   Exit: (7) usun(c, [a, c, b, c, d], [a, b, c, d]) ? creep
X = [a, c, b, c, d] ;
   Redo: (8) usun(c, _G2475, [b, c, d]) ? creep
   Call: (9) usun(c, _G2478, [c, d]) ? creep
   Exit: (9) usun(c, [c, c, d], [c, d]) ? creep
   Exit: (8) usun(c, [b, c, c, d], [b, c, d]) ? creep
   Exit: (7) usun(c, [a, b, c, c, d], [a, b, c, d]) ? creep
X = [a, b, c, c, d] ;
   Redo: (9) usun(c, _G2478, [c, d]) ? creep
   Call: (10) usun(c, _G2481, [d]) ? creep
   Exit: (10) usun(c, [c, d], [d]) ? creep
   Exit: (9) usun(c, [c, c, d], [c, d]) ? creep
   Exit: (8) usun(c, [b, c, c, d], [b, c, d]) ? creep
   Exit: (7) usun(c, [a, b, c, c, d], [a, b, c, d]) ? creep
X = [a, b, c, c, d] ;
   Redo: (10) usun(c, _G2481, [d]) ? creep
   Call: (11) usun(c, _G2484, []) ? creep
   Exit: (11) usun(c, [c], []) ? creep
   Exit: (10) usun(c, [d, c], [d]) ? creep
   Exit: (9) usun(c, [c, d, c], [c, d]) ? creep
   Exit: (8) usun(c, [b, c, d, c], [b, c, d]) ? creep
   Exit: (7) usun(c, [a, b, c, d, c], [a, b, c, d]) ? creep
X = [a, b, c, d, c] ;
   Redo: (11) usun(c, _G2484, []) ? creep
   Fail: (11) usun(c, _G2484, []) ? creep
   Fail: (10) usun(c, _G2481, [d]) ? creep
   Fail: (9) usun(c, _G2478, [c, d]) ? creep
   Fail: (8) usun(c, _G2475, [b, c, d]) ? creep
   Fail: (7) usun(c, _G2392, [a, b, c, d]) ? creep
false.





usun(1,X,[a,b,c,d]).
   Call: (7) usun(1, _G2392, [a, b, c, d]) ? creep
   Exit: (7) usun(1, [1, a, b, c, d], [a, b, c, d]) ? creep
X = [1, a, b, c, d] ;
   Redo: (7) usun(1, _G2392, [a, b, c, d]) ? creep
   Call: (8) usun(1, _G2475, [b, c, d]) ? creep
   Exit: (8) usun(1, [1, b, c, d], [b, c, d]) ? creep
   Exit: (7) usun(1, [a, 1, b, c, d], [a, b, c, d]) ? creep
X = [a, 1, b, c, d] ;
   Redo: (8) usun(1, _G2475, [b, c, d]) ? creep
   Call: (9) usun(1, _G2478, [c, d]) ? creep
   Exit: (9) usun(1, [1, c, d], [c, d]) ? creep
   Exit: (8) usun(1, [b, 1, c, d], [b, c, d]) ? creep
   Exit: (7) usun(1, [a, b, 1, c, d], [a, b, c, d]) ? creep
X = [a, b, 1, c, d] ;
   Redo: (9) usun(1, _G2478, [c, d]) ? creep
   Call: (10) usun(1, _G2481, [d]) ? creep
   Exit: (10) usun(1, [1, d], [d]) ? creep
   Exit: (9) usun(1, [c, 1, d], [c, d]) ? creep
   Exit: (8) usun(1, [b, c, 1, d], [b, c, d]) ? creep
   Exit: (7) usun(1, [a, b, c, 1, d], [a, b, c, d]) ? creep
X = [a, b, c, 1, d] ;
   Redo: (10) usun(1, _G2481, [d]) ? creep
   Call: (11) usun(1, _G2484, []) ? creep
   Exit: (11) usun(1, [1], []) ? creep
   Exit: (10) usun(1, [d, 1], [d]) ? creep
   Exit: (9) usun(1, [c, d, 1], [c, d]) ? creep
   Exit: (8) usun(1, [b, c, d, 1], [b, c, d]) ? creep
   Exit: (7) usun(1, [a, b, c, d, 1], [a, b, c, d]) ? creep
X = [a, b, c, d, 1] ;
   Redo: (11) usun(1, _G2484, []) ? creep
   Fail: (11) usun(1, _G2484, []) ? creep
   Fail: (10) usun(1, _G2481, [d]) ? creep
   Fail: (9) usun(1, _G2478, [c, d]) ? creep
   Fail: (8) usun(1, _G2475, [b, c, d]) ? creep
   Fail: (7) usun(1, _G2392, [a, b, c, d]) ? creep
false.



wstaw(c,[a,b,d,e,f,g],Duza).
   Call: (7) wstaw(c, [a, b, d, e, f, g], _G2399) ? creep
   Call: (8) usun(c, _G2399, [a, b, d, e, f, g]) ? creep
   Exit: (8) usun(c, [c, a, b, d, e, f, g], [a, b, d, e, f, g]) ? creep
   Exit: (7) wstaw(c, [a, b, d, e, f, g], [c, a, b, d, e, f, g]) ? creep
Duza = [c, a, b, d, e, f, g] .



nalezy2(a,[b,d,f,g,h,a,j]).
   Call: (7) nalezy2(a, [b, d, f, g, h, a, j]) ? creep
   Call: (8) usun(a, [b, d, f, g, h, a, j], _G2484) ? creep
   Call: (9) usun(a, [d, f, g, h, a, j], _G2476) ? creep
   Call: (10) usun(a, [f, g, h, a, j], _G2479) ? creep
   Call: (11) usun(a, [g, h, a, j], _G2482) ? creep
   Call: (12) usun(a, [h, a, j], _G2485) ? creep
   Call: (13) usun(a, [a, j], _G2488) ? creep
   Exit: (13) usun(a, [a, j], [j]) ? creep
   Exit: (12) usun(a, [h, a, j], [h, j]) ? creep
   Exit: (11) usun(a, [g, h, a, j], [g, h, j]) ? creep
   Exit: (10) usun(a, [f, g, h, a, j], [f, g, h, j]) ? creep
   Exit: (9) usun(a, [d, f, g, h, a, j], [d, f, g, h, j]) ? creep
   Exit: (8) usun(a, [b, d, f, g, h, a, j], [b, d, f, g, h, j]) ? creep
   Exit: (7) nalezy2(a, [b, d, f, g, h, a, j]) ? creep
true .



