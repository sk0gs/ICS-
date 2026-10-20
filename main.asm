section .data

    title db 10, "================================", 10
          db "       SHAPE DRAWING SYSTEM", 10
          db "================================", 10
    title_len equ $ - title

    menu db 10
         db "1. Triangle", 10
         db "2. Parallelogram", 10
         db "3. Rectangle", 10
         db "4. Cross", 10
         db "5. Diamond", 10
         db "6. Exit", 10
         db "Enter your choice (1-6): "
    menu_len equ $ - menu

    invalid db 10, "Invalid choice. Please enter 1-6.", 10
    invalid_len equ $ - invalid

    newline db 10

    triangle_cmd db "./triangle", 0
    parallelogram_cmd db "./parallelogram", 0
    rectangle_cmd db "./rectangle", 0
    cross_cmd db "./cross", 0
    diamond_cmd db "./diamond", 0

section .bss

    input resb 16

section .text

    global _main
    extern _system

_main:

menu_loop:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel title]
    mov rdx, title_len
    syscall

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel menu]
    mov rdx, menu_len
    syscall

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel input]
    mov rdx, 16
    syscall

    mov al, [rel input]

    cmp al, '1'
    je run_triangle

    cmp al, '2'
    je run_parallelogram

    cmp al, '3'
    je run_rectangle

    cmp al, '4'
    je run_cross

    cmp al, '5'
    je run_diamond

    cmp al, '6'
    je exit_program

    jmp invalid_choice


run_triangle:

    sub rsp, 8
    lea rdi, [rel triangle_cmd]
    call _system
    add rsp, 8

    jmp menu_loop


run_parallelogram:

    sub rsp, 8
    lea rdi, [rel parallelogram_cmd]
    call _system
    add rsp, 8

    jmp menu_loop


run_rectangle:

    sub rsp, 8
    lea rdi, [rel rectangle_cmd]
    call _system
    add rsp, 8

    jmp menu_loop


run_cross:

    sub rsp, 8
    lea rdi, [rel cross_cmd]
    call _system
    add rsp, 8

    jmp menu_loop


run_diamond:

    sub rsp, 8
    lea rdi, [rel diamond_cmd]
    call _system
    add rsp, 8

    jmp menu_loop


invalid_choice:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel invalid]
    mov rdx, invalid_len
    syscall

    jmp menu_loop


exit_program:

    mov rax, 0x2000001
    mov rdi, 0
    syscall
