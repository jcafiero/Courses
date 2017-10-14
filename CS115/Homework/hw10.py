#Stephanie Green
#12/5/14
#Homework 10

def isnode(node):
    if type(node) == type(()) and len(node) == 3:
        return True
    return False

def sumTree(tree):
    if type(tree) != type(()):
        return 0
    elif isnode(tree) and type(tree[0]) == type(0):
        return tree[0] + sumTree(tree[1]) + sumTree(tree[2])
    elif isnode(tree):
        return sumTree(tree[1]) + sumTree(tree[2])
    return 0

def mirrorTree(tree):
    if isnode(tree) and len(tree) == 3:
        return (tree[0], mirrorTree(tree[2]), mirrorTree(tree[1]))
    else:
        return ()
