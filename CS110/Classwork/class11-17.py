import random

def crossOver(strA, strB):
    split = random.choice(range(len(strA)))
    newStr1 = strA[0:split] + strB[split:]
    newStr2 = strB[0:split] + strA[split:]
    return [newStr1, newStr2]

def popSim(popL, numGen):
    for gen in range(numGen):
        newPopL = []
        for iteration in range(len(popL)/2):
            org1 = random.choice(popL)
            org2 = random.choice(popL)
            newPair = crossOver(org1, org2)
            newPopL.append(newPair[0])
            newPopL.append(newPair[1])
        popL = newPopL
    print popL


def contains(DNA, pattern):
    '''returns True if DNA contains pattern and False otherwise.'''
    if pattern == '':
        return True
    elif DNA == '':
        return False
    elif DNA[0] == pattern[0]:
        return contains(DNA[1:], pattern[1:])
    else:
        return contains(DNA[1:], pattern)


def findOrtholog(sequence, virusList):
    minScore = float('inf')
    bestGeneName = ''
    for gene in virusList:
        score = ED(sequence, gene[1])
        if score < minScore:
            minScore = score
            bestGeneName = gene[0]
    return bestGeneName

def allOrthologs(virusList1, virusList2):
    for gene1 in virusList1:
        gene2Name = findOrtholog(gene1[1], virusList2)
        print gene1[0], gene2Name

def score(String, Dictionary):
    if String == "":
        return 0
    else:
        loseIt = score(String[1:], Dictionary)
        bestSoFar = 0
        for i in range(len(String)):
            useItCandidate = String[0:i+1]
            if useItCandidate in Dictionary:
                option = Dictionary[useItCandidate] + score(String[i+1], Dictionary)
                if option > bestSoFar:
                    bestSoFar = option
        return max(loseIt, bestSoFar)

def find(species, Tree):
    if Tree[0] == species:
        return True
    elif leaf(Tree):
        return False
    else:
        return find(species, Tree[1]) or find(species, Tree[2])

def size(Tree):
    if leaf(Tree):
        return 1
    else:
        return 1 + size(Tree[1]) + size(Tree[2])

def numTips(Tree):
    if leaf(Tree):
        return 1
    else:
        return numTips(Tree[1]) + numTips(Tree[2])

def height(Tree):
    if leaf(Tree):
        return 0
    else:
        return 1 + max(height(Tree[1]), height(Tree[1]))

def listAll(Tree):
    if leaf(Tree):
        return [Tree[0]]
    else:
        return [Tree[0]] + listAll(Tree[1]) + listAll(Tree[2])

def listLeaves(Tree):
    if leaf(Tree):
        return [Tree[0]]
    else:
        return listLeaves(Tree[1]) + listLeaves(Tree[2])

def lca(species1, species2, Tree):
    if leaf(Tree):
        return None
    else:
        Root = Tree[0]
        Left = Tree[1]
        Right = Tree[2]
        if find(species1, Left) and find(species2, Left):
            return lcs(species1, species2, Left)
        elif find(species1, Right) and find(species2, Right):
            return lcs(species1, species2, Right)
        else:
            return Root

def showScore(String, Dictionary):
    if String == "":
        return [0, []]
    else:
        loseItCP = showScore(String[1:], Dictionary)
        bestSoFarCP = [0, []]
        for i in range(len(String)):
            useItCandidate = String[1:i+1]
            if useItCandidate in Dictionary:
                optionCP = showScore(String[i+1:], Dictionary)
                optionCP[0] += Dictionary[useItCandidate]
                optionCP[1] = [useItCandidate] + optionCP[1]
                if optionCP[0] > bestSoFarCP[0]:
                    bestSoFarCP = optionCP
        if loseItCP[0] > bestSoFarCP[0]:
            return loseItCP
        else:
            return bestSoFarCP
        
            
    
    
