import math

print("Podaj liczbe dla choinki: ")
n = input()
n = int(n)
# print(n)

x = 0
wiersze = 2
srodek = n
rzad = 1
znakRzad = 0

while(x < n):
    x += 1
    odleglosc = 0
    ozdoba = 0
    
    for i in range(wiersze):
        for j in range(2*n+1):
            if( abs(srodek - j) > odleglosc ):
                print("   " , end = " ")
            else:
                znakRzad += 1
                if(rzad % 2 == 1 and abs(srodek - j) == odleglosc ):
                    print(" ! ", end = " ")
                elif( rzad % 2 == 0  and ( znakRzad == 2 or ((znakRzad-2 ) % 4 == 0 and znakRzad  > 2) ) ):
                    print(" o ", end = " " )
                else:
                    print(" x ", end = " ")
        print(" ")
        znakRzad = 0
        rzad += 1
        odleglosc += 1
    wiersze += 1
