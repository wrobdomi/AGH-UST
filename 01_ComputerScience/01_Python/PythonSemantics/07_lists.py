# lists are collections that are changable and ordered
# allow duplicates

# in Python lists are written with square brackets
print("List of strings: ")
theList1 = ["one", "two", "three"]
print(theList1)

print("List of integers: ")
theList2 = [1, 3, 5, 7, 9, 11]
print(theList2)

print("Mixed list: ")
theList3 = [1, "two", 3, "four"]
print(theList3)

print("Empty list: ")
theList4 = []
print(theList4)



# List items can by accessed by using square brackets
print("Accessing lists members by using square brackets: ")
print(theList1[0])
print(theList1[2])


# looping through the list
print("List loops: ")
for x in theList1:
    print(x)
    

# checking if list contains value
print("Checking containment")
if( 5 in theList2):
    print("Yes, i am in theList2")
    

# determining list length
print("Determining length")
print(len(theList2))


# Adding items to the list
print("Adding items")
print("Adding items to the end of the list")
theList2.append(13)
print(theList2)

print("Adding item at specified index")
theList2.insert(0, 15)
print(theList2)
theList2.insert(3, 17)
print(theList2)


# Removing item from the list
print("Removing last item")
theList2.pop()
print(theList2)
print("Removing item with specified index")
theList2.pop(0)
print(theList2)


# Sorting the list
print("Sorting list")
theList2.sort()
print(theList2)
