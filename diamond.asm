section .data

    ; TITLE
    

    message db 'Diamond Generator', 10
    message_len equ $ - message


    
    ; SYMBOL MENU
    

    symbol_prompt db 'Choose symbol:', 10
                   db '1. *', 10
                   db '2. #', 10
                   db '3. @', 10
                   db '4. $', 10
                   db '5. &', 10
                   db 'Enter choice (1-5): '

    symbol_prompt_len equ $ - symbol_prompt

    invalid_symbol_msg db 'Invalid symbol choice!', 10
    invalid_symbol_len equ $ - invalid_symbol_msg


    
    ; STYLE MENU
    

    style_prompt db 10
                  db 'Choose diamond style:', 10
                  db '1. Filled', 10
                  db '2. Hollow', 10
                  db 'Enter choice (1-2): '

    style_prompt_len equ $ - style_prompt

    invalid_style_msg db 'Invalid style choice!', 10
    invalid_style_len equ $ - invalid_style_msg


    
    ; COLOUR MENU
    

    colour_prompt db 10
                   db 'Choose colour:', 10
                   db '1. Red', 10
                   db '2. Green', 10
                   db '3. Yellow', 10
                   db '4. Blue', 10
                   db '5. Purple', 10
                   db '6. Cyan', 10
                   db '7. White', 10
                   db '8. Rainbow', 10
                   db 'Enter choice (1-8): '

    colour_prompt_len equ $ - colour_prompt

    invalid_colour_msg db 'Invalid colour choice!', 10
    invalid_colour_len equ $ - invalid_colour_msg


   
    ; POSITION MENU
   

    position_prompt db 10
                     db 'Choose position:', 10
                     db '1. Left', 10
                     db '2. Centre', 10
                     db '3. Right', 10
                     db 'Enter choice (1-3): '

    position_prompt_len equ $ - position_prompt

    invalid_position_msg db 'Invalid position choice!', 10
    invalid_position_len equ $ - invalid_position_msg


  
    ; QUANTITY MENU
    

    quantity_prompt db 10
                     db 'Choose quantity:', 10
                     db '1. 1 Diamond', 10
                     db '2. 2 Diamonds', 10
                     db '3. 3 Diamonds', 10
                     db '4. 4 Diamonds', 10
                     db '5. 5 Diamonds', 10
                     db 'Enter choice (1-5): '

    quantity_prompt_len equ $ - quantity_prompt

    invalid_quantity_msg db 'Invalid quantity choice!', 10
    invalid_quantity_len equ $ - invalid_quantity_msg


   
    ; SIZE MENU
    

    prompt db 10, 'Enter diamond size (1-9): '
    prompt_len equ $ - prompt

    invalid_msg db 'Invalid size! Please enter 1-9.', 10
    invalid_len equ $ - invalid_msg


    
    ;  COLOURS
     

    red db 27, '[31m'
    red_len equ $ - red

    green db 27, '[32m'
    green_len equ $ - green

    yellow db 27, '[33m'
    yellow_len equ $ - yellow

    blue db 27, '[34m'
    blue_len equ $ - blue

    purple db 27, '[35m'
    purple_len equ $ - purple

    cyan db 27, '[36m'
    cyan_len equ $ - cyan

    white db 27, '[37m'
    white_len equ $ - white

    reset db 27, '[0m'
    reset_len equ $ - reset


    
    ; OTHER CHARACTERS
    

    space db ' '
    newline db 10


section .bss

    
    ; INPUT VARIABLES
    

    input resb 2
    symbol_input resb 2
    style_input resb 2
    colour_input resb 2
    position_input resb 2
    quantity_input resb 2


    
    ; PROGRAM VARIABLES
    

    size resb 1
    symbol resb 1
    style resb 1
    colour resb 1
    position resb 1
    quantity resb 1

    row resb 1
    spaces resb 1
    stars resb 1
    column resb 1
    position_spaces resb 1

    ; Used by Rainbow
    rainbow_colour resb 1


