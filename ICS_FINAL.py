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
def display_triangle_design_menu():
    print("\nChoose a triangle design:")
    print("1. Solid Triangle")
    print("2. Hollow Triangle")
    print("3. Inverted Solid Triangle")
    print("4. Inverted Hollow Triangle")
    print("5. Layered Triangle")


# DISPLAY COLOR MENU
def display_triangle_color_menu():
    print("\nChoose a color:")
    print("1. Red")
    print("2. Green")
    print("3. Yellow")
    print("4. Blue")
    print("5. Purple")
    print("6. Cyan")
    print("7. White")


# MAIN PROGRAM
def triangle():
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
        display_triangle_design_menu()

        try:
            design = int(input("Enter design (1-5): "))

            if 1 <= design <= 5:
                break

            print("Please choose a number from 1 to 5.")

        except ValueError:
            print("Please enter a valid number.")

    while True:
        display_triangle_color_menu()

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
def display_parallelogram_design_menu():
    print("\nChoose a parallelogram design:")
    print("1. Solid")
    print("2. Hollow")
    print("3. Inverted Solid")
    print("4. Inverted Hollow")
    print("5. Layered / Striped")


# DISPLAY COLOR MENU
def display_parallelogram_color_menu():
    print("\nChoose a colour:")
    print("1. Red")
    print("2. Green")
    print("3. Yellow")
    print("4. Blue")
    print("5. Purple")
    print("6. Cyan")
    print("7. White")


# MAIN PROGRAM
def parallelogram():
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
        display_parallelogram_design_menu()

        try:
            design = int(input("Enter design (1-5): "))

            if 1 <= design <= 5:
                break

            print("Please choose a number from 1 to 5.")

        except ValueError:
            print("Please enter a valid number.")

    while True:
        display_parallelogram_color_menu()

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


def rectangle_menu():

    while True:
        print("===== Rectangle Generator =====\n")
        print("1- Continue")
        print("2- Return")

        menu_option = input("Enter your option (1-2): ").strip()

        if menu_option == '1':

            rec_quantity, rec_height, rec_width, rec_shape, rec_alignment, rec_symbol, rec_color = rectangle_custom()

            generate_rec(
                rec_quantity,
                rec_height,
                rec_width,
                rec_shape,
                rec_alignment,
                rec_symbol,
                rec_color
            )

        elif menu_option == '2':
            break

        else:
            print("Invalid option.")


def rectangle_custom():

    while True:
        rec_quantity = input("Enter quantity (1-9): ").strip()

        if rec_quantity.isdigit():
            rec_quantity = int(rec_quantity)

            if 1 <= rec_quantity <= 9:
                break

            print("Invalid option.")

        else:
            print("Invalid option.")

    while True:
        rec_height = input("Enter height (2-25): ").strip()

        if rec_height.isdigit():
            rec_height = int(rec_height)

            if 2 <= rec_height <= 25:
                break

            print("Invalid option.")

        else:
            print("Invalid option.")

    while True:
        rec_width = input("Enter width (2-50): ").strip()

        if rec_width.isdigit():
            rec_width = int(rec_width)

            if 2 <= rec_width <= 50:
                break

            print("Invalid option.")

        else:
            print("Invalid option.")

    while True:
        print("== Shape options ==")
        print("1- Filled")
        print("2- Hollow")

        shape_option = input("Enter your option (1-2): ").strip()

        if shape_option == '1':
            rec_shape = 1
            break

        elif shape_option == '2':
            rec_shape = 2
            break

        else:
            print("Invalid option.")

    while True:
        print("== Alignment options ==")
        print("1- Left")
        print("2- Middle")
        print("3- Right")

        alignment_option = input("Enter your option (1-3): ").strip()

        if alignment_option == '1':
            rec_alignment = 0
            break

        elif alignment_option == '2':
            rec_alignment = 20
            break

        elif alignment_option == '3':
            rec_alignment = 40
            break

        else:
            print("Invalid option.")

    while True:
        rec_symbol = input("Enter your preferred symbol/character to draw in :").strip()

        if len(rec_symbol) == 1:
            break

        else:
            print("Invalid option.")

    while True:
        print("== Color options ==")
        print("1- White")
        print("2- Red")
        print("3- Green")
        print("4- Blue")

        color_option = input("Enter your option (1-4): ").strip()

        if color_option == '1':
            rec_color = '\033[37m'
            break

        elif color_option == '2':
            rec_color = '\033[31m'
            break

        elif color_option == '3':
            rec_color = '\033[32m'
            break

        elif color_option == '4':
            rec_color = '\033[34m'
            break

        else:
            print("Invalid option.")

    return rec_quantity, rec_height, rec_width, rec_shape, rec_alignment, rec_symbol, rec_color


