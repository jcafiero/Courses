def factorial(rawr):
    if rawr == 1:
        return 1
    else:
        return rawr * factorial(rawr-1)

def sum(lst):
    if lst == []:
        return 0
    else:
        return lst[0] + sum(lst[1:])

def odd(lst):
    if lst == []:
        return []
    else:
        if (lst[0]%2==0):
            return odd(lst[1:])
        else:
            return [lst[0]] + odd(lst[1:])
        
def even(lst):
    if lst == []:
        return []
    else:
        if (lst[0]%2==1):
            return even(lst[1:])
        else:
            return [lst[0]] + even(lst[1:])

def subset(num, lst):
    if lst == []:
        return False
    elif num == 0:
        return True
    elif lst[0] > num:
        return subset(num, lst[1:])
    else:
        loseIt = subset(num, lst[1:])
        useIt = subset(num-lst[0], lst[1:])
    return useIt or loseIt

def change(amt, coins):
    if amt == 0:
        return [0, []]
    elif coins[0] > amt:
        return change(amt, coins[1:])
    else:
        loseIt = change(amt, coins[1:])
        useIt = change(amt-coins[0], coins[1:])
    return min(useIt or loseIt)

def showChange(amt, coins):
    if amt == 0:
        return [0, []]
    elif Coins == []:
        return [float('inf'), []]
    else:
        coin1 = coins[0]
        if coin1 > amt:
            return showChange(amt, coins[1:])
        else:
            loseIt = showChange(amt, coins[1:])
            useIt = showChange(amt-coin1, coins[1:])
            useIt[0] += 1
            useIt[1] += coin1
            if useIt[0] < loseIt[0]:
                return useIt
            else:
                return loseIt



ABCs = ('A', ('B', ('D', (), ()), ('E', (), ())), ('C', ('F', (), ()), ('G', (), ())))

Tree = ('fruits', ('apple', (), ()), ('banana', (15, (), ()), (20, (), ()))        
