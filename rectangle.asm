section .data

    RECMenu db 10, '===== Rectangle Generator =====', 10
            db '1- Continue', 10
            db '2- Return', 10
            db 'Enter your option (1-2): '
    REClenRMenu equ $ - RECMenu

    RECinvMsg db 10, 'Invalid option', 10
    REClenIM equ $ - RECinvMsg

    RECaskQuan db 10, 'Enter quantity (1-9): '
    REClenAQ equ $ - RECaskQuan

    RECaskHeig db 10, 'Enter height (2-25): '
    REClenAH equ $ - RECaskHeig

    RECaskWid db 10, 'Enter width (2-50): '
    REClenAW equ $ - RECaskWid

    RECsha db 10, 'Shape options', 10
            db '1- Filled', 10
            db '2- Hollow', 10
            db 'Enter Your Option(1-2): '
    REClenSha equ $ - RECsha

    RECalign db 10, 'Alignment options', 10
             db '1- Left', 10
             db '2- Middle', 10
             db '3- Right', 10
             db 'Enter Your Option(1-3): '
    REClenAlign equ $ - RECalign

    RECsym db 10, 'Enter your preferred symbol/character to draw in: '
    REClenSym equ $ - RECsym

    RECcol db 10, 'Color Options', 10
           db '1- White', 10
           db '2- Red', 10
           db '3- Green', 10
           db '4- Blue', 10
           db 'Enter Your Option(1-4): '
    REClenCol equ $ - RECcol

    RECspace db ' '
    RECnewline db 10

    white db 27, '[37m'
    red   db 27, '[31m'
    green db 27, '[32m'
    blue  db 27, '[34m'
    reset db 27, '[0m'

    RECdone db 10, 10, 'Done!. Returning to previous menu.', 10
    REClenDone equ $ - RECdone


section .bss

    RECop          resb 2
    RECquantity    resb 2
    RECwidth       resb 3
    RECheight      resb 3
    RECshape       resb 2
    RECalignment   resb 2
    RECsymbol      resb 4
    RECcolor       resb 2
    RECalign_count resb 1
    RECrow         resb 1
    RECcolumn      resb 1
    RECcount       resb 1


section .text

    global _main


_main:

REC_menu:

    ; Display rectangle menu
    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECMenu]
    mov rdx, REClenRMenu
    syscall

    ; Read menu option
    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel RECop]
    mov rdx, 2
    syscall

    cmp byte [rel RECop + 1], 10
    jne RECmenu_E

    mov al, [rel RECop]

    cmp al, '0'
    jb RECmenu_E

    cmp al, '9'
    ja RECmenu_E

    sub al, '0'

    cmp al, 1
    jb RECmenu_E

    cmp al, 2
    ja RECmenu_E

    mov [rel RECop], al

    cmp byte [rel RECop], 1
    je RECcustm

    cmp byte [rel RECop], 2
    je exit


; CUSTOM RECTANGLE

RECcustm:

    call RECQuantity_
    call RECHeight_
    call RECWidth_
    call RECShape_
    call RECAlignment_
    call RECSymbol_
    call RECColor_

    mov byte [rel RECcount], 1

    call RECColor_set

    jmp REC_S


; READ QUANTITY

RECQuantity_:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECaskQuan]
    mov rdx, REClenAQ
    syscall

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel RECquantity]
    mov rdx, 2
    syscall

    cmp byte [rel RECquantity + 1], 10
    jne REClimit_EQ

    mov al, [rel RECquantity]

    cmp al, '0'
    jb REClimit_EQ

    cmp al, '9'
    ja REClimit_EQ

    sub al, '0'

    cmp al, 1
    jb REClimit_EQ

    cmp al, 9
    ja REClimit_EQ

    mov [rel RECquantity], al
    ret


; READ HEIGHT
RECHeight_:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECaskHeig]
    mov rdx, REClenAH
    syscall

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel RECheight]
    mov rdx, 3
    syscall

    ; Check for one digit + newline
    cmp byte [rel RECheight + 1], 10
    je RECsingle_digitCH

    ; Check for two digits + newline
    cmp byte [rel RECheight + 2], 10
    je RECdouble_digitCH

    jmp REClimit_EH


RECsingle_digitCH:

    mov al, [rel RECheight]

    cmp al, '0'
    jb REClimit_EH

    cmp al, '9'
    ja REClimit_EH

    sub al, '0'

    cmp al, 2
    jb REClimit_EH

    mov [rel RECheight], al
    ret


