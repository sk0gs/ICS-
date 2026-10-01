# Ask the user for the radius and convert it to an integer
radius = int(input("Enter the radius of the circle: "))

# Start y from the bottom of the circle (-radius)
y = -radius

# Keep looping as long as y is less than or equal to +radius
while y <= radius:

    # Start x from the left side of the circle (-radius)
    x = -radius * 2

    # Keep looping as long as x is less than or equal to +radius
    while x <= radius * 2:

        # Calculate x²
        x_squared = x * x

        # Calculate y²
        y_squared = y * y

        # Calculate radius²
        radius_squared = radius * radius

        # Find how far this point is from the perfect circle
        difference = abs((x * x) // 4 + y * y - radius * radius)

        # If the point is close enough to the circle, print a star
        if difference <= radius:
            print("*", end="")      # stay on the same line
        else:
            print(" ", end="")      # print space and stay on the same line

        # Move to the next x position (go right)
        x = x + 1

    # After finishing one row, move down to the next line
    print()

    # Move to the next y position (go up)
    y = y + 1
