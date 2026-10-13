bits 32

section .bss
    input   resb 16          ; buffer for user input

section .data
    msg     db "Enter cross size (odd number, e.g. 5, 7, 9): ", 0
    len     equ $ - msg - 1

    star    db "* "
    space   db "  "
    newline db 10

section .text
    global _start

_start:
    ; ----- 1. Print the prompt message -----
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, msg
    mov edx, len
    int 0x80

    ; ----- 2. Read what the user types -----
    mov eax, 3              ; sys_read
    mov ebx, 0              ; stdin
    mov ecx, input
    mov edx, 16
    int 0x80

    ; ----- 3. Convert input string into number (stored in ebp) -----
    xor ebp, ebp            ; ebp will be 'size' (start at 0)
    mov esi, input          ; pointer to input buffer

convert:
    movzx eax, byte [esi]
    cmp al, 10              ; Enter key (newline)?
    je done_convert
    cmp al, '0'
    jb done_convert
    cmp al, '9'
    ja done_convert

    sub al, '0'             ; convert ASCII char to number
    imul ebp, 10            ; size = size * 10
    add ebp, eax            ; size = size + digit
    inc esi
    jmp convert

done_convert:
    ; ebp = size

    ; ----- 4. Calculate mid = size / 2 -----
    mov eax, ebp
    xor edx, edx
    mov ecx, 2
    div ecx                 ; eax = size / 2
    mov edi, eax            ; edi = mid

    ; ----- 5. ROW LOOP (esi = row, from 0 to size - 1) -----
    xor esi, esi            ; row = 0

row_loop:
    ; ----- 6. COL LOOP (ecx = col, from 0 to size - 1) -----
    xor ecx, ecx            ; col = 0

col_loop:
    ; Check: if row == mid or col == mid
    cmp esi, edi            ; is row == mid?
    je print_star
    cmp ecx, edi            ; is col == mid?
    je print_star

print_space:
    ; print "  "
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov edx, 2              ; 2 bytes
    push ecx                ; save col loop counter
    mov ecx, space
    int 0x80
    pop ecx                 ; restore col loop counter
    jmp next_col

print_star:
    ; print "* "
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov edx, 2              ; 2 bytes
    push ecx                ; save col loop counter
    mov ecx, star
    int 0x80
    pop ecx                 ; restore col loop counter

next_col:
    inc ecx                 ; col = col + 1
    cmp ecx, ebp            ; while col < size
    jl col_loop

    ; ----- End of row: print newline -----
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; ----- Next row -----
    inc esi                 ; row = row + 1
    cmp esi, ebp            ; while row < size
    jl row_loop

    ; ----- 7. Exit program -----
    mov eax, 1              ; sys_exit
    xor ebx, ebx
    int 0x80