RECdouble_digitCH:

    ; Convert first digit
    mov al, [rel RECheight]

    cmp al, '0'
    jb REClimit_EH

    cmp al, '9'
    ja REClimit_EH

    sub al, '0'

    ; Multiply first digit by 10
    mov bl, 10
    mul bl

    ; Add second digit
    mov bl, [rel RECheight + 1]

    cmp bl, '0'
    jb REClimit_EH

    cmp bl, '9'
    ja REClimit_EH

    sub bl, '0'
    add al, bl

    cmp al, 25
    ja REClimit_EH

    mov [rel RECheight], al
    ret


; READ WIDTH
RECWidth_:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECaskWid]
    mov rdx, REClenAW
    syscall

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel RECwidth]
    mov rdx, 3
    syscall

    ; Check for one digit + newline
    cmp byte [rel RECwidth + 1], 10
    je RECsingle_digitCW

    ; Check for two digits + newline
    cmp byte [rel RECwidth + 2], 10
    je RECdouble_digitCW

    jmp REClimit_EW


RECsingle_digitCW:

    mov al, [rel RECwidth]

    cmp al, '0'
    jb REClimit_EW

    cmp al, '9'
    ja REClimit_EW

    sub al, '0'

    cmp al, 2
    jb REClimit_EW

    mov [rel RECwidth], al
    ret


RECdouble_digitCW:

    ; Convert first digit
    mov al, [rel RECwidth]

    cmp al, '0'
    jb REClimit_EW

    cmp al, '9'
    ja REClimit_EW

    sub al, '0'

    ; Multiply first digit by 10
    mov bl, 10
    mul bl

    ; Add second digit
    mov bl, [rel RECwidth + 1]

    cmp bl, '0'
    jb REClimit_EW

    cmp bl, '9'
    ja REClimit_EW

    sub bl, '0'
    add al, bl

    cmp al, 50
    ja REClimit_EW

    mov [rel RECwidth], al
    ret


; READ FILLED / HOLLOW
RECShape_:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECsha]
    mov rdx, REClenSha
    syscall

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel RECshape]
    mov rdx, 2
    syscall

    cmp byte [rel RECshape + 1], 10
    jne REClimit_ESH

    mov al, [rel RECshape]

    cmp al, '0'
    jb REClimit_ESH

    cmp al, '9'
    ja REClimit_ESH

    sub al, '0'

    cmp al, 1
    jb REClimit_ESH

    cmp al, 2
    ja REClimit_ESH

    mov [rel RECshape], al
    ret


; READ ALIGNMENT
RECAlignment_:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECalign]
    mov rdx, REClenAlign
    syscall

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel RECalignment]
    mov rdx, 2
    syscall

    cmp byte [rel RECalignment + 1], 10
    jne REClimit_EA

    mov al, [rel RECalignment]

    cmp al, '0'
    jb REClimit_EA

    cmp al, '9'
    ja REClimit_EA

    sub al, '0'

    cmp al, 1
    jb REClimit_EA

    cmp al, 3
    ja REClimit_EA

    cmp al, 1
    je REC_LA

    cmp al, 2
    je REC_MA

    cmp al, 3
    je REC_RA


REC_LA:

    mov byte [rel RECalignment], 0
    ret


REC_MA:

    mov byte [rel RECalignment], 20
    ret


REC_RA:

    mov byte [rel RECalignment], 40
    ret


; READ SYMBOL
RECSymbol_:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECsym]
    mov rdx, REClenSym
    syscall

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel RECsymbol]
    mov rdx, 2
    syscall

    cmp byte [rel RECsymbol + 1], 10
    jne REClimit_ESY

    ret


; READ COLOR
RECColor_:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECcol]
    mov rdx, REClenCol
    syscall

    mov rax, 0x2000003
    mov rdi, 0
    lea rsi, [rel RECcolor]
    mov rdx, 2
    syscall

    cmp byte [rel RECcolor + 1], 10
    jne REClimit_ECO

    mov al, [rel RECcolor]

    cmp al, '0'
    jb REClimit_ECO

    cmp al, '9'
    ja REClimit_ECO

    sub al, '0'

    cmp al, 1
    jb REClimit_ECO

    cmp al, 4
    ja REClimit_ECO

    mov [rel RECcolor], al
    ret


