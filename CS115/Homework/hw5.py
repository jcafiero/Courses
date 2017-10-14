'''
Created on March 2, 2015
@author:   Jennifer Cafiero
Pledge:   I pledge my honor that I have abided by the Stevens Honor System

CS115 - Hw 5
'''
import turtle  # Needed for graphics

def svTree(trunkLength, levels):
    '''Prints a tree using turtle graphics based on the input in pixels of trunkLength and the number of branches of levels'''
    if levels != 0:
        turtle.width(trunkLength/8)
        turtle.forward(trunkLength)
        turtle.left(30)
        svTree(trunkLength/2.0, levels-1)
        turtle.right(60)
        svTree(trunkLength/2.0, levels-1)
        turtle.left(30)
        turtle.backward(trunkLength)

def fastFib(n):
    '''Returns the nth Fibonacci number using the memoization technique
    shown in class and lab. Assume that the 0th Fibonacci number is 0, so
    fastFib(0) = 0,
    fastFib(1) = 1, and
    fastFib(2) = 1'''
    def fast_Fib_helper(n, memo):
        if n == "":
            result = "Error"
        if (n) in memo:
            return memo[(n)]
        if n == 0:
            return 0
        if n == 1:
            return 1
        else:
            result = fast_Fib_helper(n-1, memo) + fast_Fib_helper(n-2, memo)
        memo[n] = result
        return result
    return fast_Fib_helper(n, {})


# If you did this correctly, the results should be nearly instantaneous.
print fastFib(3)  # 2
print fastFib(5)  # 5
print fastFib(9)  # 34
print fastFib(24)  # 46368
print fastFib(40)  # 102334155
print fastFib(50)  # 12586269025