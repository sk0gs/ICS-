section .data


; TITLE

title db 10, "==============================", 10
      db "     PARALLELOGRAM GENERATOR", 10
      db "==============================", 10
title_len equ $ - title


; DESIGN MENU

design_menu db 10, "Choose a parallelogram design:", 10
            db "1. Solid Parallelogram", 10
	    db "2. Hollow Parallelogram", 10
	    db "3. Reverse-Slant Solid Parallelogram", 10
	    db "4. Reverse-Slant Hollow Parallelogram", 10
	    db "5. Layered Parallelogram", 10
design_menu_len equ $ - design_menu

design_prompt db "Enter design (1-5): "
design_prompt_len equ $ - design_prompt


; SIZE

size_prompt db 10, "Enter parallelogram size (3-20): "
size_prompt_len equ $ - size_prompt


; COLOR MENU

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


; ERROR MESSAGE

invalid db "Invalid input. Please try again.", 10
invalid_len equ $ - invalid


; CHARACTERS

newline db 10
space db " "
star db "*"


; ANSI COLORS

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


; INPUT BUFFER

input resb 32


; OUTPUT BUFFER

buffer resb 20000


section .text

global _main


_main:


        ; PRINT TITLE
        mov rax, 0x2000004
	mov rdi, 1
	lea rsi, [rel title]
	mov rdx, title_len
	syscall

	
	; PRINT DESIGN MENU
	mov rax, 0x2000004
	mov rdi, 1
	lea rsi, [rel design_menu]
	mov rdx, design_menu_len
	syscall


; DESIGN INPUT

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

	; R12 = SELECTED DESIGN
	mov r12, rax

	jmp size_input


invalid_design:

	mov rax, 0x2000004
	mov rdi, 1
	lea rsi, [rel invalid]
	mov rdx, invalid_len
	syscall

	jmp design_input


; SIZE INPUT

size_input:
	mov rax, 0x2000004
	mov rdi, 1
	lea rsi, [rel size_prompt]
	mov rdx, size_prompt_len
	syscall

	call read_number

	cmp rax, 3
	jl invalid_size

	cmp rax, 20
	jg invalid_size

	mov r13, rax
	lea rdi, [rel buffer]

	cmp r12, 5
	je layered_parallelogram

	jmp color_menu_input
 

invalid_size:

	mov rax, 0x2000004
	mov rdi, 1
	lea rsi, [rel invalid]
	mov rdx, invalid_len
	syscall

	jmp size_input


; COLOR INPUT

color_menu_input:

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

	mov r14, rax
	lea rdi, [rel buffer]

	call append_color

	jmp select_design


invalid_color:

	mov rax, 0x2000004
	mov rdi, 1
	lea rsi, [rel invalid]
	mov rdx, invalid_len
	syscall

	jmp color_input


; SELECT DESIGN

select_design:

	cmp r12, 1
	je solid_parallelogram

	cmp r12, 2
	je hollow_parallelogram

	cmp r12, 3
	je reverse_solid_parallelogram

	cmp r12, 4
	je reverse_hollow_parallelogram

	jmp layered_parallelogram


; DESIGN 1 SOLID PARALLELOGRAM

solid_parallelogram:

	xor r15, r15


solid_row:

	cmp r15, r13
	jge finish_shape

	mov r8, r13
	dec r8
	sub r8, r15
	imul r8, 2


solid_spaces:

	cmp r8, 0
	je solid_stars_start

	call append_space

	dec r8
	jmp solid_spaces


solid_stars_start:

	mov r9, r13
	imul r9, 3


solid_stars:

	cmp r9, 0
	je solid_newline

	call append_star

	dec r9
	jmp solid_stars


solid_newline:

	call append_newline

	inc r15

	jmp solid_row


; DESIGN 2 HOLLOW PARALLELOGRAM

hollow_parallelogram:

	xor r15, r15


hollow_row:

	cmp r15, r13
	jge finish_shape

	mov r8, r13
	dec r8
	sub r8, r15
	imul r8, 2


hollow_leading_spaces:

	cmp r8, 0
	je hollow_content

	call append_space

	dec r8

	jmp hollow_leading_spaces


hollow_content:

	mov r9, r13
	imul r9, 3


	; FIRST & LAST ROW
	cmp r15, 0
	je hollow_full_row

	mov r8, r13
	dec r8

	cmp r15, r8
	je hollow_full_row


	; MIDDLE ROWS
	call append_star

	mov r10, r9
	sub r10, 2


hollow_inner_spaces:

	cmp r10, 0
	je hollow_last_star

	call append_space

	dec r10

	jmp hollow_inner_spaces


hollow_last_star:

	call append_star

	jmp hollow_newline


hollow_full_row:

	mov r10, r9


hollow_full_loop:

	cmp r10, 0
	je hollow_newline

	call append_star

	dec r10

	jmp hollow_full_loop


hollow_newline:

	call append_newline

	inc r15

	jmp hollow_row


; DESIGN 3 REVERSE-SLANT SOLID PARALLELOGRAM

