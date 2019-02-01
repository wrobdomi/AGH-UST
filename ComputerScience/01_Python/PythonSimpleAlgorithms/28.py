def zamien(s):
    wynik = []
    for i in s:
        if i.isalpha():
            k = i.lower() # pamietac, ze zwracana wartosc to jest mala litera, a nie i
            wynik.append(k)
    return wynik

def cezar(tekst, przesuniecie):
    t = zamien(tekst)
    szyfr = []
    for i in t:
        if ord(i)+przesuniecie > ord('z'):
            szyfr.append(chr( ord('a') + ord(i) + przesuniecie - ord('z') -1 ))
        else:
            szyfr.append(chr( ord(i) + przesuniecie) )
    return szyfr

print(cezar("abcdefghijklmnoprstwuxyz", 13))