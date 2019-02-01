def fibRekur(n):
    if(n == 1):
        return 1
    if(n == 0):
        return 0
    f = fibRekur(n-1) + fibRekur(n-2)
    return f

def fibIter(n):
    suma = 0
    w1 = 0
    w2 = 1
    for i in range(n-1):
        suma = w1 + w2
        w1 = w2
        w2 = suma
    return suma

print(fibRekur(11))
print(fibIter(11))