; SET SELECTED COLOR
RECColor_set:

    cmp byte [rel RECcolor], 1
    je RECwhite

    cmp byte [rel RECcolor], 2
    je RECred

    cmp byte [rel RECcolor], 3
    je RECgreen

    cmp byte [rel RECcolor], 4
    je RECblue


RECwhite:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel white]
    mov rdx, 5
    syscall

    ret


RECred:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel red]
    mov rdx, 5
    syscall

    ret


RECgreen:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel green]
    mov rdx, 5
    syscall

    ret


RECblue:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel blue]
    mov rdx, 5
    syscall

    ret


; START DRAWING RECTANGLES
REC_S:

    mov al, [rel RECquantity]

    cmp byte [rel RECcount], al
    ja REC_E

    mov byte [rel RECrow], 1

    jmp RECRow_S


; START ROW
RECRow_S:

    mov al, [rel RECheight]

    cmp byte [rel RECrow], al
    ja RECRow_E

    mov byte [rel RECalign_count], 1

    jmp RECprint_alignS


; PRINT ALIGNMENT SPACES
RECprint_alignS:

    mov al, [rel RECalignment]

    cmp byte [rel RECalign_count], al
    ja RECprint_alignE

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECspace]
    mov rdx, 1
    syscall

    inc byte [rel RECalign_count]

    jmp RECprint_alignS


RECprint_alignE:

    mov byte [rel RECcolumn], 1

    jmp RECColumn_S


; START COLUMN
RECColumn_S:

    mov al, [rel RECwidth]

    cmp byte [rel RECcolumn], al
    ja RECColumn_E

    ; Filled rectangle
    cmp byte [rel RECshape], 1
    je RECprint_symbol

    ; Hollow rectangle - first row
    cmp byte [rel RECrow], 1
    je RECprint_symbol

    ; Hollow rectangle - last row
    mov al, [rel RECheight]
    cmp byte [rel RECrow], al
    je RECprint_symbol

    ; Hollow rectangle - first column
    cmp byte [rel RECcolumn], 1
    je RECprint_symbol

    ; Hollow rectangle - last column
    mov al, [rel RECwidth]
    cmp byte [rel RECcolumn], al
    je RECprint_symbol

    ; Inside hollow rectangle
    jmp RECprint_space


; PRINT SYMBOL
RECprint_symbol:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECsymbol]
    mov rdx, 1
    syscall

    inc byte [rel RECcolumn]

    jmp RECColumn_S


; PRINT SPACE
RECprint_space:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECspace]
    mov rdx, 1
    syscall

    inc byte [rel RECcolumn]

    jmp RECColumn_S


; END OF COLUMN
RECColumn_E:

    call RECprint_nl

    inc byte [rel RECrow]

    jmp RECRow_S


; END OF ROW
RECRow_E:

    inc byte [rel RECcount]

    call RECprint_nl
    call RECprint_nl

    jmp REC_S


; FINISH RECTANGLE GENERATION
REC_E:

    ; Reset terminal color
    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel reset]
    mov rdx, 4
    syscall

    ; Display completion message
    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECdone]
    mov rdx, REClenDone
    syscall

    ; Return to rectangle menu
    jmp REC_menu


; INVALID MENU OPTION
RECmenu_E:

    call RECprintInvalid

    jmp REC_menu


; PRINT INVALID MESSAGE
RECprintInvalid:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECinvMsg]
    mov rdx, REClenIM
    syscall

    ret


; INPUT ERROR
REClimit_EQ:

    call RECprintInvalid
    jmp RECQuantity_


REClimit_EH:

    call RECprintInvalid
    jmp RECHeight_


REClimit_EW:

    call RECprintInvalid
    jmp RECWidth_


REClimit_ESH:

    call RECprintInvalid
    jmp RECShape_


REClimit_EA:

    call RECprintInvalid
    jmp RECAlignment_


REClimit_ESY:

    call RECprintInvalid
    jmp RECSymbol_


REClimit_ECO:

    call RECprintInvalid
    jmp RECColor_


; PRINT NEW LINE
RECprint_nl:

    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel RECnewline]
    mov rdx, 1
    syscall

    ret


; EXIT
exit:

    mov rax, 0x2000001
    mov rdi, 0
    syscall
