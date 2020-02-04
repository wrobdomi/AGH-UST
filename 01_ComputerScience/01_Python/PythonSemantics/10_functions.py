# To create function precede its declaration with def
def myFun():
    print("This is my fun")

# To call a function
myFun()

# Use function arguments
def myFun(toPrint):
    print(toPrint)

printIt = "testString"

myFun(printIt)

# Use return values
def calculateSum(x,y):
    return x + y

result = calculateSum(10,16)    
print("Result is ")
print(result)