#Jennifer Cafiero
#I pledge my honor that I have abided by the Stevens Honor System.

def superLCS(str1,str2):
    return LCS(str1, str2, "", "", 0)

def LCS(str1, str2, sol1, sol2, counter):
    if str1 == "":
        return [counter, (sol1 + ((len(str2))*"-")), (sol2 + str2[(len(str2)-len(sol2)):])]
    if str2 == "":
        return [counter, (sol1 + str1[len(str1):]), (sol2 + ((len(str1))*"-"))]
    if str1[0] == str2[0]:
        sol1 = sol1 + str1[0]
        sol2 = sol2 + str2[0]
        counter = counter + 1
        return LCS(str1[1:], str2[1:], sol1, sol2, counter)
    else:
        test1 = LCS(str1[1:], str2, sol1 + str1[0], sol2 + "-", counter)
        test2 = LCS(str1, str2[1:], sol1 + "-", sol2 + str2[0], counter)
        test3 = LCS(str1[1:], str2[1:], sol1 + "-", sol2 + "-", counter)
        return max(test1, test2, test3)


Matrix2 = { ("A","A"):0.0, ("A","T"):0.5, ("A","C"):0.5, ("A","G"):0.25, ("T","A"):0.5, ("T","T"):0.0, ("T","C"):0.25, ("T","G"):0.5, ("C","A"):0.5, ("C","T"):0.25, ("C","C"):0.0, ("C","G"):0.5, ("G","A"):0.25, ("G","T"):0.5, ("G","C"):0.5, ("G","G"):0.0}

def align(s1, s2, Matrix2):
    if s1 == "":
        return [len(s2), len(s2)*"-", s2]
    if s2 == "":
        return [len(s1), s1, len(s1)*"-"]
    if s1[0] == s2[0]:
        newlst = align(s1[1:], s2[1:], Matrix2)
        return [newlst[0], s1[0]+newlst[1], s2[0]+newlst[2]]
    else:
        test1 = align(s1[1:], s2, Matrix2)
        test2 = align(s1, s2[1:], Matrix2)
        test3 = align(s1[1:], s2[1:], Matrix2)
        minval = min( test1[0], test2[0], test3[0])
        if minval == test1[0]:
            return [1+minval, s1[0].lower()+test1[1], "-"+test1[2]]
        if minval == test2[0]:
            return [1+minval, "-"+test2[1], s2[0].lower()+test2[2]]
        if minval == test3[0]:
            return [Matrix2[(s1[0], s2[0])]+l, s1[0].lower()+test3[1], s2[0].lower()+test3[2]]

def prettyAlign(s1, s2, Matrix2):
    final = align(s1, s2, Matrix2)
    print "Cost:", final[0]
    print final[1]
    print final[2]


