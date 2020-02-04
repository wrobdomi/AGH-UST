def decimal2Any(dNumber, base2):
    result = []
    remainder = 1
    temp = dNumber
    while(temp != 0):
        remainder = temp % base2
        result.append(remainder)
        temp = temp // base2
    result.reverse()
    return result


def any2Decimal(aNumber, aBase):
    result = 0
    j = len(aNumber)-1
    for i in aNumber:
        result += int(i)*(aBase**j)
        j -= 1
        if(j == -1):
            break
    return result


def any2Any(number, baseFrom, baseTo):
    dec = any2Decimal(number, baseFrom)
    return decimal2Any(dec, baseTo)
    
print(decimal2Any(45, 6))
print(any2Decimal([1,1,3], 6))

print(any2Any([1,1,3], 6, 10))

def eight2ten(number8):
    return any2Any(number8, 8, 10)

def ten2five(dNum):
    return decimal2Any(dNum, 5)

def three2ten(num3):
    return any2Decimal(num3, 3)

print(ten2five(45))
print(three2ten([1,2,1]))