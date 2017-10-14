def checkeven(n):
    if (n%2==0):
        return 2*n
    else:
        return 2*n+2

def multby3(x):
    return x*3

def mult_list(lst):
    return map(multby3, lst)

def add_even(lst):
    return reduce(add,map(check_even,lst))


def check_even(x):
    if (x%2==0):
        return x
    else:
        return 0

def add(x,y):
    return x+y

def inits(lst):
    return map(firstletter,lst)

def firstletter(lst):
    return lst[0]
