import time
import os
import random

def losujKrople():
    random.seed()
    ranKropla = random.randrange(n)
    print("Random is " + str(ranKropla))
    if( krople[ranKropla] == 0 ):
        krople[ranKropla] = 1
        

def rysujKrople():
    for i in range(m):
        for j in range(n):
            if(krople[j] - 1 == i):
                print(" x ", end = " ")
            else:
                print(" o ", end = " ")
        print(" ")
                

def przesunKrople():
    for i in range(len(krople)):
        if(krople[i] == 0):
            continue
        elif(krople[i] == m):
            krople[i] = 0
        else:
            krople[i] += 1
            

print("Wysokosc: ")
m = int(input())
# print(m)

print("Szerokosc: ")
n = int(input())
# print(n)

krople = []
for i in range(n):
    krople.append(0)
    
print(krople)

while True:
    losujKrople()
    rysujKrople()
    time.sleep(1)
    os.system('cls')
    przesunKrople()
    

        