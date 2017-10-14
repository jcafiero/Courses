'''
Created on Feb 5, 2015

@author: Jennifer Cafiero
'''
def dot(L, K):
    if L == [] or K == []:
        return float(0)
    return L[0] * K[0] + dot(L[1:], K[1:])
    
print dot([5,3], [6,4])

def explode(S):
    if S == "":
        return []
    return [S[0]] + explode(S[1:])

print explode("spam")
print explode("")

def ind(e, L):
    if L == [] or L=='':
        return 0
    elif e == L[0]:
        return 0
    else:
        return 1 + ind(e, L[1:])
    
print ind(12, range(0,100))
print ind(' ', 'outer exploration')

def removeAll(e, L):
    if L == []:
        return []
    elif e == L[0]:
        return removeAll(e, L[1:])
    else:
        return [L[0]] + removeAll(e, L[1:])
    
print  removeAll(42, [ 55, 77, 42, 11, 42, 88 ])

def even(x):
    if x % 2 == 0: return True
    else: return False

def myFilter(f, L):
    if L == []:
        return []
    if f(L[0]) is True:
        return [L[0]] + myFilter(f, L[1:])
    return myFilter(f, L[1:])
    
print myFilter(even, [0,1,2,4,6,7,8,5,9])
    
def deepReverse(L):
    if L == []:
        return []
    if isinstance(L[-1], list):
        return [deepReverse(L[-1])] + deepReverse(L[:-1])
    else:
        return [L[-1]] + deepReverse(L[:-1])
    
    
print deepReverse([1,[2,3],4])