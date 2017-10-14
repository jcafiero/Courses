def addLear(newleaf, Tree):
    '''Returns a list of all possible trees that result from adding newLeaf to Tree.'''
    leftTree = Tree[1]
    rightTree = Tree[2]

    if leftTree == ():
        newTree = ("Anc", newleaf, Tree)
        return [newTree]
    else:
        outPutTreeL = []
        outPutTreeL.append(("Anc", newleaf, Tree))
        for tempRightTree in addLeaf(newleaf, rightTree):
            newTree = ("Anc", leftTree, tempRightTree)
            outPutTreeL.append(newTree)
        for tempLeftTree in addLeaf(newleaf, leftTree):
            newTree = ("Anc", templeftTree, rightTree)
            outPutTreeL. append(newTree)
        return outPutTreeL


import turtle
turtle.forward(150)
