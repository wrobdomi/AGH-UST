import math
import random

print("Importing math lets you use math functions by math object")
print(math.sqrt(40))
print(math.sin(1))
print(math.pow(4,2))


print("Importing random lets you get random numbers by random object")
random.seed() # initializes random generator
losowana = random.random() # get random flot between 0 and 1
print(losowana)
losowana = random.randrange(10) # random int from 0 to 9 
print(losowana)
