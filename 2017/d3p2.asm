; --- Day 3: Spiral Memory ---
; As a stress test on the system, the programs here clear the grid and then store the value 1 in square 1. Then, in the same allocation order as shown above, they store the sum of the values in all adjacent squares, including diagonals.
; So, the first few squares' values are chosen as follows:
; Square 1 starts with the value 1.
; Square 2 has only one adjacent filled square (with value 1), so it also stores 1.
; Square 3 has both of the above squares as neighbors and stores the sum of their values, 2.
; Square 4 has all three of the aforementioned squares as neighbors and stores the sum of their values, 4.
; Square 5 only has the first and fourth squares as neighbors, so it gets the value 5.
; Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:
; 147  142  133  122   59
; 304    5    4    2   57
; 330   10    1    1   54
; 351   11   23   25   26
; 362  747  806--->   ...

format PE console
entry start

include 'win32a.inc'

section '.idata' import data readable
 
    library kernel,'kernel32.dll',\
            msvcrt,'msvcrt.dll'
    
    import  kernel,\
            ExitProcess,'ExitProcess'

    import  msvcrt,\
            printf, 'printf'

section '.const' data readable
        fmtDigit        db      "%u",13,10,0

section '.data' data readable writable
        ROWS = 101
        COLS = 101
        ORI = 50
        OCI = 50
        arrSpiral       dd      ROWS*COLS       dup(0)

section '.text' code readable executable
start:
        mov     ebp, esp
        sub     esp, 4    ; keep stack aligned
        .x = -4

        push    OCI
        push    ORI

        push    0
        push    0
        call    get_addr
        add     esp, 4*2
        mov     dword [eax], 1

        push    1
        push    0
        call    get_addr
        add     esp, 4*4
        mov     dword [eax], 1

        ; eax: offset
        ; ebx: next value
        ; ecx: loop counter
        ; edx: directionality
        ; esi: col index
        ; edi: row index

        mov     esi, OCI
        mov     edi, ORI

        mov     edx, 0  ; 0 > , 1 ^ , 2 < , 3 v
        mov     ecx, ROWS*COLS
looper:
.move:
        push    esi
        push    edi

        cmp     edx, 3
        je      .down
        cmp     edx, 2
        je      .left
        cmp     edx, 1
        je      .up
.right: ; check up
        inc     esi

        push    1
        push    1
        call    get_addr
        add     esp, 4*4

        mov     eax, [eax]
        test    eax, eax
        jnz     .compute
        inc     edx
        jmp     .compute
.up: ; check left
        inc     edi

        push    -1
        push    1
        call    get_addr
        add     esp, 4*4

        mov     eax, [eax]
        test    eax, eax
        jnz     .compute
        inc     edx
        jmp     .compute
.left: ; check down
        dec     esi

        push    -1
        push    -1
        call    get_addr
        add     esp, 4*4

        mov     eax, [eax]
        test    eax, eax
        jnz     .compute
        inc     edx
        jmp     .compute
.down: ; check right
        dec     edi

        push    1
        push    -1
        call    get_addr
        add     esp, 4*4

        mov     eax, [eax]
        test    eax, eax
        jnz     .compute
        mov     edx, 0

.compute:
        push    esi
        push    edi

        xor     ebx, ebx

        ; R
        push    1
        push    0
        call    get_addr
        add     esp, 4*2
        add     ebx, dword [eax]

        ; RU
        push    1
        push    1
        call    get_addr
        add     esp, 4*2
        add     ebx, dword [eax]

        ; U
        push    0
        push    1
        call    get_addr
        add     esp, 4*2
        add     ebx, dword [eax]

        ; LU
        push    -1
        push    1
        call    get_addr
        add     esp, 4*2
        add     ebx, dword [eax]

        ; L
        push    -1
        push    0
        call    get_addr
        add     esp, 4*2
        add     ebx, dword [eax]

        ; LD
        push    -1
        push    -1
        call    get_addr
        add     esp, 4*2
        add     ebx, dword [eax]

        ; D
        push    0
        push    -1
        call    get_addr
        add     esp, 4*2
        add     ebx, dword [eax]

        ; RD
        push    1
        push    -1
        call    get_addr
        add     esp, 4*2
        add     ebx, dword [eax]

.store:
        push    0
        push    0
        call    get_addr

        mov     dword [eax], ebx

        add     esp, 4*2        ; esi, edi

;        push    edx
;        call    prnt        

;        push    ebx
;        call    prnt

        cmp     ebx, 347991
        ja      .found

        dec     ecx
        test    ecx, ecx
        jnz     looper

.found:
        push    ebx
        call    prnt

exit:
        push    eax
        call    [ExitProcess]


prnt:
        push    ebp
        mov     ebp, esp
        .num = 8

        pushad  ; saving/restoring, ecx is getting corrupted, wtf?

        push    dword [ebp + .num]
        push    fmtDigit
        call    [printf]
        add     esp, 8
        
        popad

        mov     esp, ebp
        pop     ebp
        ret     4


;       COLS * .row + .col
get_addr:
        push    ebp
        mov     ebp, esp
        .rof = 8
        .cof = 12
        .row = 16
        .col = 20

        push    ebx
        push    edx

        mov     eax, dword [ebp + .row]
        add     eax, dword [ebp + .rof]
        mov     ebx, COLS
        imul    ebx

        add     eax, dword [ebp + .col]
        add     eax, dword [ebp + .cof]

        lea     eax, dword [arrSpiral + 4*eax]

;        push    eax
;        call    prnt

;        push    dword [eax]
;        call    prnt

        pop     edx
        pop     ebx

        mov     esp, ebp
        pop     ebp
        ret