section .text

    global _start


_start:

    
    ; PRINT TITLE
    

    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, message_len
    int 0x80


   
    ; SYMBOL MENU


    mov eax, 4
    mov ebx, 1
    mov ecx, symbol_prompt
    mov edx, symbol_prompt_len
    int 0x80


    
    ; READ SYMBOL
   

    mov eax, 3
    mov ebx, 0
    mov ecx, symbol_input
    mov edx, 2
    int 0x80

    mov al, [symbol_input]
    sub al, '0'


   ; SELECT SYMBOL
   

    cmp al, 1
    je choose_star

    cmp al, 2
    je choose_hash

    cmp al, 3
    je choose_at

    cmp al, 4
    je choose_dollar

    cmp al, 5
    je choose_ampersand

    jmp invalid_symbol


choose_star:

    mov byte [symbol], '*'
    jmp symbol_done


choose_hash:

    mov byte [symbol], '#'
    jmp symbol_done


choose_at:

    mov byte [symbol], '@'
    jmp symbol_done


choose_dollar:

    mov byte [symbol], '$'
    jmp symbol_done


choose_ampersand:

    mov byte [symbol], '&'


symbol_done:


   
    ; STYLE MENU
    

    mov eax, 4
    mov ebx, 1
    mov ecx, style_prompt
    mov edx, style_prompt_len
    int 0x80


    
    ; READ STYLE
  

    mov eax, 3
    mov ebx, 0
    mov ecx, style_input
    mov edx, 2
    int 0x80

    mov al, [style_input]
    sub al, '0'


   ; SELECT STYLE

    cmp al, 1
    je choose_filled

    cmp al, 2
    je choose_hollow

    jmp invalid_style


choose_filled:

    mov byte [style], 1
    jmp style_done


choose_hollow:

    mov byte [style], 2


style_done:


   ; COLOUR MENU

    mov eax, 4
    mov ebx, 1
    mov ecx, colour_prompt
    mov edx, colour_prompt_len
    int 0x80


   
    ; READ COLOUR
   

    mov eax, 3
    mov ebx, 0
    mov ecx, colour_input
    mov edx, 2
    int 0x80

    mov al, [colour_input]
    sub al, '0'


 
    ; SELECT COLOUR
    

    cmp al, 1
    je choose_red

    cmp al, 2
    je choose_green

    cmp al, 3
    je choose_yellow

    cmp al, 4
    je choose_blue

    cmp al, 5
    je choose_purple

    cmp al, 6
    je choose_cyan

    cmp al, 7
    je choose_white

    cmp al, 8
    je choose_rainbow

    jmp invalid_colour


choose_red:

    mov byte [colour], 1
    jmp colour_done


choose_green:

    mov byte [colour], 2
    jmp colour_done


choose_yellow:

    mov byte [colour], 3
    jmp colour_done


choose_blue:

    mov byte [colour], 4
    jmp colour_done


choose_purple:

    mov byte [colour], 5
    jmp colour_done


choose_cyan:

    mov byte [colour], 6
    jmp colour_done


choose_white:

    mov byte [colour], 7
    jmp colour_done


choose_rainbow:

    mov byte [colour], 8


colour_done:


   
    ; POSITION MENU
    

    mov eax, 4
    mov ebx, 1
    mov ecx, position_prompt
    mov edx, position_prompt_len
    int 0x80


   ; READ POSITION
 

    mov eax, 3
    mov ebx, 0
    mov ecx, position_input
    mov edx, 2
    int 0x80

    mov al, [position_input]
    sub al, '0'


   ; SELECT POSITION
    

    cmp al, 1
    je choose_left

    cmp al, 2
    je choose_centre

    cmp al, 3
    je choose_right

    jmp invalid_position


choose_left:

    mov byte [position], 1
    jmp position_done


choose_centre:

    mov byte [position], 2
    jmp position_done


choose_right:

    mov byte [position], 3


