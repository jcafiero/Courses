'''
Created on Apr 27, 2015
@author: Jennifer Cafiero
Pledge: I pledge my honor that I have abided by the Stevens Honor System.
'''

class Board(object):
    def __init__(self, width, height):
        '''Initializes the two-dimensional array of space characters'''
        self.width = width
        self.height = height
        theBoard = []
        for row in range(self.height):
            l = []
            for col in range(self.width):
                l += [" "]
            theBoard+=[l]
        self.theBoard = theBoard

    def __str__(self):
        '''Returns the board as a string'''
        x = ''
        for row in range(len(self.theBoard)):
            for col in range(len(self.theBoard[row])):
                x += '|' + self.theBoard[row][col]
            x += "|"+ "\n"
        x += (self.width*"--") +"-"+ "\n"
        x += " "
        for i in range(len(self.theBoard[1])):
            x += str(i) + " "
        return x
    
    def allowsMove(self, col):
        '''Checks to see if there is space left to make a move in the specified column and if the column is a valid column possibility.'''
        if col <= self.width-1:
            for rows in self.theBoard:
                if rows[col] == " ":
                    return True
        return False
    
    def lowest(self, col):
        '''Finds the lowest available row in a specified column'''
        for row in range((self.height-1), -1, -1):
            if self.theBoard[row][col] == " ":
                return row
        return False
    
    def addMove(self, col, ox):
        '''Adds the specified letter held in variable ox to the lowest row of the specified column'''
        self.theBoard[self.lowest(col)][col] = ox

    def setBoard(self, move_string):
        """ Takes in a string of columns and places alternating checkers in those columns, starting with 'X'
        For example, call b.setBoard('012345') to see 'X's and 'O's alternate on the bottom row, or b.setBoard('000000') to
        see them alternate in the left column. moveString must be a string of integers"""
        nextChar = 'X'   # start by playing 'X'
        for colString in move_string:
            col = int(colString)
            if 0 <= col <= self.width:
                self.addMove(col, nextChar)
                if nextChar == 'X':
                    nextChar = 'O'
                else:
                    nextChar = 'X'
        return self.theBoard
    
    def delMove(self, col):
        '''Deletes a specified letter held in ox in the lowest row of a specified column'''
        self.theBoard[self.lowest(col)][col] = " "
    
    def winsFor(self, ox):
        '''Returns true if there are four of the same checker held in variable ox in a row, column, or diagonally.'''
        for row in range(self.height):
            for i in range(self.width-3):
                if self.theBoard[row][i] == self.theBoard[row][i+1]\
                 == self.theBoard[row][i+2] == self.theBoard[row][i+3] == ox:
                    return True
        for col in range(self.width):
            for row in range(self.height-3):
                if self.theBoard[row][col] == self.theBoard[row+1][col]\
                 == self.theBoard[row+2][col] == self.theBoard[row+3][col] == ox:
                    return True
        for row in range(self.height-3):
            for col in range(self.width-3):
                if self.theBoard[row][col] == self.theBoard[row+1][col+1]\
                == self.theBoard[row+2][col+2] == self.theBoard[row+3][col+3] == ox:
                    return True
        for row in range(self.height-1, 2, -1):
            for col in range(self.width-3):
                if self.theBoard[row][col] == self.theBoard[row-1][col+1]\
                == self.theBoard[row-2][col+2] == self.theBoard[row-3][col+3] == ox:
                    return True
            
    def hostGame(self):
        '''Allows the user(s) to play a game of Connect 4.'''
        print "Welcome to Connect 4!"
        print self
        ox = "X"
        while (1):
            col = input(ox + "'s Turn: ")
            if Board.allowsMove(self, col) == False :
                print "This column is full or may not be a valid column. Please pick another column."
            else:
                Board.addMove(self, col, ox)
                print self
                if Board.winsFor(self, ox):
                    print ox + " is the winner!"
                    break
                if ox == "X":
                    ox = "O"
                else:
                    ox = "X"
            
hw12 = Board(8, 6)
hw12.hostGame()