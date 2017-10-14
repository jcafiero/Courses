def max(L):
    if len(L)==0:
        print "Sorry your list is empty."
    if (len(L))==1:
        return L[0]
    else:
        if (L[0]>max(L[1:])):
            return L[0]
        else:
            return max(L[1:])
    
