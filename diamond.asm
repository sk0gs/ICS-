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

    global _main


_main:


    ; PRINT TITLE

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel message]
    mov rdx, message_len
    syscall


    ; SYMBOL MENU

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel symbol_prompt]
    mov rdx, symbol_prompt_len
    syscall


    ; READ SYMBOL

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel symbol_input]
    mov rdx, 2
    syscall

    mov al, [rel symbol_input]
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

    mov byte [rel symbol], '*'
    jmp symbol_done


choose_hash:

    mov byte [rel symbol], '#'
    jmp symbol_done


choose_at:

    mov byte [rel symbol], '@'
    jmp symbol_done


choose_dollar:

    mov byte [rel symbol], '$'
    jmp symbol_done


choose_ampersand:

    mov byte [rel symbol], '&'


symbol_done:


   ; STYLE MENU

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel style_prompt]
    mov rdx, style_prompt_len
    syscall


    ; READ STYLE

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel style_input]
    mov rdx, 2
    syscall

    mov al, [rel style_input]
    sub al, '0'


   ; SELECT STYLE

    cmp al, 1
    je choose_filled

    cmp al, 2
    je choose_hollow

    jmp invalid_style


choose_filled:

    mov byte [rel style], 1
    jmp style_done


choose_hollow:

    mov byte [rel style], 2


style_done:


   ; COLOUR MENU

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel colour_prompt]
    mov rdx, colour_prompt_len
    syscall


   ; READ COLOUR

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel colour_input]
    mov rdx, 2
    syscall

    mov al, [rel colour_input]
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

    mov byte [rel colour], 1
    jmp colour_done


choose_green:

    mov byte [rel colour], 2
    jmp colour_done


choose_yellow:

    mov byte [rel colour], 3
    jmp colour_done


choose_blue:

    mov byte [rel colour], 4
    jmp colour_done


choose_purple:

    mov byte [rel colour], 5
    jmp colour_done


choose_cyan:

    mov byte [rel colour], 6
    jmp colour_done


choose_white:

    mov byte [rel colour], 7
    jmp colour_done


choose_rainbow:

    mov byte [rel colour], 8


colour_done:


   ; POSITION MENU

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel position_prompt]
    mov rdx, position_prompt_len
    syscall


   ; READ POSITION

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel position_input]
    mov rdx, 2
    syscall

    mov al, [rel position_input]
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

    mov byte [rel position], 1
    jmp position_done


choose_centre:

    mov byte [rel position], 2
    jmp position_done


choose_right:

    mov byte [rel position], 3


position_done:


   ; QUANTITY MENU

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel quantity_prompt]
    mov rdx, quantity_prompt_len
    syscall


   ; READ QUANTITY

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel quantity_input]
    mov rdx, 2
    syscall

    mov al, [rel quantity_input]
    sub al, '0'


   ; VALIDATE QUANTITY

    cmp al, 1
    jl invalid_quantity

    cmp al, 5
    jg invalid_quantity

    mov [rel quantity], al


    ; SIZE MENU

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel prompt]
    mov rdx, prompt_len
    syscall


    ; READ SIZE

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel input]
    mov rdx, 2
    syscall

    mov al, [rel input]
    sub al, '0'
    mov [rel size], al


    ; VALIDATE SIZE

    cmp al, 1
    jl invalid

    cmp al, 9
    jg invalid


   ; SET INITIAL COLOUR

    cmp byte [rel colour], 8
    je start_rainbow

    cmp byte [rel colour], 1
    je set_red

    cmp byte [rel colour], 2
    je set_green

    cmp byte [rel colour], 3
    je set_yellow

    cmp byte [rel colour], 4
    je set_blue

    cmp byte [rel colour], 5
    je set_purple

    cmp byte [rel colour], 6
    je set_cyan

    cmp byte [rel colour], 7
    je set_white


set_red:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel red]
    mov rdx, red_len
    syscall

    jmp colour_set


set_green:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel green]
    mov rdx, green_len
    syscall

    jmp colour_set


set_yellow:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel yellow]
    mov rdx, yellow_len
    syscall

    jmp colour_set


set_blue:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel blue]
    mov rdx, blue_len
    syscall

    jmp colour_set


set_purple:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel purple]
    mov rdx, purple_len
    syscall

    jmp colour_set


set_cyan:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel cyan]
    mov rdx, cyan_len
    syscall

    jmp colour_set


set_white:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel white]
    mov rdx, white_len
    syscall

    jmp colour_set


start_rainbow:

    ; Rainbow starts with red
    mov byte [rel rainbow_colour], 1


