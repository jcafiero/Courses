'''
Created on Mar 30, 2015

@author: Jennifer Cafiero
Pledge: I pledge my honor that I have abided by the Stevens Honor System.
'''

def TcToNum(n):
    '''Converts a string in two's complement representation to a decimal number.'''
    def TcToNumHelper(s):
        '''A helper function that converts a string starting from the second bit until the end of the string to a decimal number.'''
        if s == '':
            return 0
        else:
            if s[-1] == '0':
                return 2 * TcToNumHelper(s[:-1])
            else:
                return 2 * TcToNumHelper(s[:-1]) + 1
    if n[0] == '1':
        return TcToNumHelper(n[1:]) - 128
    return TcToNumHelper(n)

def isOdd(n):
    '''This function checks to see if a number is odd.'''
    if n % 2 == 0:
        return False
    return True

def NumToTc(n):
    '''Converts a decimal number to a string of the two's compliment representation'''
    def NumToTcHelper(n):
        '''Converts the absolute value of the decimal number to binary representation.'''
        if n == 0 or n < 0:
            return ''
        if isOdd(n):
            return NumToTcHelper(n/2) + '1'
        if not isOdd(n):
            return NumToTcHelper(n/2) + '0'
    if n < -128 or n > 127:
        return 'Error'
    if n < 0:
        return '1' + NumToTc(n + 128) [1:]
    if len(NumToTcHelper(n)) < 8:
        return '0' * (8 - len(NumToTcHelper(n))) + NumToTcHelper(n)
    
    
    
print NumToTc(-128)