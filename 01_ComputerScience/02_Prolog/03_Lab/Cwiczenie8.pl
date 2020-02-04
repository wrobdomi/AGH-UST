% dopisac predykat zawiera, -> patrz listy.pl
% Sprawdzic i przemyslec dzialanie ponizszych

zawiera(a,[a,b,c]).
   Call: (7) zawiera(a, [a, b, c]) ? creep
   Call: (8) sklej(_G2458, _G2459, [a, b, c]) ? creep
   Exit: (8) sklej([], [a, b, c], [a, b, c]) ? creep
   Call: (8) sklej(a, _G2459, [a, b, c]) ? creep
   Redo: (8) sklej(_G2458, _G2459, [a, b, c]) ? creep
   Call: (9) sklej(_G2452, _G2462, [b, c]) ? creep
   Exit: (9) sklej([], [b, c], [b, c]) ? creep
   Exit: (8) sklej([a], [b, c], [a, b, c]) ? creep
   Call: (8) sklej(a, _G2462, [b, c]) ? creep
   Redo: (9) sklej(_G2452, _G2462, [b, c]) ? creep
   Call: (10) sklej(_G2455, _G2465, [c]) ? creep
   Exit: (10) sklej([], [c], [c]) ? creep
   Exit: (9) sklej([b], [c], [b, c]) ? creep
   Exit: (8) sklej([a, b], [c], [a, b, c]) ? creep
   Call: (8) sklej(a, _G2465, [c]) ? creep
   Redo: (10) sklej(_G2455, _G2465, [c]) ? creep
   Call: (11) sklej(_G2458, _G2468, []) ? creep
   Exit: (11) sklej([], [], []) ? creep
   Exit: (10) sklej([c], [], [c]) ? creep
   Exit: (9) sklej([b, c], [], [b, c]) ? creep
   Exit: (8) sklej([a, b, c], [], [a, b, c]) ? creep
   Call: (8) sklej(a, _G2468, []) ? creep
   Redo: (11) sklej(_G2458, _G2468, []) ? creep
   Fail: (11) sklej(_G2458, _G2468, []) ? creep
   Fail: (10) sklej(_G2455, _G2465, [c]) ? creep
   Fail: (9) sklej(_G2452, _G2462, [b, c]) ? creep
   Fail: (8) sklej(_G2458, _G2459, [a, b, c]) ? creep
   Fail: (7) zawiera(a, [a, b, c]) ? creep
false.


zawiera([a],[a,b,c]).
   Call: (7) zawiera([a], [a, b, c]) ? creep
   Call: (8) sklej(_G2464, _G2465, [a, b, c]) ? creep
   Exit: (8) sklej([], [a, b, c], [a, b, c]) ? creep
   Call: (8) sklej([a], _G2465, [a, b, c]) ? creep
   Call: (9) sklej([], _G2465, [b, c]) ? creep
   Exit: (9) sklej([], [b, c], [b, c]) ? creep
   Exit: (8) sklej([a], [b, c], [a, b, c]) ? creep
   Exit: (7) zawiera([a], [a, b, c]) ? creep
true .


zawiera(X,[a,b,c]).
   Call: (7) zawiera(_G2388, [a, b, c]) ? creep
   Call: (8) sklej(_G2473, _G2474, [a, b, c]) ? creep
   Exit: (8) sklej([], [a, b, c], [a, b, c]) ? creep
   Call: (8) sklej(_G2388, _G2474, [a, b, c]) ? creep
   Exit: (8) sklej([], [a, b, c], [a, b, c]) ? creep
   Exit: (7) zawiera([], [a, b, c]) ? creep
X = [] .



zawiera([X],[a,b,c]).
   Call: (7) zawiera([_G2379], [a, b, c]) ? creep
   Call: (8) sklej(_G2479, _G2480, [a, b, c]) ? creep
   Exit: (8) sklej([], [a, b, c], [a, b, c]) ? creep
   Call: (8) sklej([_G2379], _G2480, [a, b, c]) ? creep
   Call: (9) sklej([], _G2480, [b, c]) ? creep
   Exit: (9) sklej([], [b, c], [b, c]) ? creep
   Exit: (8) sklej([a], [b, c], [a, b, c]) ? creep
   Exit: (7) zawiera([a], [a, b, c]) ? creep
X = a .



zawiera([X,Y],[a,b,c]).
   Call: (7) zawiera([_G2379, _G2382], [a, b, c]) ? creep
   Call: (8) sklej(_G2500, _G2501, [a, b, c]) ? creep
   Exit: (8) sklej([], [a, b, c], [a, b, c]) ? creep
   Call: (8) sklej([_G2379, _G2382], _G2501, [a, b, c]) ? creep
   Call: (9) sklej([_G2382], _G2501, [b, c]) ? creep
   Call: (10) sklej([], _G2501, [c]) ? creep
   Exit: (10) sklej([], [c], [c]) ? creep
   Exit: (9) sklej([b], [c], [b, c]) ? creep
   Exit: (8) sklej([a, b], [c], [a, b, c]) ? creep
   Exit: (7) zawiera([a, b], [a, b, c]) ? creep
X = a,
Y = b .



zawiera([X,Y,Z],[a,b,c]).
   Call: (7) zawiera([_G2379, _G2382, _G2385], [a, b, c]) ? creep
   Call: (8) sklej(_G2521, _G2522, [a, b, c]) ? creep
   Exit: (8) sklej([], [a, b, c], [a, b, c]) ? creep
   Call: (8) sklej([_G2379, _G2382, _G2385], _G2522, [a, b, c]) ? creep
   Call: (9) sklej([_G2382, _G2385], _G2522, [b, c]) ? creep
   Call: (10) sklej([_G2385], _G2522, [c]) ? creep
   Call: (11) sklej([], _G2522, []) ? creep
   Exit: (11) sklej([], [], []) ? creep
   Exit: (10) sklej([c], [], [c]) ? creep
   Exit: (9) sklej([b, c], [], [b, c]) ? creep
   Exit: (8) sklej([a, b, c], [], [a, b, c]) ? creep
   Exit: (7) zawiera([a, b, c], [a, b, c]) ? creep
X = a,
Y = b,
Z = c .








