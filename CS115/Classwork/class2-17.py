'''
Created on Feb 17, 2015

@author: Jennifer Cafiero
'''
M = ['p', 's', 'n', 'r', 'o', 'gw']
print M[5]
'''Three types of recursion: linear, tail, & tree'''

def change(amount, coins):
    if amount <= 0:
        return 0
    if coins == []:
        return float('inf')
    if coins[0] > amount:
        return change(amount, coins[1:])
    lose_it = change(amount, coins[1:])
    use_it = change(amount - coins[0], coins)
    return min(lose_it, 1 + use_it)


def fast_change(amount, coins):
    def fast_change_helper(amount, coins, memo):
        if (amount, coins) in memo:
            return memo[(amount, coins)]
        
        if amount <= 0:
            result = 0
        elif len(coins) == 0:
            result = float("inf")
        elif coins[0] > amount:
            result = fast_change_helper(amount, coins[1:], memo)
        else:
            lose_it = fast_change_helper(amount, coins[1:], memo)
            use_it = 1 + fast_change_helper(amount - coins[0], coins, memo)
            result = min(lose_it, use_it)
            
        memo[(amount, coins)] = result
        return result
    return fast_change_helper(amount, tuple(coins), {})

import time
start_time = time.time()
print fast_change(457, [1, 5, 10, 20, 50, 100])
end_time = time.time()
print "Elapsed Time: ", end_time - start_time, "seconds"