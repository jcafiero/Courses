'''
Created on Mar 23, 2015
@author: Jennifer Cafiero
Pledge: I pledge my honor that I have abided by the Stevens Honor System.
'''

'''PART 1'''

def numToBaseB(n, b):
    '''converts a decimal number to a number in base B'''
    if n / b == 0 and n > 0:
        return str(n % b)
    if n == 0:
        return '0'
    return numToBaseB(n / b, b) + str(n % b)

'''PART 2'''

def baseBToNum(s, b):
    '''converts a number from base B to decimal'''
    if b == 10:
        return s
    def baseBToNumHelper(s, b, k):
        '''a helper function to aid the conversion of a number from base B to decimal'''
        if s =="":
            return 0
        elif int(s[-1]) == 0:
            return baseBToNumHelper(s[:-1], b, k + 1)
        return baseBToNumHelper(s[:-1], b, k + 1) + b **k
    return baseBToNumHelper(s, b, 0)

print baseBToNum("", 100)
print baseBToNum("3", 10)

'''PART 3'''

def baseToBase(b1, b2, sinb1):
    '''converts a number sinb1 from base b1 to base b2'''
    return numToBaseB(int(baseBToNum(sinb1, b1)),b2)

print baseToBase(2, 10, '11')
print baseToBase(10, 2, '3')

'''PART 4'''

def add(s, t):
    '''adds two binary numbers together using decimal conversion'''
    return numToBaseB(baseBToNum(s, 2) + baseBToNum(t, 2), 2)

print add('11', '01')

'''PART 5'''

def addB(s, t):
    '''adds two binary numbers together using a carryHelper function and 'carry' bits'''
    def sameLength(s, t):
        '''pads the shorter of the two strings to make both strings s and t the same number of bits'''
        if len(s) == len(t):
            return s, t
        elif len(s) < len(t):
            return '0' * (len(t)-len(s)) + s,t
        return s, '0' * (len(s)-len(t)) + t
    
    def carryHelper(s, t, carry):
        '''a helper function to carry bits in the addition of two binary strings'''
        if s == '':
            if carry == 0:
                return ''
            return '1'
        elif int(s[-1]) + int(t[-1]) + carry == 0:
            return carryHelper(s[:-1], t[:-1], 0) + '0'
        elif int(s[-1]) + int(t[-1]) + carry == 1:
            return carryHelper(s[:-1], t[:-1], 0) + '1'
        elif int(s[-1]) + int(t[-1]) + carry == 2:
            return carryHelper(s[:-1], t[:-1], 1) + '0'
        elif int(s[-1]) + int(t[-1]) + carry == 3:
            return carryHelper(s[:-1], t[:-1], 1) + '1'
        
    s = sameLength(s, t) [0]
    t = sameLength(s, t) [1]
    return carryHelper(s, t, 0)
            
print addB("011", '100')
print addB('11', '1')