position_done:


   ; QUANTITY MENU
   

    mov eax, 4
    mov ebx, 1
    mov ecx, quantity_prompt
    mov edx, quantity_prompt_len
    int 0x80


   ; READ QUANTITY

    mov eax, 3
    mov ebx, 0
    mov ecx, quantity_input
    mov edx, 2
    int 0x80

    mov al, [quantity_input]
    sub al, '0'


   ; VALIDATE QUANTITY
    

    cmp al, 1
    jl invalid_quantity

    cmp al, 5
    jg invalid_quantity

    mov [quantity], al


    
    ; SIZE MENU

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, prompt_len
    int 0x80


    
    ; READ SIZE
 

    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 2
    int 0x80

    mov al, [input]
    sub al, '0'
    mov [size], al


    
    ; VALIDATE SIZE
    

    cmp al, 1
    jl invalid

    cmp al, 9
    jg invalid


   
    ; SET INITIAL COLOUR
    

    cmp byte [colour], 8
    je start_rainbow

    cmp byte [colour], 1
    je set_red

    cmp byte [colour], 2
    je set_green

    cmp byte [colour], 3
    je set_yellow

    cmp byte [colour], 4
    je set_blue

    cmp byte [colour], 5
    je set_purple

    cmp byte [colour], 6
    je set_cyan

    cmp byte [colour], 7
    je set_white


set_red:

    mov eax, 4
    mov ebx, 1
    mov ecx, red
    mov edx, red_len
    int 0x80

    jmp colour_set


set_green:

    mov eax, 4
    mov ebx, 1
    mov ecx, green
    mov edx, green_len
    int 0x80

    jmp colour_set


set_yellow:

    mov eax, 4
    mov ebx, 1
    mov ecx, yellow
    mov edx, yellow_len
    int 0x80

    jmp colour_set


set_blue:

    mov eax, 4
    mov ebx, 1
    mov ecx, blue
    mov edx, blue_len
    int 0x80

    jmp colour_set


set_purple:

    mov eax, 4
    mov ebx, 1
    mov ecx, purple
    mov edx, purple_len
    int 0x80

    jmp colour_set


set_cyan:

    mov eax, 4
    mov ebx, 1
    mov ecx, cyan
    mov edx, cyan_len
    int 0x80

    jmp colour_set


set_white:

    mov eax, 4
    mov ebx, 1
    mov ecx, white
    mov edx, white_len
    int 0x80

    jmp colour_set


start_rainbow:

    ; Rainbow starts with red
    mov byte [rainbow_colour], 1


colour_set:


   ; SET POSITION
  

    cmp byte [position], 1
    je position_left

    cmp byte [position], 2
    je position_centre

    cmp byte [position], 3
    je position_right


position_left:

    mov byte [position_spaces], 0
    jmp position_ready


position_centre:

    mov byte [position_spaces], 8
    jmp position_ready


position_right:

    mov byte [position_spaces], 16


position_ready:


    
    ; QUANTITY LOOP
    
quantity_loop:

    ; For Rainbow, start each diamond
    ; from red again

    cmp byte [colour], 8
    jne normal_colour_start

    mov byte [rainbow_colour], 1


normal_colour_start:

   ; START TOP HALF
    

    mov byte [row], 1


top_row:

    
    ; RAINBOW COLOUR FOR THIS ROW
    

    cmp byte [colour], 8
    jne top_colour_done

    call set_rainbow_colour


top_colour_done:


    
    ; CALCULATE SPACES
    

    mov al, [size]
    sub al, [row]
    mov [spaces], al


    
    ; CALCULATE SYMBOL COUNT
    

    mov al, [row]
    add al, [row]
    sub al, 1
    mov [stars], al


    
    ; POSITION SPACES
    

print_position_top:

    cmp byte [position_spaces], 0
    je print_shape_spaces_top

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    dec byte [position_spaces]

    jmp print_position_top


    
    ; DIAMOND SPACES
    

