section .data
        RECMenu db 0xA, '===== Rectangle Generator =====', 0xA
                db '1- Continue', 0xA
                db '2- Return', 0xA
                db 'Enter your option (1-2): '
        REClenRMenu equ $ - RECMenu

        RECinvMsg db 0xA,'Invalid option', 0xA
        REClenIM equ $ - RECinvMsg

        RECaskQuan db 0xA,'- Enter quantity (1-9): '
        REClenAQ equ $ - RECaskQuan

        RECaskHeig db 0xA,'-Enter height (2-30): '
        REClenAH equ $ - RECaskHeig

        RECaskWid db 0xA, 'Enter width (2-80): '
        REClenAW equ $ - RECaskWid

        RECsha db 0xA, 'Shape options'
                db 0xA, '1- Filled'
                db 0xA, '2- Hollow'
                db 0xA, 'Enter Your Option(1-2): '
        REClenSha equ $ - RECsha

        RECsym db 0xA, 'Enter yout preferred symbol/character to draw in: '
        REClenSym equ $ - RECsym

        RECcol db 0xA, 'Color Options'
                db 0xA, '1- White'
                db 0xA, '2- Red'
                db 0xA, '3- Green'
                db 0xA, '4- Blue'
                db 0xA, 'Enter Your Option(1-4): '
        REClenCol equ $ - RECcol

        RECspace db ' '
        RECnewline db 0xA

        white db 0x1B, '[37m'
        red  db 0x1B, '[31m'
        green db 0x1B, '[32m'
        blue db 0x1B, '[34m'
        reset db 0x1B, '[0m'

        RECdone db 0xA, 0xA, 'Done!. Returning to previous menu.', 0xA
        REClenDone equ $ - RECdone

section .bss
        RECop resb 1
        RECquantity resb 2
        RECwidth resb 3
        RECheight resb 3
        RECshape resb 1
        RECsymbol resb 2
        RECcolor resb 1
        RECrow resb 1
        RECcolumn resb 1
        RECcount resb 1
section .text

        global _start
_start:

REC_menu:
        mov eax, 4
        mov ebx, 1
        mov ecx, RECMenu
        mov edx, REClenRMenu
        int 0x80

        mov eax, 3
        mov ebx, 0
        mov ecx, RECop
        mov edx, 2
        int 0x80

        mov al, [RECop]

        cmp al, '0'
        jb RECmenu_E
        cmp al, '9'
        ja RECmenu_E

        sub al, '0'
        cmp al, 1
        jb RECmenu_E
        cmp al, 2
        ja RECmenu_E

        mov [RECop], al

        cmp byte [RECop], 1
        je RECcustm
        cmp byte [RECop], 2
        je exit      ;change call to main menu function


RECcustm:
        call RECQuantity_
        call RECHeight_
        call RECWidth_
        call RECShape_
        call RECSymbol_
        call RECColor_
        mov byte [RECcount], 1
        call RECColor_set
        jmp REC_S

RECQuantity_:
        mov eax, 4
        mov ebx, 1
        mov ecx, RECaskQuan
        mov edx, REClenAQ
        int 0x80

        mov eax, 3
        mov ebx, 0
        mov ecx, RECquantity
        mov edx, 2
        int 0x80
        call RECQuantity_C
        ret

RECQuantity_C:
        cmp byte [RECquantity +1], 0xA
        jne REClimit_EQ

        mov al, [RECquantity]

        cmp al, '0'
        jb REClimit_EQ
        cmp al, '9'
        ja REClimit_EQ

        sub al, '0'
        cmp al, 1
        jb REClimit_EQ
        cmp al, 9
        ja REClimit_EQ

        mov [RECquantity], al
        ret

RECHeight_:
        mov eax, 4
        mov ebx, 1
        mov ecx, RECaskHeig
        mov edx, REClenAH
        int 0x80

        mov eax, 3
        mov ebx, 0
        mov ecx, RECheight
        mov edx, 3
        int 0x80

        cmp byte [RECheight+1], 0xA
        je RECsingle_digitCH
        jne RECdouble_digitCH

        ret
RECsingle_digitCH:

        mov al, [RECheight]

        cmp al, '0'
        jb REClimit_EH
        cmp al, '9'
        ja REClimit_EH


        sub al, '0'
        cmp al, 2
        jb REClimit_EH
        mov [RECheight], al
        ret
RECdouble_digitCH:
        mov al, [RECheight]

        cmp al, '0'
        jb REClimit_EH
        cmp al, '9'
        ja REClimit_EH

        sub al, '0'
        mov bl, 10
        mul bl

        mov bl, [RECheight+1]

        cmp bl, '0'
        jb REClimit_EH
        cmp bl, '9'
        ja REClimit_EH

        sub bl, '0'
        add al, bl
        cmp al, 30
        ja REClimit_EH

        mov [RECheight], al
        ret
RECWidth_:
        mov eax, 4
        mov ebx, 1
        mov ecx, RECaskWid
        mov edx, REClenAW
        int 0x80

        mov eax, 3
        mov ebx, 0
        mov ecx, RECwidth
        mov edx, 3
        int 0x80

        cmp byte [RECwidth +1], 0xA
        je RECsingle_digitCW
        jne RECdouble_digitCW

        ret

RECsingle_digitCW:
        mov al, [RECwidth]

        cmp al, '0'
        jb REClimit_EW
        cmp al, '9'
        ja REClimit_EW

        sub al, '0'
        cmp al, 2
        jb REClimit_EW
        mov [RECwidth], al
        ret

