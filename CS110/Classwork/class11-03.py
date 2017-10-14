StoE = {"hola" : "hello", "adios" : "goodbye", "tortuga" : "turtle"}
def mystery(n):
    output=[]
    for s in StoE.keys():
        e = StoE[s]
        if len(e) == n:
            output.append(e)
    return output

def change(amount, coins, memo):
    if amount == 0:
        return 0
    elif coins == ():
         return float('infinity')
    elif (amount, coins) in memo:
        return memo[(amount, coins)]
    elif coins[0] > amount:
        solution = change(amount, coins[1:], memo)
        memo[(amount, coins)] = solution
        return solution
    else:
        useIt = 1 + change(amount - coins[0], coins, memo)
        loseIt = change(amount, coins[1:], memo)
        solution = min(useIt, loseIt)
        memo[(amount, coins)] = solution
        return solution
