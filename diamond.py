
# Diamond Generator

COLOURS = {
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


def main():
    print("===== DIAMOND GENERATOR =====")

    # Choose the size
    size = get_number("Enter diamond size (1-9): ", 1, 9)

    # Choose the symbol
    print("\nChoose a symbol:")
    print("1. *")
    print("2. #")
    print("3. @")
    print("4. $")
    print("5. &")

    symbol_choice = get_number("Enter your choice (1-5): ", 1, 5)
    symbols = ["*", "#", "@", "$", "&"]
    symbol = symbols[symbol_choice - 1]

    # Choose filled or hollow
    print("\nChoose a style:")
    print("1. Filled")
    print("2. Hollow")

    style = get_number("Enter your choice (1-2): ", 1, 2)
    style = str(style)

    # Choose a colour
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

    # Choose position
    print("\nChoose a position:")
    print("1. Left")
    print("2. Centre")
    print("3. Right")

    position = get_number("Enter your choice (1-3): ", 1, 3)

    # Choose quantity
    quantity = get_number("\nHow many diamonds (1-5)? ", 1, 5)

    
    diamond_rows = get_diamond(size, symbol, style)

 
    print("\n===== YOUR DIAMOND =====\n")

    for diamond_number in range(quantity):
        for row_number, line in enumerate(diamond_rows):
            
            if colour_choice == 8:
                rainbow_codes = list(COLOURS.values())
                colour = rainbow_codes[row_number % len(rainbow_codes)]
            else:
                colour = COLOURS[str(colour_choice)]

         
            if position == 1:
                spaces = ""
            elif position == 2:
                spaces = " " * 10
            else:
                spaces = " " * 20

            print(spaces + colour + line + RESET)

        if diamond_number < quantity - 1:
            print()


if __name__ == "__main__":
    main()

