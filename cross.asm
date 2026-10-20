section .bss

    input resb 32


section .data

    menu db 10
         db "========== SHAPE DRAWER ==========", 10
         db "1. Cross", 10
         db "2. Exit", 10
         db "Enter choice (1-2): "

    menu_len equ $ - menu


    ; Cross size prompt

    size_msg db "Enter cross size (odd number >= 3, e.g. 5, 7, 9): "

    size_len equ $ - size_msg


    ; Error messages

    err_invalid db "Error: Invalid input. Please enter a positive odd integer >= 3.", 10

    err_len equ $ - err_invalid


    err_choice db "Error: Please choose 1 or 2.", 10

    err_choice_len equ $ - err_choice


    ; Exit message

    bye_msg db "Goodbye!", 10

    bye_len equ $ - bye_msg


    ; Shape characters

    star db "* "

    space db "  "

    newline db 10


section .text

global _main


_main:


menu_loop:

    ; Display menu

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel menu]
    mov rdx, menu_len
    syscall


    call read_input


    call convert_to_number


    ; Check choice

    cmp rax, 1
    je do_cross

    cmp rax, 2
    je exit_program


    ; Invalid choice

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel err_choice]
    mov rdx, err_choice_len
    syscall

    jmp menu_loop


do_cross:


    call get_valid_size

    mov r12, rax
    mov r13, rdx


    ; Start row at 0

    xor r14, r14


row_loop:

    ; Start column at 0

    xor r15, r15


col_loop:

    ; Check whether current row is middle

    cmp r14, r13
    je print_star


    ; Check whether current column is middle

    cmp r15, r13
    je print_star


    ; Otherwise print a space

print_space:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel space]
    mov rdx, 2
    syscall

    jmp next_column



print_star:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel star]
    mov rdx, 2
    syscall



next_column:

    inc r15

    cmp r15, r12
    jl col_loop


    ; Print newline

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel newline]
    mov rdx, 1
    syscall


    ; Move to next row

    inc r14

    cmp r14, r12
    jl row_loop


    ; Finished drawing

    jmp menu_loop


get_valid_size:

size_prompt:

    ; Display size prompt

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel size_msg]
    mov rdx, size_len
    syscall


    ; Read size

    call read_input


    call convert_to_number


    ; Reject zero / invalid input

    cmp rax, 0
    je size_error


    ; Reject values below 3

    cmp rax, 3
    jl size_error


    ; Check if number is odd

    test rax, 1

    jz size_error


    ; Save size

    mov r12, rax



    xor rdx, rdx

    mov rcx, 2

    div rcx


    ; RAX now contains size / 2

    mov rdx, rax

    ; Return:
    ; RAX = size
    ; RDX = middle

    mov rax, r12

    ret



size_error:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel err_invalid]
    mov rdx, err_len
    syscall

    jmp size_prompt



read_input:

    ; Read from keyboard

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel input]
    mov rdx, 15
    syscall

    ret


convert_to_number:

    xor rax, rax

    lea rsi, [rel input]


convert_loop:

    movzx rcx, byte [rsi]


    ; Stop at newline

    cmp rcx, 10
    je convert_done


    ; Stop at carriage return

    cmp rcx, 13
    je convert_done


    ; Stop at null

    cmp rcx, 0
    je convert_done


    ; Check if character is below '0'

    cmp rcx, '0'
    jl convert_done


    ; Check if character is above '9'

    cmp rcx, '9'
    jg convert_done


    ; Convert ASCII digit to number

    sub rcx, '0'


    ; RAX = RAX * 10 + digit

    imul rax, rax, 10

    add rax, rcx


    ; Move to next character

    inc rsi

    jmp convert_loop


convert_done:

    ret


exit_program:

    ; Display goodbye message

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel bye_msg]
    mov rdx, bye_len
    syscall


    ; Exit

    mov rax, 0x2000001
    mov rdi, 0
    syscall
