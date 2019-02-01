import random

print("-- Sortowanie wybieranie --")

tablica = []

for i in range(50):
    random.seed()
    rNum = random.randrange(100)
    tablica.append(rNum)
    
print(tablica)


def sortowanieWybieranie():
    for i in range(len(tablica)):
        minimum = i
        for j in range(i,len(tablica)):
            if(tablica[j] < tablica[minimum]):
                minimum = j
        tablica[i],tablica[minimum] = tablica[minimum],tablica[i]
   
sortowanieWybieranie() 
print(tablica)
        

print("-- Sortowanie wstawianie --")

tablica = []

for i in range(50):
    random.seed()
    rNum = random.randrange(100)
    tablica.append(rNum)
    
print(tablica)


def sortowanieWstawianie():
    for i in range(1, len(tablica)):
        klucz = tablica[i]
        j = i-1
        while j>=0 and tablica[j] > klucz:
            tablica[j+1] = tablica[j]
            j=j-1
        tablica[j+1] = klucz
        
sortowanieWstawianie()

print(tablica)
            
            
print("-- Babelki --")

tablica = []

for i in range(50):
    random.seed()
    rNum = random.randrange(100)
    tablica.append(rNum)
    
print(tablica)

def sortowanieBabelki():
    for i in range(len(tablica)-1,0,-1):
        zmiana = 0
        for j in range(i):
            if tablica[j] > tablica[j+1]:
                zmiana = 1
                tablica[j],tablica[j+1] = tablica[j+1],tablica[j]
        if(zmiana == 0):
            break
        
sortowanieBabelki()

print(tablica)
                