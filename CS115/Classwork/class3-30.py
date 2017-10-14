'''
Created on Mar 30, 2015

@author: O409
'''
def leppard(input):
    output = ''
    for symbol in input:
        if symbol == 'o':
            output = output + 'ooo'
        else:
            output = output + symbol
    return output
    
print leppard('hello')
print leppard('hello to you')

vowels = ['a', 'e', 'i', 'o', 'u']

def spamify(word):
    for i in range(len(word)):
        if word[i] not in vowels:
            return word[0:i] + "spam" + word[i+1:]
    return word

print spamify('oui')
print spamify('hello')

#for i in range(100):
#    print i 

    
sum = 0
for j in range(10):
    sum += j
    
def mapSqr(L):
    output = []
    for element in L:
        output += [element * element]
    return output

print mapSqr([1,2,3,4,5,6,7])

import random
def play():
    print "welcome!"
    secret = random.choice(range(1, 100))
    numGuess = 0
    userGuess = 0
    while userGuess != secret:
        userGuess = input("Enter your guess: ")
        numGuess += 1
        if userGuess == secret:
            print "You got it in ", numGuess, " guesses!"
        elif userGuess > secret:
            print "Too high"
        else:
            print "Too low"
    return "Thanks for playing"

