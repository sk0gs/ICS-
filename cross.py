star = "*"

# 2 user inputs: length (rows) and height (columns)
print("Welcome to the cross shape (+) ")
choice = int(input("Press (1) to continue and (2) to exit : "))
if choice == 1:
    
    length = int(input("Enter da length : "))
    height = int(input("Enter da height : "))
else:
    print("Good bye")
    exit()

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

rewind = str(input("start again (Y/N) : "))

if rewind == 'Y' or rewind == 'y':
    exec(open(__file__).read())

else:
    print("Good bye")



