def fibonacciTrzy(n):
    if(n == 1):
        return 1
    if(n == 0):
        return 0
    w1 = fibonacciTrzy(n-1)
    w2 = fibonacciTrzy(n-2) 
    return w1 + w2 + w1 - w2 

print(fibonacciTrzy(10))