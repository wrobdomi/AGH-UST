def silniaRekur(n):
    if(n==1):
        return 1
    return n*silniaRekur(n-1)

def silniaIter(n):
    wynik = 1
    j = n
    while(j > 0):
        wynik *= j
        j -= 1
    return wynik

print(silniaRekur(6))
print(silniaIter(6))