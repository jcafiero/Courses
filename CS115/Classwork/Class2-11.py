'''
Created on Feb 11, 2015

@author: O409
'''

def powerset(lst):
    if lst == []:
        return [[]]
    lose_it = powerset(lst[1:])
    use_it = map(lambda subset: [lst[0]] + subset, lose_it)
    return lose_it + use_it

print powerset([1,2,3])

def subset(target, lst):
    if target == 0:
        return True
    elif lst == []:
        return False
    use_it = subset(target-lst[0], lst[1:])
    lose_it = subset(target, lst[1:])
    return lose_it or use_it

print subset(4, [1, 3, 5, -2, 4])