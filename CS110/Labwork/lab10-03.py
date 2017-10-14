def addUpTo(largest):
    '''Returns the sum of the integers from 0 to largest.'''
    sum=0
    for num in range(0, largest+1):
        sum=sum+num
    return sum

def countCCAAT(DNA):
    '''Computes number of occurrences of CCAAT in input string.'''
    counter=0
    for index in range(len(DNA)):
        if DNA[index:index+5]=='CCAAT':
            counter=counter+1
    return counter

def multiCountCCAAT(DNAList):
    '''Prints the number of occurences of CCAAT in each string in the given DNAList.'''
    for DNA in DNAList:
        print(countCCAAT(DNA))

def multiCountCCAAT2(DNAList):
    '''Prints the number of occurrences of CCAAT in each string in the given DNAList.'''
    for DNA in DNAList:
        counter=0
        for index in rang(len(DNA)):
            if DNA[index:index+5]=='CCAAT':
                counter=counter+1
        print(counter)

#from visual import *
#ball1=sphere(pos=(-1,0,0), radius=0.5, color=color.blue)
#ball2=sphere(pos=(0,0,0), radius=0.5, color=color.green)
#ball3=sphere(pos=(1,0,0), radius=0.5, color=color.red)
#ball4=sphere(pos=(2,0,0), radius=0.5, color=color.yellow)
