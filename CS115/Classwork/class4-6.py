'''
Created on Apr 6, 2015

@author: Jennifer Cafiero
'''

board = [['X', 'X', 'O'], ['O', 'X', 'X'], ['X', 'O', 'O'], ['X', 'X', 'X']]

def display_board(board):
    rows = len(board)
    for row in range(len(board)):
        print '',   #print space, keep cursor on same line
        cols = len(board[row])
        for col in range(3):
            print board[row][col],
            if col < cols - 1:
                print '|',
        print
        if row < rows -1:
            print '-' * (cols * 4 - 1)
            
display_board(board)

def swap(lst, a, b):
    temp = lst[a]
    lst[a] = lst[b]
    lst[b] = temp

def selection_sort(lst):
    n = len(lst)
    for i in range(n - 1):
        min_index = i 
        for j in range(i + 1, n):
            if lst[j] < lst[min_index]:
                min_index = j
        if i != min_index:
            swap(lst, i, min_index)
    return lst
        
lst = [6, 3, 5, 8, 9, 7, 10]

print selection_sort(lst)    