print_shape_spaces_top:

    cmp byte [spaces], 0
    je start_symbols_top

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    dec byte [spaces]

    jmp print_shape_spaces_top


    
    ; PRINT TOP SYMBOLS
   

start_symbols_top:

    mov byte [column], 1


print_symbols_top:

    mov al, [column]
    cmp al, [stars]
    jg next_top_row


    ; Filled style

    cmp byte [style], 1
    je print_symbol_top


    ; Hollow - first symbol

    cmp byte [column], 1
    je print_symbol_top


    ; Hollow - last symbol

    mov al, [column]
    cmp al, [stars]
    je print_symbol_top


    ; Hollow - middle

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    jmp next_column_top


print_symbol_top:

    mov eax, 4
    mov ebx, 1
    mov ecx, symbol
    mov edx, 1
    int 0x80


next_column_top:

    inc byte [column]

    jmp print_symbols_top


    
    ; NEXT TOP ROW
    

next_top_row:

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


    
    ; UPDATE RAINBOW COLOUR
   

    cmp byte [colour], 8
    jne no_rainbow_top

    inc byte [rainbow_colour]

    cmp byte [rainbow_colour], 8
    jl no_rainbow_top

    mov byte [rainbow_colour], 1


no_rainbow_top:


    ; RESET POSITION
    

    cmp byte [position], 1
    je reset_left_top

    cmp byte [position], 2
    je reset_centre_top

    mov byte [position_spaces], 16

    jmp continue_top


reset_left_top:

    mov byte [position_spaces], 0

    jmp continue_top


reset_centre_top:

    mov byte [position_spaces], 8


continue_top:

    inc byte [row]

    mov al, [row]
    cmp al, [size]

    jle top_row


    
    ; START BOTTOM HALF
    

    mov al, [size]
    dec al
    mov [row], al


bottom_row:

    cmp byte [row], 0
    je diamond_finished

    ; RAINBOW COLOUR FOR BOTTOM ROW
    

    cmp byte [colour], 8
    jne bottom_colour_done

    call set_rainbow_colour


bottom_colour_done:


   ; CALCULATE SPACES
    

    mov al, [size]
    sub al, [row]
    mov [spaces], al


   ; CALCULATE SYMBOL COUNT
    

    mov al, [row]
    add al, [row]
    sub al, 1
    mov [stars], al


   ; POSITION SPACES
    

print_position_bottom:

    cmp byte [position_spaces], 0
    je print_shape_spaces_bottom

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    dec byte [position_spaces]

    jmp print_position_bottom


   ; DIAMOND SPACES
    

print_shape_spaces_bottom:

    cmp byte [spaces], 0
    je start_symbols_bottom

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    dec byte [spaces]

    jmp print_shape_spaces_bottom


    ; PRINT BOTTOM SYMBOLS
    

start_symbols_bottom:

    mov byte [column], 1


print_symbols_bottom:

    mov al, [column]
    cmp al, [stars]
    jg next_bottom_row


    ; Filled style

    cmp byte [style], 1
    je print_symbol_bottom


    ; Hollow - first symbol

    cmp byte [column], 1
    je print_symbol_bottom


    ; Hollow - last symbol

    mov al, [column]
    cmp al, [stars]
    je print_symbol_bottom


    ; Hollow - middle

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    jmp next_column_bottom


print_symbol_bottom:

    mov eax, 4
    mov ebx, 1
    mov ecx, symbol
    mov edx, 1
    int 0x80


next_column_bottom:

    inc byte [column]

    jmp print_symbols_bottom


   ; NEXT BOTTOM ROW
    

next_bottom_row:

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


    ; UPDATE RAINBOW COLOUR
    

    cmp byte [colour], 8
    jne no_rainbow_bottom

    inc byte [rainbow_colour]

    cmp byte [rainbow_colour], 8
    jl no_rainbow_bottom

    mov byte [rainbow_colour], 1


