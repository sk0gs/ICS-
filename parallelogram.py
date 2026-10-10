# Parallelogram shape program


# ANSI color codes
COLORS = {
    1: "\033[31m",  # RED
    2: "\033[32m",  # GREEN
    3: "\033[33m",  # YELLOW
    4: "\033[34m",  # BLUE
    5: "\033[35m",  # PURPLE
    6: "\033[36m",  # CYAN
    7: "\033[37m"   # WHITE
}

RESET = "\033[0m"


# SOLID PARALLELOGRAM

def solid_parallelogram(size, color):

    height = size
    length = size * 2

    for row in range(height):

        spaces = row * 2

        print(" " * spaces + color + "*" * length + RESET)


# HOLLOW PARALLELOGRAM

def hollow_parallelogram(size, color):

    height = size
    length = size * 2

    for row in range(height):

        spaces = row * 2

        if row == 0 or row == height - 1:
            line = "*" * length

        else:
            line = "*" + " " * (length - 2) + "*"

        print(" " * spaces + color + line + RESET)


# INVERTED SOLID PARALLELOGRAM

def inverted_solid_parallelogram(size, color):

    height = size
    length = size * 2

    for row in range(height):

        spaces = (height - 1 - row) * 2

        print(" " * spaces + color + "*" * length + RESET)


# INVERTED HOLLOW PARALLELOGRAM

def inverted_hollow_parallelogram(size, color):

    height = size
    length = size * 2

    for row in range(height):

        spaces = (height - 1 - row) * 2

        if row == 0 or row == height - 1:
            line = "*" * length

        else:
            line = "*" + " " * (length - 2) + "*"

        print(" " * spaces + color + line + RESET)


# LAYERED PARALLELOGRAM

def layered_parallelogram(size):

    height = size
    length = size * 2

    for row in range(height):

        spaces = row * 2

        color_number = (row % 7) + 1
        color = COLORS[color_number]

        print(" " * spaces + color + "*" * length + RESET)


# DISPLAY DESIGN MENU

def display_design_menu():

    print("\nChoose a parallelogram design:")
    print("1. Solid")
    print("2. Hollow")
    print("3. Inverted Solid")
    print("4. Inverted Hollow")
    print("5. Layered / Striped")


# DISPLAY COLOR MENU

def display_color_menu():

    print("\nChoose a colour:")
    print("1. Red")
    print("2. Green")
    print("3. Yellow")
    print("4. Blue")
    print("5. Purple")
    print("6. Cyan")
    print("7. White")


# MAIN PROGRAM

def main():

    print("====================================")
    print("       PARALLELOGRAM GENERATOR")
    print("====================================")

    while True:

        try:
            size = int(input("\nEnter parallelogram size (3-20): "))

            if 3 <= size <= 20:
                break

            print("Please enter a size between 3 and 20.")

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
    print("Your parallelogram:")
    print()


    if design == 1:
        solid_parallelogram(size, color)

    elif design == 2:
        hollow_parallelogram(size, color)

    elif design == 3:
        inverted_solid_parallelogram(size, color)

    elif design == 4:
        inverted_hollow_parallelogram(size, color)

    elif design == 5:
        layered_parallelogram(size)


if __name__ == "__main__":
    main()