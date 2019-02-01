?- ma(X,Y).
X = jas,
Y = kota i psa ;
X = ala,
Y = jasia i angine i dosc_agh.

?- ma(X,i(A,B)).
X = jas,
A = kota,
B = psa ;
X = ala,
A = jasia,
B = angine i dosc_agh.

?- ma(X,i(B,i(C,D))).
X = ala,
B = jasia,
C = angine,
D = dosc_agh.

?- Kto ma Co.
Kto = jas,
Co = kota i psa ;
Kto = ala,
Co = jasia i angine i dosc_agh.

?- Kto ma Co i Coinnnego.
Kto = jas,
Co = kota,
Coinnnego = psa ;
Kto = ala,
Co = jasia,
Coinnnego = angine i dosc_agh.

?- Kto ma Co i Coinnego i Jeszcze.
Kto = ala,
Co = jasia,
Coinnego = angine,
Jeszcze = dosc_agh

?- display(jas ma kota i psa).
ma(jas,i(kota,psa))
true.

?- display(ala ma jasia i angine i dosc_agh).
ma(ala,i(jasia,i(angine,dosc_agh)))
true.

?- i(A,B).
A = rybki,
B = kanarki.

