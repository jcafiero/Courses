def maxTree(tree):
    if tree[1]== ():
        return tree[0]
    else:
        leftTree = tree[1]
        rightTree = tree[2]
        return max(maxTree(leftTree) and maxTree(rightTree))
        
