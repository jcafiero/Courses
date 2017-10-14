#Author: Jennifer Cafiero

def subset(capacity, items):
    if capacity == 0:
        return True
    elif items == []:
        return False
    elif items[0] > capacity:
        return subset(capacity, items[1:])
    else:
        loseIt = subset(capacity, items[1:])
        useIt = subset(capacity - items[0], items[1:])
    return useIt or loseIt
#Answer: True

def LCS(S1, S2):
    if S1 == '' or S2 == '':
        return 0
    elif S1[0] == S2[0]:
        return 1 + LCS(S1[1:], S2[1:])
    else:
        option1 = LCS(S1[1:], S2)
        option2 = LCS(S1, S2[1:])
        return max(option1, option2)

#Answer:6

def ED(S1, S2):
    if S1 == '':
        return len(S2)
    elif S2 == '':
        return len(S1)
    elif S1[0] == S2[0]:
        return ED(S1[1:], S2[1:])
    else:
        substitute = 1 + ED(S1[1:], S2[1:])
        insert = 1 + ED(S1, S2[1:])
        delete = 1 + ED(S1[1:], S2)
    return min(substitute, insert, delete) 
#Answer: 2
