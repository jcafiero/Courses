def showSubset( target , L ):
     if target == 0:
         return [True,[]]
     elif L == [] :
         return [False, []]
     elif L[0] > target:
         return showSubset(target, L[1:])
     else:
        It = L[0] 
        '''loseIt = showSubset(target, L[1:]) 
        useIt = showSubset(target-It, L[1:])
        useIt[1] += [It]
        if useIt[0]:
            return useIt
        else:
            return loseIt'''

        #Another correct
        '''loseIt = showSubset(target, L[1:])
        useIt = showSubset(target-It, L[1:])
        if useIt[0]:
            useIt[1] += [It]
        if loseIt[0]:
            return loseIt
        else:
            return useIt'''


        #Not correct
        loseIt = showSubset(target, L[1:])
        useIt = showSubset(target - It, L[1:])
        useIt[1] += [It]
        if loseIt[0]:
            return loseIt
        else:
            return useIt