colour_set:


   ; SET POSITION

    cmp byte [rel position], 1
    je position_left

    cmp byte [rel position], 2
    je position_centre

    cmp byte [rel position], 3
    je position_right


position_left:

    mov byte [rel position_spaces], 0
    jmp position_ready


position_centre:

    mov byte [rel position_spaces], 8
    jmp position_ready


position_right:

    mov byte [rel position_spaces], 16


position_ready:


    ; QUANTITY LOOP

quantity_loop:

    ; For Rainbow, start each diamond
    ; from red again

    cmp byte [rel colour], 8
    jne normal_colour_start

    mov byte [rel rainbow_colour], 1


normal_colour_start:

   ; START TOP HALF

    mov byte [rel row], 1


top_row:


    ; RAINBOW COLOUR FOR THIS ROW

    cmp byte [rel colour], 8
    jne top_colour_done

    call set_rainbow_colour


top_colour_done:


    ; CALCULATE SPACES

    mov al, [rel size]
    sub al, [rel row]
    mov [rel spaces], al


    ; CALCULATE SYMBOL COUNT

    mov al, [rel row]
    add al, [rel row]
    sub al, 1
    mov [rel stars], al


    ; POSITION SPACES

print_position_top:

    cmp byte [rel position_spaces], 0
    je print_shape_spaces_top

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel space]
    mov rdx, 1
    syscall

    dec byte [rel position_spaces]

    jmp print_position_top


    ; DIAMOND SPACES

print_shape_spaces_top:

    cmp byte [rel spaces], 0
    je start_symbols_top

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel space]
    mov rdx, 1
    syscall

    dec byte [rel spaces]

    jmp print_shape_spaces_top


    ; PRINT TOP SYMBOLS

start_symbols_top:

    mov byte [rel column], 1


print_symbols_top:

    mov al, [rel column]
    cmp al, [rel stars]
    jg next_top_row


    ; Filled style

    cmp byte [rel style], 1
    je print_symbol_top


    ; Hollow - first symbol

    cmp byte [rel column], 1
    je print_symbol_top


    ; Hollow - last symbol

    mov al, [rel column]
    cmp al, [rel stars]
    je print_symbol_top


    ; Hollow - middle

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel space]
    mov rdx, 1
    syscall

    jmp next_column_top


print_symbol_top:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel symbol]
    mov rdx, 1
    syscall


next_column_top:

    inc byte [rel column]

    jmp print_symbols_top


    ; NEXT TOP ROW

next_top_row:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel newline]
    mov rdx, 1
    syscall


    ; UPDATE RAINBOW COLOUR

    cmp byte [rel colour], 8
    jne no_rainbow_top

    inc byte [rel rainbow_colour]

    cmp byte [rel rainbow_colour], 8
    jl no_rainbow_top

    mov byte [rel rainbow_colour], 1


no_rainbow_top:


    ; RESET POSITION

    cmp byte [rel position], 1
    je reset_left_top

    cmp byte [rel position], 2
    je reset_centre_top

    mov byte [rel position_spaces], 16

    jmp continue_top


reset_left_top:

    mov byte [rel position_spaces], 0

    jmp continue_top


reset_centre_top:

    mov byte [rel position_spaces], 8


continue_top:

    inc byte [rel row]

    mov al, [rel row]
    cmp al, [rel size]

    jle top_row


    ; START BOTTOM HALF

    mov al, [rel size]
    dec al
    mov [rel row], al


bottom_row:

    cmp byte [rel row], 0
    je diamond_finished

    ; RAINBOW COLOUR FOR BOTTOM ROW

    cmp byte [rel colour], 8
    jne bottom_colour_done

    call set_rainbow_colour


bottom_colour_done:


   ; CALCULATE SPACES

    mov al, [rel size]
    sub al, [rel row]
    mov [rel spaces], al


   ; CALCULATE SYMBOL COUNT

    mov al, [rel row]
    add al, [rel row]
    sub al, 1
    mov [rel stars], al


   ; POSITION SPACES

print_position_bottom:

    cmp byte [rel position_spaces], 0
    je print_shape_spaces_bottom

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel space]
    mov rdx, 1
    syscall

    dec byte [rel position_spaces]

    jmp print_position_bottom


   ; DIAMOND SPACES

print_shape_spaces_bottom:

    cmp byte [rel spaces], 0
    je start_symbols_bottom

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel space]
    mov rdx, 1
    syscall

    dec byte [rel spaces]

    jmp print_shape_spaces_bottom


    ; PRINT BOTTOM SYMBOLS

start_symbols_bottom:

    mov byte [rel column], 1


