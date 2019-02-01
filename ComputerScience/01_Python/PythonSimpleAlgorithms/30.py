miesiace = ['styczen', 'luty', 'marzec', 'kwiecien', 'maj', 'czerwiec', 
            'lipiec', 'sierpien', 'wrzesien', 'pazdziernik', 'listopad', 'grudzien']

dlugosci = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

dzien = 1
dzien_tygodnia = 1

for i in range(2001,2015):
    dlugosci[1] = 28
    if(i%4==0):
        dlugosci[1] = 29
    miesiac = 0
    while miesiac < 12:
        dzien += 1
        dzien_tygodnia += 1
        if dzien > dlugosci[miesiac]:
            dzien = 1
            miesiac += 1
        if dzien_tygodnia > 7:
            dzien_tygodnia = 1
        if dzien == 13 and dzien_tygodnia == 5:
            print("Index to " + str(miesiac))
            print("Rok " + str(i) + "miesiac " + str(miesiace[miesiac]))
