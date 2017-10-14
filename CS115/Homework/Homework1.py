'''
Created on Feb 2, 2015

@author: Jennifer Cafiero
'''
def mult(x, y):
    '''Returns the product of x and y'''
    return x * y 

def factorial(n):
    return reduce(mult, range(1, n+1))

print factorial(5)

def add(x, y):
    return x + y

def mean(L):
    return float(reduce(add, L)/len(L))

print mean([1,2,3])


def divides(n):
    def div(k):
        return n % k == 0
    return div

print divides(12)(3)


def prime(n):
    lst = map(divides(n), range(2, n))
    return sum(lst) == 0

print prime(71)