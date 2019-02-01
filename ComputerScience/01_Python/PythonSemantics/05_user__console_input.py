# You can ask user for input using
# input() function

print("Tell me your name")
x = input()
print("Welcome " + x)

# By default input() returns string
# you can use casting to convert it 
# to another type
print("How old are you ? ")
x = input()
x = int(x)
print("You are ")
print(x)
print("years old")
