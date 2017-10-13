# Jordana Approvato, Jennifer Cafiero, and Catherine Javadian
# We pledge our honor that we have abided by the Stevens Honor System

import heapq

minh = []
maxh = []


def findMed(minh, maxh):
    '''Returns a float value of the median, the index of the min-heap if it is longer than the max-heap,
        the index of the max-heap if it is longer than the min-heap, and the average of the two indexes if the
        min- and max-heaps are the same length.'''
    if len(minh)>len(maxh):
        return float (minh[0])
    elif len(maxh)>len(minh):
        return float (-1*maxh[0])
    else:
        return float ((minh[0]+(-1*maxh[0]))/2)

def bal(minh, maxh):
    '''Balances the min and max heaps. If the min-heap is longer, push the head of the min-heap to the max-heap.
        If the max-heap is longer, push the head of the max heap to the min-heap.'''
    if(len(minh)-len(maxh)>1):
        heapq.heappush(maxh, -1*heapq.heappop(minh))
    elif(len(maxh)-len(minh)>1):
        heapq.heappush(minh, -1*heapq.heappop(maxh))
    return
    
def main():
    lines = int(input().strip())
    while (lines):
        num = int(input().strip())
        if not minh:
            heapq.heappush(minh,num)
            print(findMed(minh, maxh))
            lines = lines - 1
            continue
        elif not maxh:
            if num < minh[0]:
                heapq.heappush(maxh,-1*num)
                print(findMed(minh, maxh))
            else:
                heapq.heappush(maxh,-1*heapq.heappop(minh))
                heapq.heappush(minh,num)
                print(findMed(minh,maxh))
            lines = lines - 1
            continue
        if -1*num > maxh[0]:
                heapq.heappush(maxh,-1*num)
        else:
            heapq.heappush(minh,num)
        bal(minh, maxh)
        print(findMed(minh, maxh))
        lines = lines - 1

main()
