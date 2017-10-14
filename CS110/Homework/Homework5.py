#Author: Jennifer Cafiero
#I pledge my honor that I have abided by the Stevens Honor System.

def findBlack(code, guess, colors):
    lst=[]
    found=0
    for i in range(len(code)):
        if code[i]==guess[i]:
            lst.append("black")
        else:
            lst.append("dummy")
    print lst
    seclst=[]
    n=0
    for i in range(len(code)):
        if (code[i]==guess[i]&code[i]==n):
            seclst[i]+=seclst[i]
            n+=1
    print seclst
        
def replaceFirstTwo(x,y,lst):
    counter = 0
    index=0
    while (counter < 2 and index<len(list)):
        if list[index]==x
            list[index
        counter+=1
        inrex+=1
        for i in range(0, len(lst)):
            if (lst[i]==x):
                lst[i]=y
                counter += 1
        return lst
    for i in list:
        if i ==x:
            if counter<2:
                list.insert(list.index[i],y)
                list.remove(i)
    return list

def sum1(lst):
    total=0
    for num in lst:
        total=total+num
    return total

def sum2(lst):
    total=0
    for num in lst:
        total=total+num
        return total


#Question 3 (a)
#In sum1, the total is returned after the whole list is summed up.
#In sum2, the total is returned after the first number in the list is added. The function stops after this first number is .

#Question 3 (b)
#Input the list [20] into both functions
#sum1([20]) returns 20
#sum2([20]) returns 20

#Question 3 (c)
#Input the list [1,3,5,7,8,9,2] into both functions to receive different outputs.
#sum1([1,3,5,7,8,2,9]) returns 35
#sum2([1,3,5,7,8,2,9]) returns 1
