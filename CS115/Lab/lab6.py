'''
Created on March 7, 2015
@author:   Jennifer Cafiero
Pledge:    I pledge my honor that I have abided by the Stevens Honor System

CS115 - Lab 6
'''
def isOdd(n):
    '''Returns whether or not the integer argument is odd.'''
    if n == 0:
        return False
    if n % 2 == 1:
        return True
    return False

'''42 in base-2 is 00101010'''

'''For an odd base-10 number, the least significant bit is 1. For an even base-10 number, the least significant bit is 0. '''

'''The value of the original number decreases by 1 if it is odd. The value of the original number is divided by two if it is even. '''

'''If n is odd, n/2 will tell us to put a 1 at the end of our binary string. If n is even, n/2 will tell us to put a 0 at the end of our binary string. '''


def numToBinary(n):
    '''Precondition: integer argument is non-negative.
    Returns the string with the binary representation of non-negative integer n.
    If n is 0, the empty string is returned.'''
    if n == 0:
        return ""
    elif isOdd(n):
        return numToBinary(n/2) + "1"
    else:
        return numToBinary(n/2) + "0"
    
        
print numToBinary(255)
print numToBinary(43)


def binaryToNum(s):
    '''Precondition: s is a string of 0s and 1s.
    Returns the integer corresponding to the binary representation in s.
    Note: the empty string represents 0.'''
    def binToNumHelper(s, k):
        if s =="":
            return 0
        elif int(s[-1]) == 0:
            return binToNumHelper(s[:-1], k + 1)
        return binToNumHelper(s[:-1], k + 1) + 2 **k
    return binToNumHelper(s, 0)


#print binaryToNum("1011") #11
#print binaryToNum("100") #4

def increment(s):
    '''Precondition: s is a string of 8 bits.
    Returns the binary representation of binaryToNum(s) + 1.'''
    if len(numToBinary(binaryToNum(s) + 1)) < 8:
        return '0' * (8 - len(numToBinary(binaryToNum(s) + 1))) + numToBinary(binaryToNum(s) + 1)
    elif len(numToBinary(binaryToNum(s) + 1)) > 8:
        return numToBinary(binaryToNum(s) + 1)[1:]
    return numToBinary(binaryToNum(s) + 1)
    
print increment('0')
print increment('11111111')
    
def count(s, n):
    '''Precondition: s is an 8-bit string and n >= 0.
    Prints s and its n successors.'''
    print s
    if n == 0:
        return s
    return count(increment(s), n-1)

print count("00000000", 4)
    
'''The ternary representation for 59 is 2012. 2*1 + 0*3 + 1*9+ 2*27 = 59.'''    
def numToTernary(n):
    '''Precondition: integer argument is non-negative.
    Returns the string with the ternary representation of non-negative integer
    n. If n is 0, the empty string is returned.'''
    if n == 0:
        return ""
    return numToTernary(n/3) + str(n % 3)
    
print numToTernary(42)

def ternaryToNum(s):
    '''Precondition: s is a string of 0s, 1s, and 2s.
    Returns the integer corresponding to the ternary representation in s.
    Note: the empty string represents 0.'''
    def ternaryToNumHelper(s, k):
        if s == "":
            return 0
        elif int(s[-1]) == 0:
            return ternaryToNumHelper(s[:-1], k + 1)
        return ternaryToNumHelper(s[:-1], k + 1) + (int(s[-1]) * 3 ** k)
    return ternaryToNumHelper(s, 0)

print ternaryToNum('1120')

print numToTernary(59)