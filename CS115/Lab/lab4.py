'''
Created on Feb 19, 2015

@author: Jennifer Cafiero
I pledge my honor that I have abided by the Stevens Honor System.
'''

def knapsack(capacity, itemlist):
	'''Returns the maximum value and list of items that can be held in the knapsack'''
    if itemlist == [] or capacity == 0:
        return [0, []]
    else:
        if capacity < itemlist[0][0]:
            return knapsack(capacity, itemlist[1:])
        else:
            temp = knapsack(capacity-itemlist[0][0], itemlist[1:])
            loseIt = knapsack(capacity, itemlist[1:])
            useIt = [itemlist[0][1] + temp[0], temp[1] + [itemlist[0]]]
            return max(useIt, loseIt)
    
print knapsack(6, [[1, 4], [5, 150], [4, 180]])
print knapsack(76, [[36, 35], [10, 28], [39, 47], [8, 1], [7, 24]])