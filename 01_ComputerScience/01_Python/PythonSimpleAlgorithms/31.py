
s = "Napotkala typa. Zapytala: \"Kto Pan?\""
s1 = "Napotkala tepa. Zapytala: \"Kto Pan?\""

print(s)


def convertString2Letters(s):
    letters = []
    for i in s:
        if i.isalpha():
            k = i.lower()
            letters.append(k)
    return letters


def checkPalindrom(l):
    palindrom = 1
    for i in range(len(l)):
        print("1: " + str(l[i]) + " 2: " + str(l[-(i+1)]))
        if( l[i] == l[-(i+1)] ):
            continue
        else:
            palindrom = 0
    return palindrom


letters = convertString2Letters(s)
print(letters)
letters1 = convertString2Letters(s1)
print(checkPalindrom(letters))
print(checkPalindrom(letters1))
print(letters)

