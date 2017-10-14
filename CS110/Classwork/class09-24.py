def sum(lst):
    total=0
    for num in lst:
        total=total+num
    return total

def fun(myString):
    output = ""
    for sym in myString:
        output=sym+output+"blah"
    return output

def WW(string):
    output=[]
    for index in range(len(string)):
        print "Currently, index is", index
        if string[index:index+5] == "waldo":
            print "I found waldo"
            output.append(index)
    return output
