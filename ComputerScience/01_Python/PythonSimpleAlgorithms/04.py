import math


def tablicaN(n):
    tablica = []
    for i in range(2,n+1):
        tablica.append(i)
    return tablica

print("Podaj liczbe n")
n = input()
n = int(n)

tab = tablicaN(n)
print(tab)

licznik = 0

while True:
    
    min = tab[licznik]
    
    indeksy = []
    for i in range(len(tab)):
        if( tab[i] % min == 0 and tab[i] != min):
            indeksy.append(i)
            
    for j in range(len(indeksy)):
        ind = indeksy[j] - j
        tab.pop(ind)

    if(min > math.sqrt(n)):
         break
    
    licznik += 1
    
print(tab)