print_symbols_bottom:

    mov al, [rel column]
    cmp al, [rel stars]
    jg next_bottom_row


    ; Filled style

    cmp byte [rel style], 1
    je print_symbol_bottom


    ; Hollow - first symbol

    cmp byte [rel column], 1
    je print_symbol_bottom


    ; Hollow - last symbol

    mov al, [rel column]
    cmp al, [rel stars]
    je print_symbol_bottom


    ; Hollow - middle

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel space]
    mov rdx, 1
    syscall

    jmp next_column_bottom


print_symbol_bottom:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel symbol]
    mov rdx, 1
    syscall


next_column_bottom:

    inc byte [rel column]

    jmp print_symbols_bottom


   ; NEXT BOTTOM ROW

next_bottom_row:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel newline]
    mov rdx, 1
    syscall


    ; UPDATE RAINBOW COLOUR

    cmp byte [rel colour], 8
    jne no_rainbow_bottom

    inc byte [rel rainbow_colour]

    cmp byte [rel rainbow_colour], 8
    jl no_rainbow_bottom

    mov byte [rel rainbow_colour], 1


no_rainbow_bottom:


    ; RESET POSITION

    cmp byte [rel position], 1
    je reset_left_bottom

    cmp byte [rel position], 2
    je reset_centre_bottom

    mov byte [rel position_spaces], 16

    jmp continue_bottom


reset_left_bottom:

    mov byte [rel position_spaces], 0

    jmp continue_bottom


reset_centre_bottom:

    mov byte [rel position_spaces], 8


continue_bottom:

    dec byte [rel row]

    jmp bottom_row


    ; ONE DIAMOND FINISHED

diamond_finished:

    dec byte [rel quantity]

    cmp byte [rel quantity], 0
    je reset_colour


    ; Blank line between diamonds

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel newline]
    mov rdx, 1
    syscall


    ; Reset position spaces

    cmp byte [rel position], 1
    je reset_quantity_left

    cmp byte [rel position], 2
    je reset_quantity_centre

    mov byte [rel position_spaces], 16

    jmp quantity_loop


reset_quantity_left:

    mov byte [rel position_spaces], 0

    jmp quantity_loop


reset_quantity_centre:

    mov byte [rel position_spaces], 8

    jmp quantity_loop


   ; RAINBOW COLOUR PROCEDURE

set_rainbow_colour:

    cmp byte [rel rainbow_colour], 1
    je rainbow_red

    cmp byte [rel rainbow_colour], 2
    je rainbow_green

    cmp byte [rel rainbow_colour], 3
    je rainbow_yellow

    cmp byte [rel rainbow_colour], 4
    je rainbow_blue

    cmp byte [rel rainbow_colour], 5
    je rainbow_purple

    cmp byte [rel rainbow_colour], 6
    je rainbow_cyan

    cmp byte [rel rainbow_colour], 7
    je rainbow_white

    ret


rainbow_red:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel red]
    mov rdx, red_len
    syscall

    ret


rainbow_green:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel green]
    mov rdx, green_len
    syscall

    ret


rainbow_yellow:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel yellow]
    mov rdx, yellow_len
    syscall

    ret


rainbow_blue:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel blue]
    mov rdx, blue_len
    syscall

    ret


rainbow_purple:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel purple]
    mov rdx, purple_len
    syscall

    ret


rainbow_cyan:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel cyan]
    mov rdx, cyan_len
    syscall

    ret


rainbow_white:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel white]
    mov rdx, white_len
    syscall

    ret


    ; RESET TERMINAL COLOUR

reset_colour:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel reset]
    mov rdx, reset_len
    syscall

    jmp exit


    ; INVALID SYMBOL

invalid_symbol:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel invalid_symbol_msg]
    mov rdx, invalid_symbol_len
    syscall

    jmp exit


    ; INVALID STYLE

invalid_style:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel invalid_style_msg]
    mov rdx, invalid_style_len
    syscall

    jmp exit


   ; INVALID COLOUR

invalid_colour:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel invalid_colour_msg]
    mov rdx, invalid_colour_len
    syscall

    jmp exit


    ; INVALID POSITION

invalid_position:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel invalid_position_msg]
    mov rdx, invalid_position_len
    syscall

    jmp exit


  ; INVALID QUANTITY

invalid_quantity:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel invalid_quantity_msg]
    mov rdx, invalid_quantity_len
    syscall

    jmp exit


    ; INVALID SIZE

invalid:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel invalid_msg]
    mov rdx, invalid_len
    syscall

    jmp exit

   ; EXIT PROGRAM

exit:

    mov rax, 0x2000001
    mov rdi, 0
    syscall
