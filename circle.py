# get user input
radius = int(input("Enter the radius for your circle: "))

#y axis

y = -radius

while y <= radius:

    #x axis
    x = -radius * 2
    
    while x <= radius * 2:

#da formula
        x_squared = x * x
        y_squared = y * y
        radius_squared = radius * radius

        difference = abs((x * x) // 4 + y * y - radius * radius)

# print the stars and shi

        if difference <= radius:  #this fucker prints the circle
            print("*", end="")

        else:
            print(" ", end="")    #and this fucker prints the space

    #god fucking damnit i fucking hate building this shitty ass circle
        x = x + 1

    print()

    y = y + 1



