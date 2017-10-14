#Author: Jennifer Cafiero
#I pledge my  honor that I have abided by the Stevens Honor System.

def replace(x,y,lst):
    if lst == []:
        return []
    elif lst[0] == x:
        return [y] + replace(x,y,lst[1:])
    else:
        return [lst[0]] + replace(x,y,lst[1:])

def replaceFirstTwo(x,y,lst):
    xoccur= lst.count(x)
    if xoccur <= 2:
        return replace(x,y,lst)
    else:
        first = lst.index(x)
        second = len(lst[0:first+1]) + lst[first+1:].index(x)
        return replace(x,y,lst[0:second+1]) + lst[second+1:]
    return lst


def findBlack(guess, code, colors):
    found = [0] * colors
    score = ["dummy"] * len(code)
    if guess == []:
        return 0
    elif guess[0] == code[0]:
        score[0] = "black"
        return [score, found+1] + findBlack(guess+1, code, colors)
    else:
        return [score, found] + findBlack(guess+1, code, colors)
