#Author: Jennifer Cafiero
#I pledge my honor that I have abided by the Stevens Honor System.

def replace(x,y,lst):
    for i in range(0, len(lst)):
        if (lst[i]==x):
            lst[i]=y
        else:
            lst[i]=lst[i]
    return lst

def x_count(x,lst):
    count=0
    for i in range(0, len(lst)):
        if (lst[i]==x):
            count += 1
    return count
