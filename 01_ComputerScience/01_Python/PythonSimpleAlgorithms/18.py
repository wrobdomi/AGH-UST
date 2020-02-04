def trojkatPascala(n):
    if(n==0):
        return []
    if(n==1):
        return [[1]]
    nowy = [1]
    result = trojkatPascala(n-1)
    ostatni = result[-1]
    for i in range(len(ostatni)-1):
        nowy.append(ostatni[i]+ostatni[i+1])
    nowy.append(1)
    result.append(nowy)
    return result
    
print(trojkatPascala(6))

