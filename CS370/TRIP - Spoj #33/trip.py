memo = {}
strings = {}

import time

def fast_LCS(S1, S2):
    global memo
    def fast_LCS_helper(S1, S2, memo):
        if (S1, S2) in memo:
            return memo[(S1, S2)]
        if S1 == '' or S2 == '':
            return 0
        elif S1[0] == S2[0]:
            return 1 + fast_LCS_helper(S1[1:], S2[1:], memo)
        else:
            result = max(fast_LCS_helper(S1[1:], S2, memo), fast_LCS_helper(S1, S2[1:], memo))
        memo[(S1, S2)] = result
        return result
    return fast_LCS_helper(S1, S2, {})

def getList(S1, S2, a, num):
    global strings
    global memo
    if len(a) == num:
       strings[a] = a
       memo[(S1, S2, a)] = a            
    if (S1, S2, a) in memo:
       return memo[(S1, S2, a)]
    if S1 == '' or S2 == '':
       return ''
    if S1[0] == S2[0]:
       a = getList(S1[1:], S2[1:], a+S1[0], num)
       return a + S1[0]
    use_S1 = getList(S1[1:], S2, a, num)
    use_S2 = getList(S1, S2[1:], a, num)
    if use_S1 > use_S2:
       memo[(S1, S2, a)] = use_S1
       return (use_S1)
    memo[(S1, S2, a)] = use_S2
    return (use_S2)

def main():
    global strings
    x = input()
    lines = int(x)
    while lines > 0:
        line1 = input()
        Alice = str(line1)
        line2 = input()
        Bob = str(line2)
        start = time.time()
        num = fast_LCS(Alice, Bob)
        aList = getList(Alice, Bob, '', num)
        #print("line: " + lines + ", Alice: " + Alice + ", Bob: " + Bob)
        count = 0
        for x in strings:
            if count == 999:
                break
            print(x)
            count = count + 1
        if (lines != 1):
            print("")
        lines = lines - 1
        strings.clear()
    end = time.time()
    print(end - start)
    return

##if(__name__ == "__main__"):
##    main()

