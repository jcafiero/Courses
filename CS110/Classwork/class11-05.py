def Favalue(key, FakeDict):
    for pair in FakeDict:
        if key == pair[0]:
            return pair[1]
    return "Not there!"

F1 = [ ("chocolate", "yummy"), (42, "Adrianna"), (47, "NYU") ]
D1 = { "chocolate" : "yummy", 42 : "Adrianna", 47 : "NYU" }

import time

def make(num):
    FakeDict = []
    RealDict = {}
    for key in range(num):
        value = -key
        FakeDict.append((key, value))
        RealDict[key] = value
    return FakeDict, RealDict

def Fvalue(key, FakeDict):
    startTime = time.time()
    for pair in FakeDict:
        if key == pair[0]:
            endTime = time.time()
            print "Elasped time: ", endTime - startTime
            return pair[1]
    return "Not there!"

def Rvalue(key, RealDict):
    startTime = time.time()
    value = RealDict[key]
    endTime = time.time()
    print "Elapsed time; ", endTime - startTime
    return value

D = {}
def memoLCS(S1, S2):
    if S1 == "" or S2 == "":
        return 0
    elif (S1, S2) in D:
        return D[(S1, S2)]
    elif S1[0] == S2[0]:
        loseBoth = memoLCS(S1[1:], S2[1:])
        optimal = 1 + loseBoth
        D[(S1, S2)] = optimal
        return optimal
    else:
        loseOne = memoLCS(S1[1:], S2)
        loseOther = memoLCS(S1, S2[1:])
        optimal = max(loseOne, loseOther)
        D[(S1, S2)] = optimal
        return optimal
