#
# life.py - Game of Life lab
#
# Name:
#

import random

def createOneRow(width):
    """ returns one row of zeros of width "width"...  
         You should use this in your
         createBoard(width, height) function """
    row = []
    for col in range(width):
        row += [0]
    return row

def createBoard(width, height):
    '''returns a 2d array with "height" rows and "width" cols'''
    A = []
    for row in range(height):
        A +=[createOneRow(width)]
    return A 

import sys 

def printBoard(A):
    '''this function prints the 2d list-of-lists A without spaces (using sys.stdout.write)'''
    for row in A:
        for col in row:
            sys.stdout.write(str(col))
        sys.stdout.write('\n')
        
A = createBoard(5, 3)

def diagonalize(width, height):
    '''creates an empty board and then modifies it so that it has a diagonal strip of "on" cells'''
    A = createBoard(width, height)
    for row in range(height):
        for col in range(width):
            if row == col:
                A[row][col] = 1
            else:
                A[row][col] = 0
    return A 

A = diagonalize(7,6)
#print printBoard(A)

def innerCells(w, h):
    '''creates a  board and modifies it so that all of the cells on the perimeter are "off"'''
    A = createBoard(w,h)
    for row in range(h):
        for col in range(w):
            if row == 0 or col == 0 or row == h-1 or col == w-1:
                A[row][col] = 0
            else:
                A[row][col] = 1
    return A 

A = innerCells(5,5)
#print printBoard(A)

import random

def randomCells(w,h):
    '''creates a board then modifies it so it is randomly assigned "on" cells'''
    A = createBoard(w,h)
    for row in range(h):
        for col in range(w):
            A[row][col] = random.choice([0,1])
    return A
            
A = randomCells(10,10)
#print printBoard(A)

oldA = createBoard(2,2)
#print printBoard(oldA)
newA=oldA
#print printBoard(newA)

def copy(A):
    '''copies 2d array A to a new 2d array B'''
    B = createBoard(len(A[0]), len(A))
    for row in range(len(A)):
        for col in range(len(A[0])):
            B[row][col] = A[row][col]
    return B
            
oldA = createBoard(2,2)
newA = copy(oldA)
oldA[0][0] = 1
#print printBoard(oldA)
#print printBoard(newA)

def innerReverse(A):
    '''calls the function reverse and changes every spot on the perimeter of the array to "off" then returns the array'''
    B = reverse(A)
    for row in range(len(B)):
        for col in range(len(B[0])):
            if row == 0 or col == 0 or row == len(A)-1 or col == len(A[0])-1:
                B[row][col] = 0
    return B

def reverse(A):
    '''copies the array A to a new array B and applies the helper function reverseHelper to every spot in the array, then returns the array'''
    B = copy(A)
    for row in range(len(A)):
        for col in range(len(A[0])):
            B[row][col] = reverseHelper(A[row][col])
    return B

def reverseHelper(a):
    '''used to reverse each individual cell in the array'''
    if a == 1:
        return 0
    else:
        return 1

A = randomCells(8,9)
#print printBoard(A)
A2 = innerReverse(A)
#print printBoard(A2)


def next_life_generation(A):
    '''makes a copy of A and then advance one generation of Conway's game of life
    within the *inner cells* of that copy. The outer edge always stays 0.'''
    newA = copy(A)
    for row in range(1, len(newA)-1):
        for col in range(1, len(newA[0])-1):
            if A[row-1][col] + A[row+1][col] + A[row][col-1] + A[row][col+1] + A[row-1][col-1] + A[row-1][col+1]+ A[row+1][col-1] + A[row+1][col+1] < 2:
                newA[row][col] = 0
            if A[row-1][col] + A[row+1][col] + A[row][col-1] + A[row][col+1] + A[row-1][col-1] + A[row-1][col+1]+ A[row+1][col-1] + A[row+1][col+1] > 3:
                newA[row][col] = 0
            if A[row-1][col] + A[row+1][col] + A[row][col-1] + A[row][col+1] + A[row-1][col-1] + A[row-1][col+1]+ A[row+1][col-1] + A[row+1][col+1] == 3:
                newA[row][col] = 1
    return newA



A = [[0,0,0,0,0], [0,0,1,0,0], [0,0,1,0,0], [0,0,1,0,0],[0,0,0,0,0]]
print printBoard(A)
A2 = next_life_generation(A)
print printBoard(A2)
A3 = next_life_generation(A2)
print printBoard(A3)

