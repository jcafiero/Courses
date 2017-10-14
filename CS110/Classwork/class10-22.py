def reverse(lst):
    if lst ==[]:
        return []
    else:
        return reverse(lst[1:])+[lst[0]]

def member(x,L):
    if L==[]:
        return False
    else:
        if L[0]==x:
            return True
        else:
            return member(x, L[1:])

def uniquify(L):
    if L==[]:
        return []
    else:
        if member(L[0], L[1:]):
            return uniquify(L[1:])
        else:
            return [L[0]]+uniquify(L[1:])

def pal(S):
    '''returns True if string S is a palindrome and False otherwise'''
    if S=="":
        return True
    else:
        if S[0]==S[len(S)-1]:
            return pal(S[1:len(S)-2])
        else:
            return False
        
def superLen(L):
    if L==[]:
        return 0
    elif isinstance(L, int):
        return 1
    else:
        return superLen[0]+superLen(L[1:])
