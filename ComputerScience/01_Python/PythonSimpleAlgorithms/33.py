def znajdzDzielniki(a):
    dzielniki = []
    for i in range(1,a):
        if (a % i == 0):
            dzielniki.append(i)
    return dzielniki 

def sumujDzielniki(a):
    suma = 0
    dzielniki= znajdzDzielniki(a)
    for i in dzielniki:
        suma += i
    return suma

print("Podaj n")
n = int(input())

print("liczby zaprzyjaźnione:")
for i in range(1,n):
  suma1 = sumujDzielniki(i)
  suma2 = sumujDzielniki(suma1)
  if i == suma2:
    if i != suma1:
      print(suma1, i)

