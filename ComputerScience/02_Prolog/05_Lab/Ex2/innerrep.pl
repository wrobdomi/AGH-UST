ch% Predykaty display, write_canonical wypisuja Prologowa reprezentacje termów
% Dlugie listy wygodnie jest wypisywac przy uzyciu print

A=1, display(A).

1
A = 1.


A = [1], display(A).

[1]
A = [1].


A = [1], write_canonical(A).

[1]
A = [1].


A = [1,a,[ala,ma,[kota]]], display(A).

[1,a,[ala,ma,[kota]]]
A = [1, a, [ala, ma, [kota]]].


X = [1,2,3,45,6,7,8,9,32,4,6,ff,7,d],print(X).

[1,2,3,45,6,7,8,9,32,4,6,ff,7,d]
X = [1, 2, 3, 45, 6, 7, 8, 9, 32|...].
