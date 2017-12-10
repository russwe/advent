; --- Day 3: Spiral Memory ---
; You come across an experimental new kind of memory stored on an infinite two-dimensional grid.
; Each square on the grid is allocated in a spiral pattern starting at a location marked 1 and then counting up while spiraling outward. For example, the first few squares are allocated like this:
; 17  16  15  14  13
; 18   5   4   3  12
; 19   6   1   2  11
; 20   7   8   9  10
; 21  22  23---> ...
; While this is very space-efficient (no squares are skipped), requested data must be carried back to square 1 (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the Manhattan Distance between the location of the data and square 1.
; For example:
; Data from square 1 is carried 0 steps, since it's at the access port.
; Data from square 12 is carried 3 steps, such as: down, left, left.
; Data from square 23 is carried only 2 steps: up twice.
; Data from square 1024 must be carried 31 steps.
;
; 0
; 1
;
; 1
;   4
; 6 - 2
;   8
;
; 2
;         15
;      5  --   3
; 19  --  --  --  11
;      7  --   9
;         23
;
; 30 31 32 33
; 20 21 22 23
; 10 11 12 13
; 00 01 02 03
;
; 0 = 00
; 1 = 10,01
; 2 = 20,11,02
; 3 = 30,21,12,03
; . . .
;
;    v     v     v     v        v           v           v           v              v
; 0  1                       2                                               3
; () (         8          )  (                     16                      ) ( . . . )
; 1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
; 00 01 11 10 11 10 11 01 11 12 02 12 22 21 20 21 22 21 20 21 22 21 02 12 22 23 13 03 13 23 33
; 0  1  2  1  2  1  2  1  2  3  2  3  4  3  2  3  4  3  2  3  4  3  2  3  4  5
;
; Side Length increases by two every time around: 1, 3, 5, ...
; Perimeter Length = 8N where N = 0,1,2,... : 1, 8, 16, 24, 32, ...
;
; https://math.stackexchange.com/questions/163080/on-a-two-dimensional-grid-is-there-a-formula-i-can-use-to-spiral-coordinates-in
; https://upload.wikimedia.org/wikipedia/commons/1/1d/Ulam_spiral_howto_all_numbers.svg
;

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

section '.text' code readable executable
start:
        mov     ebp, esp
        sub     esp, 4    ; keep stack aligned
        .x = -4

        finit
        fnstcw  word [ebp + .x]
        mov     ax, word [ebp + .x]
        or      ax, 100000000000b       ; round UP
        mov     word [ebp + .x], ax
        fldcw   word [ebp + .x]

        mov     ecx, 347991
looper:
        push    ecx
        call    spiral_xy

        cdq
        xor     eax, edx
        sub     eax, edx
        xchg    eax, ebx

        cdq
        xor     eax, edx
        sub     eax, edx

        add     eax, ebx

        push    eax
        call    prnt

;       loop    looper

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

;
; IN
;       n: nth step along spiral
; OUT
;       eax: x
;       ebx: y
spiral_xy:
        push    ebp
        mov     ebp, esp
        .n = 8

        sub     esp, 8
        .k = -4
        .x = -8

        push    ecx
        push    edx
        push    esi

; function spiral(n)
;         k=ceil((sqrt(n)-1)/2)
        fild    dword [ebp + .n]
        fsqrt

        mov     dword [ebp + .x], 1
        fild    dword [ebp + .x]
        fsubp

        mov     dword [ebp + .x], 2
        fild    dword [ebp + .x]
        fdivp

        frndint
        fistp   dword [ebp + .k]
        
;         t=2*k+1
        mov     eax, dword [ebp + .k]
        mov     ecx, 2
        mul     ecx
        inc     eax
        mov     ebx, eax        ; t

;         m=t^2
        mul     ebx
        mov     ecx, eax        ; m

;         t=t-1
        dec     ebx             ; t
        
        mov     eax, dword [ebp + .k]
        mov     esi, dword [ebp + .n]

        mov     edx, ecx
        sub     edx, ebx
;         if n>=m-t then return k-(m-n),-k      else m=m-t end
        cmp     esi, edx
        jge     .soln1
        mov     ecx, edx

        sub     edx, ebx
;         if n>=m-t then return -k,-k+(m-n)     else m=m-t end
        cmp     esi, edx
        jge     .soln2
        mov     ecx, edx

        sub     edx, ebx
;         if n>=m-t then return -k+(m-n),k      else return k,k-(m-n-t) end
        cmp     esi, edx
        jge     .soln3

.soln4: ; k,k-(m-n-t) -> k, k+n-(m-t)
        mov     ebx, eax
        add     ebx, esi
        sub     ebx, edx
        jmp     .return

.soln1: ; k-(m-n),-k -> k+n-m, -k
        mov     ebx, eax
        neg     ebx
        add     eax, esi
        sub     eax, ecx
        jmp     .return

.soln2: ; -k,-k+(m-n) -> -k, -k+m-n
        neg     eax
        mov     ebx, eax
        add     ebx, ecx
        sub     ebx, esi
        jmp     .return

.soln3: ; -k+(m-n),k -> -k+m-n, k -> m-k-n, k
        mov     ebx, ecx
        sub     ebx, eax
        sub     ebx, esi
        xchg    eax, ebx

; end

.return:
        pop     esi
        pop     edx
        pop     ecx

        mov     esp, ebp
        pop     ebp
        ret     4