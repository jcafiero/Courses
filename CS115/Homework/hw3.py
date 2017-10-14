'''
Created on Feb 12, 2015
@author: Jennifer Cafiero
Pledge: I pledge my honor that I have abided by the Stevens Honor System.

CS115 - Hw 3
'''
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' PROBLEM 0
' Implement the function giveChange() here:
' See the PDF in Canvas for more details.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
def giveChange(amount, Coins):
    '''Returns the minimum number of coins that the amount of change can be made with'''
    if amount == 0:
        return [0, []]
    elif Coins == []:
        return [float('inf'), []]
    else:
        if Coins[0] > amount:
            return giveChange(amount, Coins[1:])
        else:
            useIt = giveChange(amount-Coins[0], Coins)
            loseIt = giveChange(amount, Coins[1:])
            useIt = [1 + useIt[0], useIt[1] + [Coins[0]]]
            if useIt[0] > loseIt[0]:
                return loseIt
            return useIt
            
print giveChange(35, [1, 3, 16, 30, 50])

scrabbleScores = \
   [ ['a', 1], ['b', 3], ['c', 3], ['d', 2], ['e', 1], ['f', 4], ['g', 2],
     ['h', 4], ['i', 1], ['j', 8], ['k', 5], ['l', 1], ['m', 3], ['n', 1],
     ['o', 1], ['p', 3], ['q', 10], ['r', 1], ['s', 1], ['t', 1], ['u', 1],
     ['v', 4], ['w', 4], ['x', 8], ['y', 4], ['z', 10] ]

Dictionary = ['a', 'am', 'at', 'apple', 'bat', 'bar', 'babble', 'can', 'foo',
              'spam', 'spammy', 'zzyzva']

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' PROBLEM 1
' Implement wordsWithScore() which is specified below.
' Hints: Use map. Feel free to use some of the functions you did for
' homework 2 (Scrabble Scoring). As always, include any helper
' functions in this file, so we can test it.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
def letterScore(letter, scorelst):
    '''Returns the score of a letter based on a scorelist'''
    if scorelst[0][0] == letter:
        return scorelst[0][1]
    return letterScore(letter, scorelst[1:])

def wordScore(word, scorelst):
    '''Returns the score of the word based on the scores of individual characters in the word'''
    if word == "":
        return 0
    return letterScore(word[0], scorelst) + wordScore(word[1:], scorelst)

def wordsWithScore(dct, scores):
    '''Returns a List of words in dct, with their Scrabble score.'''
    if dct == []:
        return []
    return [[dct[0], wordScore(dct[0], scores)]] + wordsWithScore(dct[1:], scores)

print wordsWithScore(Dictionary, scrabbleScores)

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' PROBLEM 2
' For the sake of an exercise, we will implement a function
' that does a kind of slice. You must use recursion for this
' one. Your code is allowed to refer to list index L[0] and
' also use slice notation L[1:] but no other slices.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
def take(n, L):
    '''Returns the list L from the beginning to index n'''
    if L == []:
        return []
    if n == 0:
        return []
    return [L[0]] + take(n-1, L[1:])

print take(4, [1,3,5])

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' PROBLEM 3
' Similar to problem 2, will implement another function
' that does a kind of slice. You must use recursion for this
' one. Your code is allowed to refer to list index L[0] and
' also use slice notation L[1:] but no other slices.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
def drop(n, L):
    '''Returns the list L starting from the index n ending at the end of the list'''
    if L == []:
        return []
    if n > 0:
        return drop(n-1, L[1:])
    return [L]


