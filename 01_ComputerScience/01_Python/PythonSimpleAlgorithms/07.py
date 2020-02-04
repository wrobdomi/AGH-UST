import time
import system

print("Wysokosc: ")
m = int(input())

print("Szerokosc: ")
n = int(input())

srodekX = n // 2
srodekY = m // 2

licznik = 0
licznikGora = 1

while True:
    
    for i in range(m):
        for j in range(n):
            if( abs(i-srodekY) == licznik and abs(j-srodekX) == licznik ):
                print(" x ", end = " " )
            else:
                print(" o ", end = " " )
        print(" ")

    if(licznik == 0):
        licznikGora = 1
    if(licznik == min(srodekX, srodekY)):
        licznikGora = 0
    if(licznikGora == 1):
        licznik += 1
    else:    
        licznik -= 1
    
    time.sleep(1)
    os.system('cls')
    print(" ")
