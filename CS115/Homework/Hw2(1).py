# I pledge my honor that I have abided by the Stevens Honor System
# Team Members- John Spicer, Patrick Curran, Laramie Regalado

scrabbleScores = [ ["a", 1], ["b", 3], ["c", 3], ["d", 2], ["e", 1], ["f", 4], ["g", 2], ["h", 4], ["i", 1], ["j", 8], ["k", 5], ["l", 1], ["m", 3], ["n", 1], ["o", 1], ["p", 3], ["q", 10], ["r", 1], ["s", 1], ["t", 1], ["u", 1], ["v", 4], ["w", 4], ["x", 8], ["y", 4], ["z", 10] ]
Dictionary = ["a", "am", "at", "apple", "bat", "bar", "babble", "can", "foo", "spam", "spammy", "zzyzva"]

def letterScore(letter, scoreList):
    """Returns the score of a letter"""
    if scoreList == []:
        return 0
    elif letter == scoreList[0][0]:
        return scoreList[0][1]
    return letterScore(letter, scoreList[1:])


def wordScore(S,scoreList):
    """Returns the score of a word based on a list of scores"""
    if S == "":
        return 0
    return letterScore(S[0],scoreList) + wordScore(S[1:],scoreList)


def explode(S):
    """Returns a list of the characters in string s"""
    if S == "":
        return []
    return   [S[0]] + explode(S[1:])


def removeAll(e,L):
    '''Returns list L with all instances of 'e' removed'''
    if L == []:
        return []
    elif e == L[0]:
        return L[1:]
    return  [L[0]] + removeAll(e,L[1:])

def ind(e,L):
    '''returns the index that e is first found in L'''
    if L[0]==e:
        return 0
    if len(L) == 1 and L[0] != e:
        return 1
    return 1 + ind(e,L[1:])

def checkWord(Rack,word):
    '''Returns a boolean for whether or not the letters that make up word, are contained
    in rack'''
    if word == []:
        return True
    elif word[0] in Rack:
        return checkWord(removeAll(word[0], Rack), word[1:])
    return False

def scorelist(Rack):
    """Returns all of that words, and their scores,that can be created from the given words."""
    if Rack == []:
        return []
    words = filter(lambda x: checkWord(Rack,explode(x)),Dictionary)
    return formatWord(words)

def bestWord(Rack):
    """Returns the word with the highest score that can be made from the Rack"""
    if Rack == []:
        return []
    words = filter(lambda x: checkWord(Rack,explode(x)),Dictionary)
    best = formatWord(words)
    index = ind(max(removeFirst(scorelist(Rack))),scorelist(Rack))
    return best[index-1]

def formatWord(words):
    """Returns a list of words and their scores"""
    if words ==[]:
        return []
    return [[words[0], wordScore(words[0],scrabbleScores)]] + formatWord(words[1:])

def removeFirst(lst):
    """Returns a new list using only the second term of the nested lists"""
    if lst == []:
        return []
    wscores = [lst[0][1]] + removeFirst(lst[1:])
    return wscores
