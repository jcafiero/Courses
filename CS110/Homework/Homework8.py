#Author: Jennifer Cafiero
#I pledge my honor that I have abided by the Stevens Honor System.

def memosubset(capacity, items, memo):
    if capacity == 0:
        return True
    elif items == ():
        return False
    elif (capacity, items) in memo:
        return memo[(capacity, items)]
    elif items[0] > capacity:
        solution = memosubset(capacity, items[1:], memo)
        memo[(capacity, items)] = solution
        return solution
    else:
        loseIt = memosubset(capacity, items[1:], memo)
        useIt = memosubset(capacity - items[0], items[1:], memo)
        solution = useIt or loseIt
        memo[(capacity, items)] = solution
        return solution
#Output: True

def factorialList(lst):
    def helpFac(number):
        num = 1
        for i in range(number+1):
            if i != 0:
                num = num * i       
        return num
    return map(helpFac,lst)

def memofactorialList(lst, memo):
    def factorial(number):
        num = 1
        for i in range(number+1):
            if i != 0:
                num = num * i
        memo[(lst)] = num       
        return num

    if type(lst) is not tuple:
        print(" Invalid input! ")
        return ()
    
    if lst == ():
        return []
    
    elif lst in memo.keys():
        return memo[lst]
    
    else:
        newlst = []
        for x in lst:
            newlst.append(factorial(x))
        return tuple(newlst)

#Input the lst in tuple format, along with an empty dictionary.      
#The idea of memoization will help speed up solving every factorial because once you get to a set of numbers you have previously ran, the shell will just look up the end result rather than go through the steps over and over again.
