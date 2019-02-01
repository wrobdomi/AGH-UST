# Kolejne liczby doskonale to
# 6, 28, 496, 8128, 33550336, 8589869056, 137438691328, ...

print("Podaj n")
n = int(input())

def znajdzDzielniki(a):
    dzielniki = []
    for i in range(1,a):
        if (a % i == 0):
            dzielniki.append(i)
    return dzielniki 

def sumujDzielniki(a):
    suma = 0
    dzielniki= znajdzDzielniki(a)
    for i in dzielniki:
        suma += i
    return suma

for i in range(1,n):
    r = sumujDzielniki(i)
    if(r == i):
        print("Doskonala " + str(i))



    