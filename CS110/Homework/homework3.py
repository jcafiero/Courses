#Author: Jennifer Cafiero
#"I pledge my honor that I have abided by the Stevens Honor System"

def head(a):
    if not a:
        print "Error: the empty list has no head"
    else:
        print a[0]

def tail(lst):
    if not lst:
        print "Error: the empty list has no tail"
    else:
        del lst[0]
        return lst

def replace_and_double(x, y, z, lst):
    if (z == x):
        return lst
    def makeXY(arg):
        if (arg==x):
            return y
        else:
            return arg
    def doubleZ(arg):
        if (arg==z):
            return z*2
        else:
            return arg
    return map(doubleZ, map(makeXY, lst))

def new_replace(x,y,z,lst):
    for lst in range(1, lst):
        if (z == x):
            return lst
        def makeXY(arg):
            if (arg==x):
                return y
            else:
                return arg
        def doubleZ(arg):
            if (arg==z):
                return z*2
            else:
                return arg
    return lst
