# len(x) returns length of the string
x = "my sample"
print(len(x))


# upper(), lower() returns string
# in uppercase and lowercase
x = "AnOtHeR StRiNg"
print(x.lower())
print(x.upper())
print(x)


# isalpha, isdigit method
# can check is string is 
# an alpha or a digit
x = "3"
y = "b"
z = "B"

print(x.isalpha())
print(x.isdigit())
print(y.isalpha())
print(z.isalpha())


# converting string to ascii and ascii to string
print(ord('a'))
print(ord('z'))
print(chr(100))
print(chr(122))