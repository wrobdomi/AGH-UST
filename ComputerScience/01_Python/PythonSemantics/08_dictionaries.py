# dictionaries are collections which are unordered, changeable and indexed
# dictionaries consist of key-value pairs, they are written in
# curly brackets
thisdict =	{
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
print(thisdict)


# Accesing values of a dictionary
print(thisdict["brand"])
print(thisdict["model"])
print(thisdict["year"])


# Changing values of a dictionary
thisdict["brand"] = "Fiat"
print(thisdict)


# Looping through dictionary
# by keys:
print("Looping through a dictionary: ")
for i in thisdict:
    print(i)
# by values:
for i in thisdict.values():
    print(i)

    
# Adding item to dictionary
print("Adding item to a dictionary: ")
thisdict["price"] = 10000
print(thisdict)


# Removing key-value from dictionary by key
print("Removing value from dictionary")
thisdict.pop("price")
print(thisdict)