def generate_rec(rec_quantity, rec_height, rec_width, rec_shape, rec_alignment, rec_symbol, rec_color):

    print('\n')

    reset_color = '\033[0m'

    print(rec_color)

    for q in range(rec_quantity):

        rec_row = 1

        for r in range(rec_height):

            rec_column = 1

            print(' ' * rec_alignment, end='')

            for c in range(rec_width):

                if rec_shape == 1:
                    print(rec_symbol, end='')

                elif rec_row == 1:
                    print(rec_symbol, end='')

                elif rec_row == rec_height:
                    print(rec_symbol, end='')

                elif rec_column == 1:
                    print(rec_symbol, end='')

                elif rec_column == rec_width:
                    print(rec_symbol, end='')

                else:
                    print(' ', end='')

                rec_column += 1

            print()

            rec_row += 1

        print()

    print()
    print(reset_color)

    print("Done!. Returning to previous menu.\n")


def cross():

    star = "*"

    print("Welcome to the cross shape (+) ")

    choice = int(input("Press (1) to continue and (2) to exit : "))

    if choice == 1:

        length = int(input("Enter da length : "))
        height = int(input("Enter da height : "))

    else:
        print("Good bye")
        return

    mid_row = length // 2
    mid_col = height // 2

    for row in range(length):

        for col in range(height):

            if row == mid_row or col == mid_col:
                print(star, end=" ")

            else:
                print(" ", end=" ")

        print()


# Diamond Generator
DIAMOND_COLORS = {
    "1": "\033[31m",  # Red
    "2": "\033[32m",  # Green
    "3": "\033[33m",  # Yellow
    "4": "\033[34m",  # Blue
    "5": "\033[35m",  # Purple
    "6": "\033[36m",  # Cyan
    "7": "\033[37m"   # White
}

RESET = "\033[0m"


def get_number(prompt, minimum, maximum):

    while True:

        try:
            number = int(input(prompt))

            if minimum <= number <= maximum:
                return number

            print(f"Please enter a number from {minimum} to {maximum}.")

        except ValueError:
            print("Invalid input! Please enter a number.")


def get_diamond(size, symbol, style):

    rows = []

    for row in range(1, size + 1):

        spaces = size - row
        symbols = 2 * row - 1

        if style == "2" and row != size:

            if row == 1:
                line = symbol

            else:
                line = symbol + " " * (symbols - 2) + symbol

        else:
            line = symbol * symbols

        rows.append(" " * spaces + line)

    for row in range(size - 1, 0, -1):

        spaces = size - row
        symbols = 2 * row - 1

        if style == "2":

            if row == 1:
                line = symbol

            else:
                line = symbol + " " * (symbols - 2) + symbol

        else:
            line = symbol * symbols

        rows.append(" " * spaces + line)

    return rows


def diamond():

    print("===== DIAMOND GENERATOR =====")

    size = get_number("Enter diamond size (1-9): ", 1, 9)

    print("\nChoose a symbol:")
    print("1. *")
    print("2. #")
    print("3. @")
    print("4. $")
    print("5. &")

    symbol_choice = get_number("Enter your choice (1-5): ", 1, 5)

    symbols = ["*", "#", "@", "$", "&"]

    symbol = symbols[symbol_choice - 1]

    print("\nChoose a style:")
    print("1. Filled")
    print("2. Hollow")

    style = get_number("Enter your choice (1-2): ", 1, 2)

    style = str(style)

    print("\nChoose a colour:")
    print("1. Red")
    print("2. Green")
    print("3. Yellow")
    print("4. Blue")
    print("5. Purple")
    print("6. Cyan")
    print("7. White")
    print("8. Rainbow")

    colour_choice = get_number("Enter your choice (1-8): ", 1, 8)

    print("\nChoose a position:")
    print("1. Left")
    print("2. Centre")
    print("3. Right")

    position = get_number("Enter your choice (1-3): ", 1, 3)

    quantity = get_number("\nHow many diamonds (1-5)? ", 1, 5)

    diamond_rows = get_diamond(size, symbol, style)

    print("\n===== YOUR DIAMOND =====\n")

    for diamond_number in range(quantity):

        for row_number, line in enumerate(diamond_rows):

            if colour_choice == 8:

                rainbow_codes = list(DIAMOND_COLORS.values())

                colour = rainbow_codes[row_number % len(rainbow_codes)]

            else:

                colour = DIAMOND_COLORS[str(colour_choice)]

            if position == 1:
                spaces = ""

            elif position == 2:
                spaces = " " * 10

            else:
                spaces = " " * 20

            print(spaces + colour + line + RESET)

        if diamond_number < quantity - 1:
            print()


def main():

    while True:

        print("\n====================================")
        print("        SHAPE DRAWING SYSTEM")
        print("====================================")
        print("1. Triangle")
        print("2. Parallelogram")
        print("3. Rectangle")
        print("4. Cross")
        print("5. Diamond")
        print("6. Exit")

        choice = input("Enter your choice (1-6): ").strip()

        if choice == "1":
            triangle()

        elif choice == "2":
            parallelogram()

        elif choice == "3":
            rectangle_menu()

        elif choice == "4":
            cross()

        elif choice == "5":
            diamond()

        elif choice == "6":
            print("Goodbye!")
            break

        else:
            print("Invalid choice. Please enter a number from 1 to 6.")


if __name__ == "__main__":
    main()