# There are four primary control flow statements if python:
# if elif else
# while loop
# for loop
# break, continue

x = 10
y = 25
z = 20
if(x < y and x < 20):
    print("Yes")
else:
    print("No")
    
if(y // x == 1):
    print("x // y is 1")
elif(y // x == 0):
    print("x // y is 0")
else:
    print("x // y is neither 0 nor 1")
    

print("Simple while loop")
i = 0
while(i < 6):
    i += 1
    print(i)


print("While with break")
i = 0
while(i < 10):
    if(i%5==0 and i!=0):
        break
    else:
        print(i)
        i+=1
        

print("Simple range for loop, starts at 0, up to 5")
for i in range(6):
    print(i)
        
print("For range loop with specified range, from 2 up to 9")    
for j in range(2, 10):
    print(j)
        
print("For range loop with specified range and custom iteration change, from 0, up to 8")
for k in range(0,10,2):
    print(k)
    
numbers = [1,2,3,4,5,6,7]
print("Looping through a list")
for x in numbers:
    print(x)