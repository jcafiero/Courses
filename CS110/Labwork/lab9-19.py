def replace_abcd(lst):
    return map(replaceletters, lst)

def replaceletters(lst):
    if (lst[0]=="a"):
        return "b"
    if (lst[0]=="b"):
        return "c"
    else:
        return lst[0]

def number_Of_Bigger(x, n):
    def compareTo(x):
        if (x>n):
            return 1
        else:
            return 0
    def returnlist(x,y):
        return x+y



    return reduce(returnlist,map(compareTo, x))




