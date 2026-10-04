section .data


; TEXT AND MENU

title db 10, "==============================", 10
      db "       TRIANGLE GENERATOR", 10
      db "==============================", 10
title_len equ $ - title

design_menu db 10, "Choose a triangle design:", 10
            db "1. Solid Triangle", 10
            db "2. Hollow Triangle", 10
            db "3. Inverted Solid Triangle", 10
            db "4. Inverted Hollow Triangle", 10
            db "5. Layered Striped Triangle", 10

design_menu_len equ $ - design_menu

design_prompt db "Enter design (1-5): "
design_prompt_len equ $ - design_prompt

size_prompt db 10, "Enter triangle size (1-20): "
size_prompt_len equ $ - size_prompt


; COLOUR MENU

color_menu db 10, "Choose a color:", 10
           db "1. Red", 10
           db "2. Green", 10
           db "3. Yellow", 10
           db "4. Blue", 10
           db "5. Purple", 10
           db "6. Cyan", 10
           db "7. White", 10

color_menu_len equ $ - color_menu

color_prompt db "Enter color (1-7): "
color_prompt_len equ $ - color_prompt

invalid db "Invalid input. Please try again.", 10
invalid_len equ $ - invalid


; BASIC CHARACTERS

newline db 10
space db " "
star db "*"


; ANSI COLOUR CODES

red db 27, "[31m"
red_len equ $ - red

green db 27, "[32m"
green_len equ $ - green

yellow db 27, "[33m"
yellow_len equ $ - yellow

blue db 27, "[34m"
blue_len equ $ - blue

purple db 27, "[35m"
purple_len equ $ - purple

cyan db 27, "[36m"
cyan_len equ $ - cyan

white db 27, "[37m"
white_len equ $ - white

reset db 27, "[0m"
reset_len equ $ - reset


section .bss

; INPUT

input resb 32


section .text

global _main

_main:

; Print title

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel title]
    mov rdx, title_len
    syscall


; Print design menu

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel design_menu]
    mov rdx, design_menu_len
    syscall


; CHOOSE DESIGN

design_input:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel design_prompt]
    mov rdx, design_prompt_len
    syscall

    call read_number

    cmp rax, 1
    jl invalid_design

    cmp rax, 5
    jg invalid_design

    ; r12 = selected design
    mov r12, rax

    jmp choose_size


invalid_design:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel invalid]
    mov rdx, invalid_len
    syscall

    jmp design_input


; CHOOSE SIZE

choose_size:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel size_prompt]
    mov rdx, size_prompt_len
    syscall

    call read_number

    cmp rax, 1
    jl invalid_size

    cmp rax, 20
    jg invalid_size

    ; r13 = triangle size
    mov r13, rax

    ; If design 5, use automatic colours
    cmp r12, 5
    je layered_triangle

    jmp choose_color


invalid_size:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel invalid]
    mov rdx, invalid_len
    syscall

    jmp choose_size


; CHOOSE COLOUR

choose_color:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel color_menu]
    mov rdx, color_menu_len
    syscall


color_input:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel color_prompt]
    mov rdx, color_prompt_len
    syscall

    call read_number

    cmp rax, 1
    jl invalid_color

    cmp rax, 7
    jg invalid_color

    ; r14 = selected colour
    mov r14, rax

    call set_color

    jmp select_design


invalid_color:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel invalid]
    mov rdx, invalid_len
    syscall

    jmp color_input


; SET COLOUR

set_color:

    cmp r14, 1
    je color_red

    cmp r14, 2
    je color_green

    cmp r14, 3
    je color_yellow

    cmp r14, 4
    je color_blue

    cmp r14, 5
    je color_purple

    cmp r14, 6
    je color_cyan

    jmp color_white


color_red:

    lea rsi, [rel red]
    mov rdx, red_len
    jmp print_color


color_green:

    lea rsi, [rel green]
    mov rdx, green_len
    jmp print_color


color_yellow:

    lea rsi, [rel yellow]
    mov rdx, yellow_len
    jmp print_color


color_blue:

    lea rsi, [rel blue]
    mov rdx, blue_len
    jmp print_color


color_purple:

    lea rsi, [rel purple]
    mov rdx, purple_len
    jmp print_color


color_cyan:

    lea rsi, [rel cyan]
    mov rdx, cyan_len
    jmp print_color


color_white:

    lea rsi, [rel white]
    mov rdx, white_len


print_color:

    mov rax, 0x2000004
    mov rdi, 1
    syscall

    ret


; SELECT DESIGN

select_design:

    cmp r12, 1
    je solid_triangle

    cmp r12, 2
    je hollow_triangle

    cmp r12, 3
    je inverted_solid

    cmp r12, 4
    je inverted_hollow

    jmp layered_triangle


; DESIGN 1 SOLID TRIANGLE

solid_triangle:

    mov r15, 1


solid_row:

    cmp r15, r13
    jg finish_shape

    ; spaces = size - row

    mov r8, r13
    sub r8, r15


solid_spaces:

    cmp r8, 0
    je solid_star_count

    call print_space

    dec r8
    jmp solid_spaces


