star = "*"


print("Welcome to the cross shape (+) ")
length = int(input("Enter da length : "))
height = int(input("Enter da height : "))

# find the middle of each dimension
mid_row = length // 2
mid_col = height // 2

# nested for loop to draw the cross
for row in range(length):
    for col in range(height):
        if row == mid_row or col == mid_col:
            print(star, end=" ")
        else:
            print(" ", end=" ")

    print()



