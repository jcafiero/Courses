'''
Created on Feb 25, 2015

@author: Jennifer Cafiero
Pledge: I pledge my honor that I have abided by the Stevens Honor System.
'''

def pascal_row(n):
    '''Takes a single integer n as input and returns a list of elements found on the nth row of Pascal's triangle'''
    if n < 0:
        return "Error: negative number cannot be read"
    if n == 0:
        return [1]
    return [1] + pascal_helper(pascal_row(n-1))
    
def pascal_helper(lst):
    '''Takes a list lst as input and computes the sum of neighboring values for the function, pascal_row.'''
    if len(lst) == 1:
        return [1]
    return [lst[0]+lst[1]] + pascal_helper(lst[1:])
    
def pascal_triangle(n):
    '''Takes a single integer n as input and returns a list of lists which represent the rows in Pascal's Triangle through the nth row'''
    if n < 0:
        return []
    return pascal_triangle(n-1) + [pascal_row(n)]

print pascal_triangle(4)