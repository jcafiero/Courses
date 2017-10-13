
def main():
    for x in range(input()):
        n, m, x = map(int, raw_input().split())
        n_stack = list(map(int, raw_input().split()))
        m_stack = list(map(int, raw_input().split()))

        pieces = 0
        rem = 0
        count = 0
        j = 0
        
        for i in range(n):
            while (rem + n_stack[i] <= x):
                rem += n_stack[i]
                i+=1
            count = i
            while (j < m and i >= 0):
                rem += m_stack[j]
                j+= 1
                while (rem > x and i > 0):
                    i = i - 1
                    rem = rem - n_stack[i]
                if (rem <= x):
                    count = i + j
        print count
                    
            
        
        
if __name__ == "__main__":
    main()
