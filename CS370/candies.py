def main():
    num_students = int(input())
    ratings = [0] * num_students
    candies = [1] * num_students
    for i in range(num_students):
        ratings[i] = int(input())
    for i in range(1, num_students):
        if ratings[i] > ratings[i-1] and candies[i] <= candies[i-1]:
            candies[i] = candies[i-1]+1
    for i in range(num_students-1, 0, -1):
        if ratings[i-1]> ratings[i] and candies[i-1]<= candies[i]:
            candies[i-1]=candies[i]+1
    print(sum(candies))
