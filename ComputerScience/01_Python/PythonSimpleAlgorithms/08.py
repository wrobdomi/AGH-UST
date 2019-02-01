import random
import time

print("Wysokosc: ")
m = int(input())

print("Szerokosc: ")
n = int(input())

glowyWezy = []
srodkiWezy = []
ogonyWezy = []

for i in range(n):
    glowyWezy.append(0)
    srodkiWezy.append(0)
    ogonyWezy.append(0)
    
print(glowyWezy)    

def dodajWeza():
    random.seed()
    ranWaz = random.randrange(n)
    if(glowyWezy[ranWaz] == 0):
        glowyWezy[ranWaz] = 1
    
    
def wypiszWeze():
    for i in range(m):
        for j in range(n):
            if(glowyWezy[j] == i+1 or srodkiWezy[j] == i+1 or ogonyWezy[j] == i+1 ):
                print(" x ", end = " ")
            else:
                print(" o ", end = " ")
        print(" ")
        
def przesunWeze():
    for i in range(len(glowyWezy)):
        if(glowyWezy[i] == 0):
            continue
        if(glowyWezy[i] == 1):
            glowyWezy[i] += 1
            srodkiWezy[i] += 1
        if(glowyWezy[i] >= 2 and glowyWezy[i] != m):
            glowyWezy[i] += 1
            srodkiWezy[i] += 1
            ogonyWezy[i] += 1
        if(glowyWezy[i] == m):
            glowyWezy[i] = 0
            srodkiWezy[i] = 0
            ogonyWezy[i] = 0
            
while True:
    dodajWeza()
    wypiszWeze()
    przesunWeze()
    print(" ")
    time.sleep(1)

