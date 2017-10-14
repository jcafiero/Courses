'''
Created on February 8, 2015
@author:   Stephanie Green, Jennifer Cafiero & Moenika Chowdhury
Pledge:    I pledge my honor that I have abided by the Stevens Honor System
CS115 - Hw 2
'''
import sys
# Be sure to submit hw2.py.  Remove the '_template' from the file name.

# Allows up to 10000 recursive calls.
# The maximum permitted limit varies from system to system.
sys.setrecursionlimit(10000)

# Leave the following lists in place.
scrabbleScores = \
   [ ['a', 1], ['b', 3], ['c', 3], ['d', 2], ['e', 1], ['f', 4], ['g', 2],
     ['h', 4], ['i', 1], ['j', 8], ['k', 5], ['l', 1], ['m', 3], ['n', 1],
     ['o', 1], ['p', 3], ['q', 10], ['r', 1], ['s', 1], ['t', 1], ['u', 1],
     ['v', 4], ['w', 4], ['x', 8], ['y', 4], ['z', 10] ]

Dictionary = ['a', 'am', 'at', 'apple', 'bat', 'bar', 'babble', 'can', 'foo',
              'spam', 'spammy', 'zzyzva']

def letterScore(letter, scorelist):
    ''' Returns the score of a single letter '''
    if scorelist == []:
        return 0
    elif letter == scorelist[0][0]:
        return scorelist[0][1]
    return letterScore(letter, scorelist[1:])

def wordScore(S, scorelist):
    ''' Returns the score of a word based on the letters that make up the word '''
    if S == "":
        return 0
    return letterScore(S[0], scorelist) + wordScore(S[1:], scorelist)
    
def explodeWord(S):
    ''' Breaks the word into individual characters for comparison '''
    if S == '':
        return []
    return [S[0]] + explodeWord(S[1:])

def remove(x, L):
    ''' Removes a letter from the rack after use '''
    if L == []:
        return []
    elif x == L[0]:
        return L[1:]
    return [L[0]] + remove(x, L[1:])

def index(x, L):
    ''' Returns the index that a letter is first found at '''
    if L[0] == x:
        return 0
    if len(L) == 1 and L[0] != x:
        return 1
    return 1 + index(x, L[1:])

def checkWord(Rack, word):
    ''' Returns true or false as to whether the letters for a word are in the rack '''
    if word == []:
        return True
    elif word[0] in Rack:
        return checkWord(remove(word[0], Rack), word[1:])
    return False

def scorelist(Rack):
    ''' Returns the score of all words that can be made from the rack '''
    if Rack == []:
        return []
    words = filter(lambda x: checkWord(Rack, explodeWord(x)), Dictionary)
    return formatWord(words)

def bestWord(Rack):
    ''' Returns the highest-scoring word '''
    if Rack == []:
        return []
    words = filter(lambda x: checkWord(Rack, explodeWord(x)), Dictionary)
    best = formatWord(words)
    ind = index(max(removeFirst(scorelist(Rack))), scorelist(Rack))
    return best[ind-1]

def formatWord(words):
    ''' Returns a list of words and their scores'''
    if words == []:
        return []
    return [[words[0], wordScore(words[0], scrabbleScores)]] + formatWord(words[1:])

def removeFirst(lst):
    ''' Removes a word after it has already been used '''
    if lst == []:
        return []
    xscore = [lst[0][1]] + removeFirst(lst[1:])
    return xscore

print scorelist(["a", "s", "m", "t", "p"])
print bestWord(["a", "s", "m", "t", "p"])