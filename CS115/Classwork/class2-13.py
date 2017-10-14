'''
Created on Feb 13, 2015

@author: O409
'''
def subset_with_values(target, lst):
    if target == 0:
        return [True, []]
    if lst == []:
        return [False, []]
    use_it = subset_with_values(target - lst[0], lst[1:])
    if use_it[0]:
        return [True, use_it[1] + [lst[0]]]
    return subset_with_values(target, lst[1:])

print subset_with_values(4, [1,2,3,4,5,6])

def LCS(s1, s2):
    if s1 == "" or s2 == "":
        return 0
    if s1[0] == s2[0]:
        return 1 + LCS(s1[1:], s2[1:])
    return max(LCS(s1[1:], s2), LCS(s1,s2[1:]))

print LCS("sam", "spam")
print LCS('sapm', 'sam')