no_rainbow_bottom:


    
    ; RESET POSITION
    

    cmp byte [position], 1
    je reset_left_bottom

    cmp byte [position], 2
    je reset_centre_bottom

    mov byte [position_spaces], 16

    jmp continue_bottom


reset_left_bottom:

    mov byte [position_spaces], 0

    jmp continue_bottom


reset_centre_bottom:

    mov byte [position_spaces], 8


continue_bottom:

    dec byte [row]

    jmp bottom_row


    ; ONE DIAMOND FINISHED
    

diamond_finished:

    dec byte [quantity]

    cmp byte [quantity], 0
    je reset_colour


    ; Blank line between diamonds

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


    ; Reset position spaces

    cmp byte [position], 1
    je reset_quantity_left

    cmp byte [position], 2
    je reset_quantity_centre

    mov byte [position_spaces], 16

    jmp quantity_loop


reset_quantity_left:

    mov byte [position_spaces], 0

    jmp quantity_loop


reset_quantity_centre:

    mov byte [position_spaces], 8

    jmp quantity_loop


   ; RAINBOW COLOUR PROCEDURE
   

set_rainbow_colour:

    cmp byte [rainbow_colour], 1
    je rainbow_red

    cmp byte [rainbow_colour], 2
    je rainbow_green

    cmp byte [rainbow_colour], 3
    je rainbow_yellow

    cmp byte [rainbow_colour], 4
    je rainbow_blue

    cmp byte [rainbow_colour], 5
    je rainbow_purple

    cmp byte [rainbow_colour], 6
    je rainbow_cyan

    cmp byte [rainbow_colour], 7
    je rainbow_white

    ret


rainbow_red:

    mov eax, 4
    mov ebx, 1
    mov ecx, red
    mov edx, red_len
    int 0x80

    ret


rainbow_green:

    mov eax, 4
    mov ebx, 1
    mov ecx, green
    mov edx, green_len
    int 0x80

    ret


rainbow_yellow:

    mov eax, 4
    mov ebx, 1
    mov ecx, yellow
    mov edx, yellow_len
    int 0x80

    ret


rainbow_blue:

    mov eax, 4
    mov ebx, 1
    mov ecx, blue
    mov edx, blue_len
    int 0x80

    ret


rainbow_purple:

    mov eax, 4
    mov ebx, 1
    mov ecx, purple
    mov edx, purple_len
    int 0x80

    ret


rainbow_cyan:

    mov eax, 4
    mov ebx, 1
    mov ecx, cyan
    mov edx, 1
    int 0x80

    ret


rainbow_white:

    mov eax, 4
    mov ebx, 1
    mov ecx, white
    mov edx, white_len
    int 0x80

    ret


    ; RESET TERMINAL COLOUR
    
reset_colour:

    mov eax, 4
    mov ebx, 1
    mov ecx, reset
    mov edx, reset_len
    int 0x80

    jmp exit


    
    ; INVALID SYMBOL
    

invalid_symbol:

    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_symbol_msg
    mov edx, invalid_symbol_len
    int 0x80

    jmp exit


    
    ; INVALID STYLE
    
invalid_style:

    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_style_msg
    mov edx, invalid_style_len
    int 0x80

    jmp exit


   ; INVALID COLOUR
    

invalid_colour:

    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_colour_msg
    mov edx, invalid_colour_len
    int 0x80

    jmp exit


    ; INVALID POSITION
    

invalid_position:

    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_position_msg
    mov edx, invalid_position_len
    int 0x80

    jmp exit


  ; INVALID QUANTITY
    

invalid_quantity:

    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_quantity_msg
    mov edx, invalid_quantity_len
    int 0x80

    jmp exit


    ; INVALID SIZE
    

invalid:

    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_msg
    mov edx, invalid_len
    int 0x80

    jmp exit

   ; EXIT PROGRAM
    
exit:

    mov eax, 1
    mov ebx, 0
    int 0x80
