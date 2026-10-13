def rec_menu():

    while True:
        print("===== Rectangle Generator =====\n")
        print("1- Continue")
        print("2- Return")
        menu_option = input("Enter your option (1-2): ").strip()
        if menu_option == '1':
            rec_quantity, rec_height, rec_width, rec_shape, rec_alignment ,rec_symbol, rec_color = cust()
            generate_rec(rec_quantity, rec_height, rec_width, rec_shape, rec_alignment ,rec_symbol, rec_color)
        elif menu_option == '2':
            break
        else:
            print("Invalid option.")

def cust():


    while True:
        rec_quantity = input("Enter quantity (1-9): ").strip()
        if rec_quantity.isdigit():
            rec_quantity = int(rec_quantity)
            if 1 <= rec_quantity <= 9:
                break
            else:
                print("Invalid option.")
        else:
            print("Invalid option.")


    while True:
        rec_height= input("Enter height (2-25): ").strip()
        if rec_height.isdigit():
            rec_height = int(rec_height)
            if 2 <= rec_height <= 25:
                break
            else:
                print("Invalid option.")
        else:
            print("Invalid option.")


    while True:
        rec_width = input("Enter width (2-50): ").strip()
        if rec_width.isdigit():
            rec_width = int(rec_width)
            if 2 <= rec_width <= 50:
                break
            else:
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
        rec_symbol= input("Enter your preferred symbol/character to draw in :").strip()
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
    return


rec_menu() # remove and add to main menu option when calling rectangle options