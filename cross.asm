bits 32

section .bss
    input   resb 16

section .data
;da menu
    menu        db 10, "========== SHAPE DRAWER ==========", 10
                db "1. Cross", 10
                db "2. Exit", 10
                db "Enter choice (1-2): ", 0
    menu_len    equ $ - menu - 1
;cross size
    size_msg    db "Enter cross size (odd number >= 3, e.g. 5, 7, 9): ", 10
    size_len    equ $ - size_msg - 1
;error message if user input invalid stuff
    err_invalid db "Error: Invalid input. Please enter a positive odd integer >= 3.", 10, 0
    err_len     equ $ - err_invalid - 1

    err_choice  db "Error: Please choose 1 or 2.", 10, 0
    err_choice_len equ $ - err_choice - 1
;exit message
    bye_msg     db "Goodbye!", 10, 0
    bye_len     equ $ - bye_msg - 1
;star and space
    star        db "* "
    space       db "  "
    newline     db 10

section .text
    global _start

_start:
menu_loop:
;Show the menu
    mov eax, 4
    mov ebx, 1
    mov ecx, menu
    mov edx, menu_len
    int 0x80

    call read_input
    call convert_to_number          ; result in ebp

    cmp ebp, 1
    je  do_cross
    cmp ebp, 2
    je  exit_program

;Invalid menu choice
    mov eax, 4
    mov ebx, 1
    mov ecx, err_choice
    mov edx, err_choice_len
    int 0x80
    jmp menu_loop

;da cross

do_cross:
    call get_valid_size             

    xor esi, esi                   
row_loop:
    xor ecx, ecx                    
col_loop:
    cmp esi, edi                    
    je  print_star
    cmp ecx, edi                   
    je  print_star

print_space:
    push ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 2
    int 0x80
    pop ecx
    jmp next_col

print_star:
    push ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, star
    mov edx, 2
    int 0x80
    pop ecx

next_col:
    inc ecx
    cmp ecx, ebp
    jl  col_loop

    ; newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    inc esi
    cmp esi, ebp
    jl  row_loop

    jmp menu_loop                   ; back to menu after drawing


; Keeps asking until a positive odd integer >= 3 is entered.
; Returns: ebp = size, edi = mid (size/2)

get_valid_size:
size_prompt:
    mov eax, 4
    mov ebx, 1
    mov ecx, size_msg
    mov edx, size_len
    int 0x80

    call read_input
    call convert_to_number          ; ebp = number (0 if invalid)

    ; Reject empty / non-numeric / zero
    cmp ebp, 0
    je  size_error

    ; Reject < 3
    cmp ebp, 3
    jl  size_error

    ; Reject even numbers
    test ebp, 1
    jz  size_error

    ; Valid → compute mid
    mov eax, ebp
    xor edx, edx
    mov ecx, 2
    div ecx
    mov edi, eax                    ; edi = mid
    ret

size_error:
    mov eax, 4
    mov ebx, 1
    mov ecx, err_invalid
    mov edx, err_len
    int 0x80
    jmp size_prompt                 ; re-prompt

;read user input
read_input:
    ; clear buffer
    mov edi, input
    mov ecx, 16
    xor al, al
    rep stosb

    mov eax, 3                      ; sys_read
    mov ebx, 0
    mov ecx, input
    mov edx, 15
    int 0x80
    ret


; Converts digits → ebp. Returns 0 if no valid digits found.

convert_to_number:
    xor ebp, ebp
    mov esi, input
    xor ecx, ecx                    ; digit counter

.convert_loop:
    movzx eax, byte [esi]
    cmp al, 10                      ; newline
    je  .done
    cmp al, 0
    je  .done
    cmp al, '0'
    jb  .done
    cmp al, '9'
    ja  .done

    sub al, '0'
    imul ebp, 10
    add ebp, eax
    inc esi
    inc ecx
    jmp .convert_loop

.done:
    cmp ecx, 0
    jne .ok
    xor ebp, ebp                    ; force 0 on empty/letters
.ok:
    ret

;exit

exit_program:
    mov eax, 4
    mov ebx, 1
    mov ecx, bye_msg
    mov edx, bye_len
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80


