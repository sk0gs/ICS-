# Triangle shape program

# ANSI color codes
COLORS = {
    1: "\033[31m",   # RED
    2: "\033[32m",   # GREEN
    3: "\033[33m",   # YELLOW
    4: "\033[34m",   # BLUE
    5: "\033[35m",   # PURPLE
    6: "\033[36m",   # CYAN
    7: "\033[37m"    # WHITE
}

RESET = "\033[0m"


# SOLID TRIANGLE

def solid_triangle(size, color):
    for row in range(1, size + 1):

        spaces = size - row
        stars = 2 * row - 1

        print(" " * spaces + color + "*" * stars + RESET)


# HOLLOW TRIANGLE

def hollow_triangle(size, color):
    for row in range(1, size + 1):

        spaces = size - row
        stars = 2 * row - 1

        if row == 1:
            line = "*"

        elif row == size:
            line = "*" * stars

        else:
            inside_spaces = stars - 2
            line = "*" + " " * inside_spaces + "*"

        print(" " * spaces + color + line + RESET)


# INVERTED SOLID TRIANGLE

def inverted_solid_triangle(size, color):
    for row in range(size, 0, -1):

        spaces = size - row
        stars = 2 * row - 1

        print(" " * spaces + color + "*" * stars + RESET)


# INVERTED HOLLOW TRIANGLE

def inverted_hollow_triangle(size, color):
    for row in range(size, 0, -1):

        spaces = size - row
        stars = 2 * row - 1

        if row == size:
            line = "*" * stars

        elif row == 1:
            line = "*"

        else:
            inside_spaces = stars - 2
            line = "*" + " " * inside_spaces + "*"

        print(" " * spaces + color + line + RESET)


# LAYERED TRIANGLE

def layered_triangle(size):
    for row in range(1, size + 1):

        spaces = size - row
        stars = 2 * row - 1

        color_number = ((row - 1) % 7) + 1
        color = COLORS[color_number]

        print(" " * spaces + color + "*" * stars + RESET)


# DISPLAY DESIGN MENU

def display_design_menu():
    print("\nChoose a triangle design:")
    print("1. Solid Triangle")
    print("2. Hollow Triangle")
    print("3. Inverted Solid Triangle")
    print("4. Inverted Hollow Triangle")
    print("5. Layered Triangle")


# DISPLAY COLOR MENU

def display_color_menu():
    print("\nChoose a color:")
    print("1. Red")
    print("2. Green")
    print("3. Yellow")
    print("4. Blue")
    print("5. Purple")
    print("6. Cyan")
    print("7. White")


# MAIN PROGRAM

def main():
    print("================================")
    print("       TRIANGLE GENERATOR")
    print("================================")

    while True:
        try:
            size = int(input("\nEnter triangle size (1-50): "))

            if 1 <= size <= 50:
                break

            print("Please enter a size between 1 and 50.")

        except ValueError:
            print("Please enter a valid number.")

    while True:
        display_design_menu()

        try:
            design = int(input("Enter design (1-5): "))

            if 1 <= design <= 5:
                break

            print("Please choose a number from 1 to 5.")

        except ValueError:
            print("Please enter a valid number.")

    while True:
        display_color_menu()

        try:
            color_choice = int(input("Enter colour (1-7): "))

            if 1 <= color_choice <= 7:
                break

            print("Please choose a number from 1 to 7.")

        except ValueError:
            print("Please enter a valid number.")

    color = COLORS[color_choice]

    print("\n")
    print("Your triangle:")
    print()

    if design == 1:
        solid_triangle(size, color)

    elif design == 2:
        hollow_triangle(size, color)

    elif design == 3:
        inverted_solid_triangle(size, color)

    elif design == 4:
        inverted_hollow_triangle(size, color)

    elif design == 5:
        layered_triangle(size)

if __name__ == "__main__":
    main()