RECdouble_digitCW:
        mov al, [RECwidth]

        cmp al, '0'
        jb REClimit_EW
        cmp al, '9'
        ja REClimit_EW

        sub al, '0'
        mov bl, 10
        mul bl

        mov bl, [RECwidth + 1]

        cmp bl, '0'
        jb REClimit_EW
        cmp bl, '9'
        ja REClimit_EW

        sub bl, '0'
        add al, bl
        cmp al, 80
        ja REClimit_EW
        mov [RECwidth], al

        ret
RECShape_:
        mov eax, 4
        mov ebx, 1
        mov ecx, RECsha
        mov edx, REClenSha
        int 0x80

        mov eax, 3
        mov ebx, 0
        mov ecx, RECshape
        mov edx, 2
        int 0x80

        cmp byte [RECshape+1], 0xA
        jne REClimit_ESH

        mov al, [RECshape]

        cmp al, '0'
        jb REClimit_ESH
        cmp al, '9'
        ja REClimit_ESH

        sub al, '0'

        cmp al, 1
        jb REClimit_ESH
        cmp al, 2
        ja REClimit_ESH

        mov [RECshape], al

        ret
RECSymbol_:
        mov eax, 4
        mov ebx, 1
        mov ecx, RECsym
        mov edx, REClenSym
        int 0x80

        mov eax, 3
        mov ebx, 0
        mov ecx, RECsymbol
        mov edx, 2

        int 0x80

        cmp byte [RECsymbol+1], 0xA
        jne REClimit_ESY

        ret
RECColor_:
        mov eax, 4
        mov ebx, 1
        mov ecx, RECcol
        mov edx, REClenCol
        int 0x80

        mov eax, 3
        mov ebx, 0
        mov ecx, RECcolor
        mov edx, 2
        int 0x80

        cmp byte [RECcolor+1], 0xA
        jne REClimit_ECO

        mov al, [RECcolor]
        cmp al, '0'
        jb REClimit_ECO
        cmp al, '9'
        ja REClimit_ECO

        sub al, '0'
        cmp al, 1
        jb REClimit_ECO
        cmp al, 4
        ja REClimit_ECO

        mov [RECcolor], al
        ret
RECColor_set:

        cmp byte [RECcolor], 1
        je RECwhite
        cmp byte [RECcolor], 2
        je RECred
        cmp byte [RECcolor], 3
        je RECgreen
        cmp byte [RECcolor], 4
        je RECblue


RECwhite:

        mov eax, 4
        mov ebx, 1
        mov ecx, white
        mov edx, 5
        int 0x80

        ret

RECred:

        mov eax, 4
        mov ebx, 1
        mov ecx, red
        mov edx, 5
        int 0x80

        ret


RECgreen:

        mov eax, 4
        mov ebx, 1
        mov ecx, green
        mov edx, 5
        int 0x80

        ret


RECblue:

        mov eax, 4
        mov ebx, 1
        mov ecx, blue
        mov edx, 5
        int 0x80

        ret
REC_S:
        mov al, [RECquantity]
        cmp byte [RECcount], al
        ja REC_E

        mov byte [RECrow], 1
        jmp RECRow_S
RECRow_S:
        mov al, [RECheight]
        cmp byte [RECrow], al
        ja RECRow_E

        mov byte [RECcolumn], 1
        jmp RECColumn_S
RECColumn_S:

        mov al, [RECwidth]
        cmp byte [RECcolumn], al
        ja RECColumn_E

        ;for filled shape
        cmp byte [RECshape] ,1
        je RECprint_symbol

        ;for first and last row (hollow)
        cmp byte [RECrow], 1
        je RECprint_symbol
        mov al, [RECheight]
        cmp byte [RECrow], al
        je RECprint_symbol


        ;for first and last column (hollow)
        cmp byte [RECcolumn], 1
        je RECprint_symbol
        mov al, [RECwidth]
        cmp byte [RECcolumn], al
        je RECprint_symbol

	;other which is inside holllow shape
        jmp RECprint_space

RECprint_symbol:
        mov eax, 4
        mov ebx, 1
        mov ecx, RECsymbol
        mov edx, 1
        int 0x80

        inc byte [RECcolumn]
        jmp RECColumn_S

RECprint_space:
        mov eax, 4
        mov ebx, 1
        mov ecx ,RECspace
        mov edx, 1
        int 0x80

        inc byte [RECcolumn]
        jmp RECColumn_S

RECColumn_E:

        call RECprint_nl

        inc byte [RECrow]
        jmp RECRow_S
RECRow_E:
        inc byte [RECcount]

        call RECprint_nl
        call RECprint_nl

        jmp REC_S
REC_E:
        mov eax, 4
        mov ebx, 1
        mov ecx, reset
        mov edx, 4
        int 0x80

        mov eax, 4
        mov ebx, 1
        mov ecx, RECdone
        mov edx, REClenDone
        int 0x80
        jmp REC_menu



RECmenu_E:
        call RECprintInvalid
        jmp REC_menu


RECprintInvalid:
        mov eax, 4
        mov ebx, 1
        mov ecx, RECinvMsg
        mov edx, REClenIM
        int 0x80
        ret

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
REClimit_ESY:
        call RECprintInvalid
        jmp RECSymbol_
REClimit_ECO:
        call RECprintInvalid
        jmp RECColor_

RECprint_nl:
        mov eax, 4
        mov ebx, 1
        mov ecx, RECnewline
        mov edx, 1
        int 0x80

        ret


exit: ;Change to return main menu funvction or remove if alredy provided**
        mov eax, 1
        xor ebx, ebx
        int 0x80
