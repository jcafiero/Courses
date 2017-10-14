'''
Created on Feb 25, 2015

@author: Jennifer Cafiero
'''
d = {}
print d
d['Jackie'] = 'Fr'
d['Katie'] = 'Fr'
d['Kevin'] = 'Se'
d['Brian'] = 'Se'
print d
print 'Brian' in d

def distance(first, second):
    if first == "":
        return len(second)
    if second == "":
        return len(first)
    if first[0] == second[0]:
        return distance(first[1:], second[1:])
    substitution = 1 + distance(first[1:], second[1:])
    deletion = 1 + distance(first[1:], second)
    insertion = 1 + distance(first, second[1:])
    return min(substitution, deletion, insertion)
print distance("sam", "pam")

print distance("Jennifercaf", "Stevecaf")

def LCS(S1, S2):
    if S1 == '' or S2 == '':
        return 0
    if S1[0] == S2[0]:
        return 1 + LCS(S1[1:], S2[1:])
    return max(LCS(S1, S2[1:]), LCS(S1[1:], S2))

def fastLCS(S1, S2):
    def fast_LCS_helper(S1, S2, memo):
        if (S1, S2) in memo:
            return memo[(S1, S2)]
        '''if key exists, return the value already associated with it'''
        if S1 == "" or S2 =="":
           result = 0
        elif S1[0] == S2[0]:
            result = 1 + fast_LCS_helper(S1[1:], S2[1:], memo)
        else:
            result = max(fast_LCS_helper(S1, S2[1:], memo), fast_LCS_helper(S1[1:], S2, memo))
        memo[(S1, S2)] = result
        return result
    
    return fast_LCS_helper(S1, S2, {})

print LCS("pammableasd", "spammableasd")
print fastLCS("pammableasdfghjkl", "spammableasdfghjklm")