]  ?- wyp0(a(X),X).
   Call: (7) wyp0(a(_G2845), _G2845) ? creep
   Call: (8) a(_G2845) ? creep
   Exit: (8) a(1) ? creep
   Exit: (7) wyp0(a(1), 1) ? creep
X = 1 ;
   Redo: (8) a(_G2845) ? creep
   Exit: (8) a(2) ? creep
   Exit: (7) wyp0(a(2), 2) ? creep
X = 2.

[trace]  ?- wyp0(b(X),X).
   Call: (7) wyp0(b(_G2845), _G2845) ? creep
   Call: (8) b(_G2845) ? creep
   Exit: (8) b(4) ? creep
   Exit: (7) wyp0(b(4), 4) ? creep
X = 4 ;
   Redo: (8) b(_G2845) ? creep
   Exit: (8) b(3) ? creep
   Exit: (7) wyp0(b(3), 3) ? creep
X = 3.

[trace]  ?- wyp1(a(_),X).
   Call: (7) wyp1(a(_G2845), _G2848) ? creep
   Call: (8) a(_G2845) ? creep
   Exit: (8) a(1) ? creep
   Call: (8) a(1)=..[_G2921, _G2848] ? creep
   Exit: (8) a(1)=..[a, 1] ? creep
   Exit: (7) wyp1(a(1), 1) ? creep
X = 1 ;
   Redo: (8) a(_G2845) ? creep
   Exit: (8) a(2) ? creep
   Call: (8) a(2)=..[_G2921, _G2848] ? creep
   Exit: (8) a(2)=..[a, 2] ? creep
   Exit: (7) wyp1(a(2), 2) ? creep
X = 2.

[trace]  ?- wyp1(b(_),X).
   Call: (7) wyp1(b(_G2845), _G2848) ? creep
   Call: (8) b(_G2845) ? creep
   Exit: (8) b(4) ? creep
   Call: (8) b(4)=..[_G2921, _G2848] ? creep
   Exit: (8) b(4)=..[b, 4] ? creep
   Exit: (7) wyp1(b(4), 4) ? creep
X = 4 ;
   Redo: (8) b(_G2845) ? creep
   Exit: (8) b(3) ? creep
   Call: (8) b(3)=..[_G2921, _G2848] ? creep
   Exit: (8) b(3)=..[b, 3] ? creep
   Exit: (7) wyp1(b(3), 3) ? creep
X = 3.


[trace]  ?- wyp2(a,X).
   Call: (7) wyp2(a, _G2846) ? creep
   Call: (8) functor(_G2921, a, 1) ? creep
   Exit: (8) functor(a(_G2914), a, 1) ? creep
   Call: (8) a(_G2914) ? creep
   Exit: (8) a(1) ? creep
   Call: (8) a(1)=..[_G2916, _G2846] ? creep
   Exit: (8) a(1)=..[a, 1] ? creep
   Exit: (7) wyp2(a, 1) ? creep
X = 1 ;
   Redo: (8) a(_G2914) ? creep
   Exit: (8) a(2) ? creep
   Call: (8) a(2)=..[_G2916, _G2846] ? creep
   Exit: (8) a(2)=..[a, 2] ? creep
   Exit: (7) wyp2(a, 2) ? creep
X = 2.


[trace]  ?- wyp2(b,X).
   Call: (7) wyp2(b, _G2846) ? creep
   Call: (8) functor(_G2921, b, 1) ? creep
   Exit: (8) functor(b(_G2914), b, 1) ? creep
   Call: (8) b(_G2914) ? creep
   Exit: (8) b(4) ? creep
   Call: (8) b(4)=..[_G2916, _G2846] ? creep
   Exit: (8) b(4)=..[b, 4] ? creep
   Exit: (7) wyp2(b, 4) ? creep
X = 4 ;
   Redo: (8) b(_G2914) ? creep
   Exit: (8) b(3) ? creep
   Call: (8) b(3)=..[_G2916, _G2846] ? creep
   Exit: (8) b(3)=..[b, 3] ? creep
   Exit: (7) wyp2(b, 3) ? creep
X = 3.


[trace]  ?- wyp3(a/1,X).
   Call: (7) wyp3(a/1, _G2879) ? creep
   Call: (8) 1=1 ? creep
   Exit: (8) 1=1 ? creep
   Call: (8) functor(_G2957, a, 1) ? creep
   Exit: (8) functor(a(_G2950), a, 1) ? creep
   Call: (8) a(_G2950) ? creep
   Exit: (8) a(1) ? creep
   Call: (8) a(1)=..[_G2952, _G2879] ? creep
   Exit: (8) a(1)=..[a, 1] ? creep
   Exit: (7) wyp3(a/1, 1) ? creep
X = 1 ;
   Redo: (8) a(_G2950) ? creep
   Exit: (8) a(2) ? creep
   Call: (8) a(2)=..[_G2952, _G2879] ? creep
   Exit: (8) a(2)=..[a, 2] ? creep
   Exit: (7) wyp3(a/1, 2) ? creep
X = 2.


[trace]  ?- wyp3(b/1,X).
   Call: (7) wyp3(b/1, _G3131) ? creep
   Call: (8) 1=1 ? creep
   Exit: (8) 1=1 ? creep
   Call: (8) functor(_G3209, b, 1) ? creep
   Exit: (8) functor(b(_G3202), b, 1) ? creep
   Call: (8) b(_G3202) ? creep
   Exit: (8) b(4) ? creep
   Call: (8) b(4)=..[_G3204, _G3131] ? creep
   Exit: (8) b(4)=..[b, 4] ? creep
   Exit: (7) wyp3(b/1, 4) ? creep
X = 4 ;
   Redo: (8) b(_G3202) ? creep
   Exit: (8) b(3) ? creep
   Call: (8) b(3)=..[_G3204, _G3131] ? creep
   Exit: (8) b(3)=..[b, 3] ? creep
   Exit: (7) wyp3(b/1, 3) ? creep
X = 3.


