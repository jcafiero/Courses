'''
Created on Feb 12, 2015

@author: Jennifer Cafiero
'''
def change(amount, Coins):
    '''Returns the minimum number of coins that the amount of change can be made with'''
    if amount == 0:
        return 0
    elif Coins == []:
         return float('inf')
    else:
        firstCoin = Coins[0]
        if firstCoin > amount:
            return change(amount, Coins[1:])
        else:
            useIt = 1 + change(amount-firstCoin, Coins)
            loseIt = change(amount, Coins[1:])
            return min(useIt, loseIt)
        