def change(amount, Coins):
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

def LCS(String1, String2):
    if String1 == "":
        return 0
    elif String2 == "":
        return 0
    elif String1 == String2:
        return len(String1)
    else:
        first1 = String1[0]
        first2 = String2[0]
        if first1 == first2:
            return 1 + LCS(String1[1:], String2[1:])
        else:
            #useBoth = 1 + LCS(String1[1:], String2[1:])
            #useLeft = LCS(String1 + String2[1:])
            #useRight = LCS(String1[1:] + String2)
            #useNone = 
            return LCS(String1[1:], String2[1:])

