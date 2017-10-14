'''
Created on Feb 4, 2015

@author: Jennifer Cafiero
'''
import math

def inverse(n):
    return float(1)/n

print inverse(3)

def e(n):
    return sum(map(inverse, map(math.factorial, range(0, n+1))))

print e(1)

def error(n):
    return abs(math.e - e(n))

print error(1)