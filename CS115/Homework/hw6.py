'''
Created on March 9, 2015
@author:   Jennifer Cafiero, Ayse Akin
Pledge:    I pledge my honor that I have abided by the Stevens Honor System.

CS115 - Hw 6
'''
# Number of bits for data in the run-length encoding format.
# The assignment refers to this as k.
COMPRESSED_BLOCK_SIZE = 5

# Number of bits for data in the original format.
MAX_RUN_LENGTH = 2 ** COMPRESSED_BLOCK_SIZE - 1

# Do not change the variables above.
# Write your functions here. You may use those variables in your code.
def numToBinary(s):
    '''Converts a decimal number to binary'''
    if s == 0:
        return ""
    return numToBinary(s/2) + str(s % 2)

def numBits(s, k):
    '''Utilizes the numToBinary function to create binary strings that are k number of bits'''
    if len(numToBinary(s)) < k:
        return '0' * (k - len(numToBinary(s))) + numToBinary(s)
    return numToBinary(s)

def compress(s):
    '''Takes a binary string of length 64 and returns a run-length encoding of the input string.'''
    def compressHelper(s, curr, count):
        if s == "":
            return ''
        if count == 31:
            return numToBinary(count) + compressHelper(s, str(1-int(curr)), 0)
        if s[0] != curr:
            return numToBinary(count) + compressHelper(s, str(1-int(curr)), 0)
        return  compressHelper(s, curr, count+1)
        
        
        
        
        
        
    return compressHelper(s,'0', 0)
        
        
    
    
    
    
    
    
    
    
                             
    
print compress('10'*32)
         