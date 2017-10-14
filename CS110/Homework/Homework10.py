#Author: Jennifer Cafiero
#I pledge my honor that I have abided by the Stevens Honor System.

def nodeornot(node):
    if type(node) == type(()) and len(node) == 3:
        return True
    return False

def sumTree(branch):
    if type(branch) != type(()):
        return 0
    elif nodeornot(branch) and type(branch[0] == type(0)):
        return branch[0] + sumTree(branch[1]) + sumTree(branch[2])
    elif nodeornot(branch):
        return sumTree(branch[1])+sumTree(branch[2])
    return 0

def mirrorTree(branch):
    if nodeornot(branch) and len(branch)==3:
        return (branch[0], mirrorTree(branch[2]), mirrorTree(branch[1]))
    else:
        return ()
                                  
