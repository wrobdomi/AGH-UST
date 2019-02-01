s = "123bg G \"dawda..dadw,ad33%@!#%14aawdaWDawDAdwa"

def zamien(s):
    wynik = []
    for i in s:
        if i.isalpha():
            k = i.lower() # pamietac, ze zwracana wartosc to jest mala litera, a nie i
            wynik.append(k)
    return wynik

print(zamien(s))