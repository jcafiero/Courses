def LCS(S1, S2):
    if S1 == '' or S2 == '':
        return 0
    if S1[0] == S2[0]:
        return 1 + LCS(S1[1:], S2[1:])
    return max(LCS(S1[1:], S2), LCS(S1, S2[1:]))

'''print(LCS('abcdez', 'bed'))'''

def fast_LCS(S1, S2):
    def fast_LCS_helper(S1, S2, memo):
        if (S1, S2) in memo:
            return memo[(S1, S2)]
        if S1 == '' or S2 == '':
            result = 0
        elif S1[0] == S2[0]:
            result =  1 + fast_LCS_helper(S1[1:], S2[1:], memo)
        else: 
            result = max(fast_LCS_helper(S1[1:], S2, memo), fast_LCS_helper(S1, S2[1:], memo))
        memo[(S1, S2)] = result
        return result

    return fast_LCS_helper(S1, S2, {})

def LCS_with_values(S1, S2):
    if S1 == '' or S2 == '':
        return (0, '')
    if S1[0] == S2[0]:
        result = LCS_with_values(S1[1:], S2[1:])
        return (1 + result[0], S1[0] + result[1])
    use_s1 = LCS_with_values(S1, S2[1:])
    use_s2 = LCS_with_values(S1[1:], S2)
    if use_s1[0] > use_s2[0]:
        return use_s1
    return use_s2

def LIS(S1, S2):
    
