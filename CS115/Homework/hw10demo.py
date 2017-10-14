'''
Created on Apr 9, 2015

@author: O409
'''
D = {}
file_name = "data.txt"

def read():
    my_File = open(file_name, 'r')
    s = my_File.read()
    L = s.split('\n')
    for i in range(len(L)):
        x = L[i]
        l = x.split(":")
        D[l[0]] = l[1]
    print D
    
def write():
    my_File = open(file_name, "w")
    for i in D:
        my_File.write(i + ":"+D[i]+ "\n")
    my_File.close()
    
def collectData():
    read()
    while (l):
        name = raw_input("Enter name: ")
        name = name.strip()
        name = name.title()
        if name == "End":
            break
        movie = raw_input("Enter movie:")
        movie = movie.strip()
        movie = movie.title()
        D[name] = movie
    write()