reverse_solid_parallelogram:

	xor r15, r15


reverse_solid_row:

	cmp r15, r13
	jge finish_shape

	mov r8, r15
	imul r8, 2


reverse_solid_spaces:

	cmp r8, 0
	je reverse_solid_stars_start

	call append_space

	dec r8

	jmp reverse_solid_spaces


reverse_solid_stars_start:

	mov r9, r13
	imul r9, 3


reverse_solid_stars:

	cmp r9, 0
	je reverse_solid_newline

	call append_star

	dec r9

	jmp reverse_solid_stars


reverse_solid_newline:

	call append_newline

	inc r15

	jmp reverse_solid_row


; DESIGN 4 REVERSE-SLANT HOLLOW PARALLELOGRAM

reverse_hollow_parallelogram:

	xor r15, r15


reverse_hollow_row:

	cmp r15, r13
	jge finish_shape

	mov r8, r15
	imul r8, 2


reverse_hollow_leading_spaces:

	cmp r8, 0
	je reverse_hollow_content

	call append_space

	dec r8

	jmp reverse_hollow_leading_spaces


reverse_hollow_content:

	mov r9, r13
	imul r9, 3

	cmp r15, 0
	je reverse_hollow_full_row

	mov r8, r13
	dec r8

	cmp r15, r8
	je reverse_hollow_full_row

	call append_star

	mov r10, r9
	sub r10, 2


reverse_hollow_inner:

	cmp r10, 0
	je reverse_hollow_last_star

	call append_space

	dec r10

	jmp reverse_hollow_inner


reverse_hollow_last_star:

	call append_star

	jmp reverse_hollow_newline


reverse_hollow_full_row:

	mov r10, r9


reverse_hollow_full_loop:

	cmp r10, 0
	je reverse_hollow_newline

	call append_star

	dec r10

	jmp reverse_hollow_full_loop


reverse_hollow_newline:

	call append_newline

	inc r15

	jmp reverse_hollow_row


; DESIGN 5 LAYERED PARALLELOGRAM

layered_parallelogram:

	xor r15, r15


layered_row:

	cmp r15, r13
	jge finish_layered

	mov rax, r15
	xor rdx, rdx
	mov rcx, 7
	div rcx
	mov r14, rdx

	inc r14

	call append_color

	mov r8, r13
	dec r8
	sub r8, r15
	imul r8, 2


layered_spaces:

	cmp r8, 0
	je layered_stars_start

	call append_space

	dec r8

	jmp layered_spaces


layered_stars_start:

	mov r9, r13
	imul r9, 3


layered_stars:

	cmp r9, 0
	je layered_newline

	call append_star

	dec r9

	jmp layered_stars


layered_newline:

	call append_newline

	inc r15

	jmp layered_row


finish_layered:

	call append_reset

	jmp print_result


; FINISH NORMAL DESIGN

finish_shape:

	call append_reset


; PRINT COMPLETE BUFFER

print_result:

	lea rsi, [rel buffer]

	mov rdx, rdi
	sub rdx, rsi

	mov rax, 0x2000004
	mov rdi, 1
	syscall

	jmp program_exit


; APPEND ONE SPACE

append_space:

	mov byte [rdi], ' '

	inc rdi

	ret


; APPEND ONE STAR

append_star:

	mov byte [rdi], '*'

	inc rdi

	ret


; APPEND NEWLINE

append_newline:

	mov byte [rdi], 10

	inc rdi

	ret


; APPEND COLOR

append_color:

	cmp r14, 1
	je append_red

	cmp r14, 2
	je append_green

	cmp r14, 3
	je append_yellow

	cmp r14, 4
	je append_blue

	cmp r14, 5
	je append_purple

	cmp r14, 6
	je append_cyan

	jmp append_white


append_red:

	lea rsi, [rel red]
	mov rcx, red_len

	jmp copy_color


append_green:

	lea rsi, [rel green]
	mov rcx, green_len

	jmp copy_color


append_yellow:

	lea rsi, [rel yellow]
	mov rcx, yellow_len

	jmp copy_color


append_blue:

	lea rsi, [rel blue]
	mov rcx, blue_len

	jmp copy_color


append_purple:

	lea rsi, [rel purple]
	mov rcx, purple_len

	jmp copy_color


append_cyan:

	lea rsi, [rel cyan]
	mov rcx, cyan_len

	jmp copy_color


append_white:

	lea rsi, [rel white]
	mov rcx, white_len


copy_color:

	cld
	
	rep movsb

	ret


; RESET COLOR

append_reset:

	lea rsi, [rel reset]
	mov rcx, reset_len

	cld

	rep movsb

	ret


; READ NUMBER

read_number:

	mov rax, 0x2000003
	mov rdi, 0
	lea rsi, [rel input]
	mov rdx, 32
	syscall

	lea rsi, [rel input]
	xor rax, rax


read_loop:

	movzx rcx, byte [rsi]
	
	cmp rcx, 10
	je read_done

	cmp rcx, 13
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

