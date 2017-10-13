#Author: Jennifer Cafiero
#SPOJ ACODE - Alpha code - NEEDS TO BE FIXED
import math

def acode(num):
    count = 1
    last = 1
    for i in range(len(num) - 1):
        #first character isn't zero & int(s[x:x+2]) <=26
        if (num[i] != "0" and int(num[i:i + 2]) <= 26):
            if (int(num[i:i+2]) % 10 == 0):
                count = last
            else:
                temp = count
                count += last
                last = temp
        else:
            if (int(num[i:i+2]) % 10 == 0):
                last = count

    return count
    


def main():
    var = raw_input()
    if (var != '0'):
        return acode(var)
    return 0
