import math

print("Podaj liczbe dla choinki: ")
n = input()
n = int(n)
# print(n)

x = 0
wiersze = 2
srodek = n


while(x < n):
    x += 1
    odleglosc = 0
    for i in range(wiersze):
        for j in range(2*n+1):
            if( abs(srodek - j) > odleglosc ):
                print("   " , end = " ")
            else:
                print(" x ", end = " ")
        print(" ")
        odleglosc += 1
    wiersze += 1
