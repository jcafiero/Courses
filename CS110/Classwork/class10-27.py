def older((mm1, dd1, yy1), (mm2, dd2, yy2)):
    if (mm1, dd1, yy1) == "" :
        return 0
    if (yy1>yy2):
        return False
    elif (yy1 < yy2):
        return True
    if (mm1 > mm2):
        return False
    elif (mm1 < mm2):
        return True
    else:
        if (dd1 > dd2):
            return False
        else:
            return True

def cleanup (lst, (mm, dd, yy)):
    if lst == []:
        return []
    elif (older(lst[0], (mm, dd, yy))) == True:
        return cleanup(lst[1:], (mm, dd, yy))
    else:
        return lst[0] + cleanup(lst[1:], (mm, dd, yy))
        
        
def subset(target, L):
    if target == 0: return True
    elif L == [] : return False
    elif L[0] > target:
        return subset(target, L[1:])
    else:
        useIt = subset(target-L[0], L[1:])
        loseIt = subset(target, L[1:])
        return useIt or loseIt


