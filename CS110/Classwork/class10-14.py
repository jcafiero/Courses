def spamCount(input):
    count = 0
    for x in range(0, len(input)):
        if (input[x:x+4]=="spam"):
            count+=1
    return count

def gotSpam(input):
    count = 0
    for x in range(0, len(input)):
        if (input[x]== 's'):
            if (input[x+1]=='p'):
                if (input[x+2]=='a'):
                    if (input[x+3]=='m'):
                        count+=1
    if (count>0):
        result=True
    else:
        result=False
    return result

def spamFinder(input):
    lst=[]
    count = 0
    for x in range(0, len(input)):
        if (input[x]== 's'):
            if (input[x+1]=='p'):
                if (input[x+2]=='a'):
                    if (input[x+3]=='m'):
                        count+=1
                        lst.append(x)
    return lst
                        
def findingORF(input):
    for x in range(0, len(input)):
        if (input[x:x+3]=="ATG"):
            for y in range(x+3, len(input), 3):
                if (input[y:y+3]=="TAG"):
                    return input[x+3:y]

def longestORF(input):
    orf=""
    orf2=""
    for x in range(0, len(input)):
        if (input[x:x+3]=="ATG"):
            for y in range(x+3, len(input)):
                if (input[y:y+3]=="TAG"):
                    orf=input[x+3:y]
    for i in range(len(input)):   
        if (orf > orf2):
            orf = orf
        if (orf2 > orf):
             orf = orf2
        return orf