solid_star_count:

    ; stars = (2 × row) - 1

    mov r9, r15
    imul r9, 2
    sub r9, 1


solid_stars:

    cmp r9, 0
    je solid_newline

    call print_star

    dec r9
    jmp solid_stars


solid_newline:

    call print_newline

    inc r15

    jmp solid_row


; DESIGN 2 HOLLOW TRIANGLE

hollow_triangle:

    mov r15, 1


hollow_row:

    cmp r15, r13
    jg finish_shape

    mov r8, r13
    sub r8, r15


hollow_spaces:

    cmp r8, 0
    je hollow_positions

    call print_space

    dec r8
    jmp hollow_spaces


hollow_positions:

    mov r9, r15
    imul r9, 2
    sub r9, 1

    mov r10, 1


hollow_loop:

    cmp r10, r9
    jg hollow_newline


    ; First position
    cmp r10, 1
    je hollow_star


    ; Last row
    cmp r15, r13
    je hollow_star


    ; Last position
    cmp r10, r9
    je hollow_star


    call print_space

    jmp hollow_next


hollow_star:

    call print_star


hollow_next:

    inc r10

    jmp hollow_loop


hollow_newline:

    call print_newline

    inc r15

    jmp hollow_row


; DESIGN 3 INVERTED SOLID TRIANGLE

inverted_solid:

    ; Start at the largest row
    mov r15, r13


inverted_solid_row:

    cmp r15, 0
    je finish_shape

    mov r8, r13
    sub r8, r15


inverted_solid_spaces:

    cmp r8, 0
    je inverted_solid_stars

    call print_space

    dec r8

    jmp inverted_solid_spaces


inverted_solid_stars:

    mov r9, r15
    imul r9, 2
    sub r9, 1


inverted_solid_star_loop:

    cmp r9, 0
    je inverted_solid_newline

    call print_star

    dec r9

    jmp inverted_solid_star_loop


inverted_solid_newline:

    call print_newline

    dec r15

    jmp inverted_solid_row


; DESIGN 4 INVERTED HOLLOW TRIANGLE

inverted_hollow:

    mov r15, r13


inverted_hollow_row:

    cmp r15, 0
    je finish_shape

    mov r8, r13
    sub r8, r15


inverted_hollow_spaces:

    cmp r8, 0
    je inverted_hollow_positions

    call print_space

    dec r8

    jmp inverted_hollow_spaces


inverted_hollow_positions:

    mov r9, r15
    imul r9, 2
    sub r9, 1

    mov r10, 1


inverted_hollow_loop:

    cmp r10, r9
    jg inverted_hollow_newline


    ; First position
    cmp r10, 1
    je inverted_hollow_star


    ; Last row
    cmp r15, 1
    je inverted_hollow_star


    ; Last position
    cmp r10, r9
    je inverted_hollow_star


    call print_space

    jmp inverted_hollow_next


inverted_hollow_star:

    call print_star


inverted_hollow_next:

    inc r10

    jmp inverted_hollow_loop


inverted_hollow_newline:

    call print_newline

    dec r15

    jmp inverted_hollow_row


; DESIGN 5 STRIPED TRIANGLE

layered_triangle:

    mov r15, 1


layered_row:

    cmp r15, r13
    jg finish_shape


    ; Calculate colour for this row

    mov rax, r15
    dec rax

    xor rdx, rdx

    mov rcx, 7

    div rcx

    mov r14, rdx

    inc r14


    ; Print the colour for this layer

    call set_color


    mov r8, r13
    sub r8, r15


layered_spaces:

    cmp r8, 0
    je layered_star_count

    call print_space

    dec r8

    jmp layered_spaces


layered_star_count:

    mov r9, r15
    imul r9, 2
    sub r9, 1


layered_stars:

    cmp r9, 0
    je layered_newline

    call print_star

    dec r9

    jmp layered_stars


layered_newline:

    call print_newline

    inc r15

    jmp layered_row


; FINISH SHAPE

finish_shape:

    ; Reset terminal colour

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel reset]
    mov rdx, reset_len
    syscall

    call print_newline

    jmp program_exit


; PRINT ONE SPACE

print_space:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel space]
    mov rdx, 1
    syscall

    ret


; PRINT ONE STAR

print_star:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel star]
    mov rdx, 1
    syscall

    ret


; PRINT NEWLINE

print_newline:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel newline]
    mov rdx, 1
    syscall

    ret


; READ NUMBER

read_number:

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel input]
    mov rdx, 32
    syscall


    ; Start reading characters

    lea rsi, [rel input]

    xor rax, rax


read_loop:


    movzx rcx, byte [rsi]


    cmp rcx, 10
    je read_done

    cmp rcx, 13
    je read_done

    cmp rcx, 0
    je read_done

    cmp rcx, '0'
    jl read_done

    cmp rcx, '9'
    jg read_done


    sub rcx, '0'

    imul rax, rax, 10

    add rax, rcx

    inc rsi

    jmp read_loop


read_done:

    ret


; EXIT PROGRAM

program_exit:

    mov rax, 0x2000001
    mov rdi, 0
    syscall
