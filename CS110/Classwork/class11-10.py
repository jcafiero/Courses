def showChange(amount, Coins):
    if amount == 0:
        return [0, []]
    elif Coins == []:
        return [float('inf'), []]
    else:
        firstCoin = Coins[0]
        if firstCoin > amount:
             return showChange(amount, Coins[1:])
        else:
             loseIt = showChange(amount, Coins[1:])
             useIt = showChange(amount-firstCoin, Coins)
             useIt[0] += 1
             useIt[1] += [firstCoin]
             if useIt[0]<loseIt[0]:
                 return useIt
             else:
                 return loseIt

def showSubset( target , L ):
     if target == 0:
         return [True,[]]
     elif L == [] :
         return [False, []]
     elif L[0] > target:
         return showSubset(target, L[1:])
     else:
         It = L[0] 
         loseIt = showSubset(target, L[1:]) 
         useIt = showSubset(target-It, L[1:])
         if useIt[0]: useIt[1] += [It]
         if useIt[0]:
             return useIt
         else:
             return loseIt


Matrix2 = { ("A","A"):0.0, ("A","T"):0.5, ("A","C"):0.5, ("A","G"):0.25, 
 ("T","A"):0.5, ("T","T"):0.0, ("T","C"):0.25, ("T","G"):0.5, 
 ("C","A"):0.5, ("C","T"):0.25, ("C","C"):0.0, ("C","G"):0.5, 
 ("G","A"):0.25, ("G","T"):0.5, ("G","C"):0.5, ("G","G"):0.0}

def align(string1, string2, Matrix2):
    if string1[0] == "" or string2[0] == "":
        return 0
    else:
        partA = Matrix2[string1[0], string1[1]]
        return partA + align(string1[1:], string2, Matrix2)
.
