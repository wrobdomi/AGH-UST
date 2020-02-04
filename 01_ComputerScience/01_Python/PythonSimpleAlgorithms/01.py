print("Podaj n dla choinki: ")
n = input()
n = int(n)
# print(n)
x = 0
while(x < n-1):
    x += 1
    for i in range(x+1):
        for j in range(x+1):
            if(j <= i):
                print(" x ", end = " ")
        print(" ")
