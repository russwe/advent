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
    p1t1    db 1,1,2,2           ; produces a sum of 3 (1 + 2) because the first digit (1) matches the second digit and the third digit (2) matches the fourth digit.
    end.p1t1: len.t1 = $ - nums

    p1t2    db 1,1,1,1           ; produces 4 because each digit (all 1) matches the next.
    end.p1t2: len.t2 = $ - nums

    p1t3    db 1,2,3,4           ; produces 0 because no digit matches the next.
    end.p1t3: len.t3 = $ - nums

    p1t4    db 9,1,2,1,2,1,2,9   ; produces 9 because the only digit that matches the next one is the last digit, 9.
    end.p1t4: len.t4 = $ - nums

    p1      db 5, 7, 2, 7, 6, 2, 7, 4, 3, 8, 7, 9, 4, 4, 5, 3, 7, 8, 2, 3, 6, 5, 2, 6, 2, 6, 1, 7, 7, 8, 5, 3, 3, 8, 4, 4, 1, 1, 1, 4, \
               6, 3, 2, 5, 3, 8, 4, 4, 9, 4, 9, 3, 5, 9, 2, 4, 4, 5, 4, 3, 3, 6, 6, 1, 1, 9, 5, 3, 1, 1, 9, 1, 7, 3, 6, 3, 8, 1, 9, 1, \
               6, 7, 1, 3, 2, 6, 2, 5, 4, 8, 3, 2, 6, 2, 4, 8, 4, 1, 5, 9, 3, 4, 2, 1, 6, 6, 7, 6, 8, 3, 4, 7, 4, 3, 4, 9, 1, 5, 4, 6, \
               6, 8, 1, 7, 7, 7, 4, 3, 4, 3, 7, 7, 4, 5, 9, 6, 5, 4, 6, 1, 6, 7, 8, 6, 3, 6, 6, 3, 1, 8, 6, 3, 5, 4, 1, 4, 6, 2, 8, 9, \
               3, 5, 4, 7, 6, 1, 6, 8, 7, 7, 9, 1, 4, 9, 1, 4, 6, 6, 2, 3, 5, 8, 8, 3, 6, 3, 6, 5, 4, 2, 1, 1, 9, 8, 5, 1, 6, 2, 6, 3, \
               3, 3, 5, 9, 2, 6, 5, 4, 4, 7, 1, 6, 3, 3, 1, 8, 1, 4, 1, 2, 5, 2, 9, 5, 7, 1, 2, 5, 8, 1, 1, 5, 8, 3, 9, 9, 3, 2, 1, 3, \
               7, 2, 6, 8, 3, 7, 4, 2, 7, 7, 3, 4, 2, 3, 6, 2, 6, 2, 8, 6, 6, 6, 9, 7, 5, 9, 4, 1, 5, 9, 5, 9, 3, 9, 1, 3, 7, 4, 7, 4, \
               4, 2, 1, 4, 5, 9, 5, 6, 8, 2, 7, 9, 5, 8, 1, 8, 6, 1, 5, 5, 3, 2, 6, 7, 3, 8, 7, 7, 8, 6, 8, 4, 2, 4, 1, 9, 6, 9, 2, 6, \
               4, 9, 7, 7, 3, 1, 1, 4, 4, 3, 1, 9, 7, 3, 6, 4, 4, 5, 1, 4, 1, 7, 2, 8, 1, 2, 3, 3, 2, 2, 9, 6, 2, 5, 4, 7, 2, 8, 8, 5, \
               7, 2, 4, 3, 4, 5, 6, 4, 1, 7, 8, 4, 9, 2, 7, 5, 3, 6, 8, 1, 8, 4, 2, 2, 4, 4, 8, 8, 8, 3, 6, 8, 5, 4, 2, 4, 2, 3, 8, 3, \
               2, 2, 2, 8, 2, 1, 1, 1, 7, 2, 8, 4, 2, 4, 5, 6, 2, 3, 1, 2, 7, 5, 7, 3, 8, 1, 8, 2, 7, 6, 4, 2, 3, 2, 2, 6, 5, 9, 3, 3, \
               6, 2, 5, 1, 1, 9, 3, 1, 2, 5, 9, 8, 1, 6, 1, 1, 9, 2, 1, 9, 3, 2, 1, 4, 8, 9, 8, 9, 4, 9, 2, 6, 7, 7, 6, 5, 4, 1, 7, 4, \
               6, 8, 3, 4, 8, 9, 3, 5, 1, 3, 4, 6, 1, 8, 9, 6, 4, 6, 8, 3, 1, 2, 7, 1, 9, 4, 3, 9, 1, 7, 9, 6, 1, 6, 5, 3, 6, 8, 1, 4, \
               5, 5, 4, 8, 8, 1, 4, 4, 7, 3, 1, 2, 9, 8, 5, 7, 6, 9, 7, 9, 8, 9, 3, 2, 2, 6, 2, 1, 3, 6, 8, 7, 4, 4, 7, 2, 5, 6, 8, 5, \
               1, 8, 3, 3, 4, 6, 8, 2, 5, 3, 3, 3, 2, 4, 7, 8, 6, 6, 7, 3, 4, 7, 3, 5, 8, 9, 4, 4, 9, 3, 3, 9, 5, 2, 1, 8, 7, 8, 1, 4, \
               6, 4, 3, 4, 6, 9, 5, 1, 7, 7, 7, 8, 7, 3, 9, 2, 9, 8, 9, 8, 9, 6, 1, 3, 5, 8, 7, 9, 6, 2, 7, 4, 8, 8, 9, 8, 2, 6, 8, 9, \
               4, 5, 2, 9, 5, 9, 9, 6, 4, 5, 4, 4, 2, 6, 5, 7, 4, 2, 3, 4, 3, 8, 5, 6, 2, 4, 2, 3, 8, 5, 3, 2, 4, 7, 5, 4, 3, 6, 2, 1, \
               5, 6, 5, 4, 6, 8, 8, 1, 9, 7, 9, 9, 9, 3, 1, 5, 9, 8, 7, 5, 4, 7, 5, 3, 4, 6, 7, 5, 9, 3, 8, 3, 2, 3, 2, 8, 1, 4, 7, 4, \
               3, 9, 3, 4, 1, 5, 8, 6, 1, 2, 5, 2, 6, 2, 7, 3, 3, 7, 3, 7, 1, 2, 8, 3, 8, 6, 9, 6, 1, 5, 9, 6, 3, 9, 4, 7, 2, 8, 1, 5, \
               9, 7, 1, 9, 2, 9, 2, 7, 8, 7, 5, 9, 7, 4, 2, 6, 8, 9, 8, 9, 4, 5, 1, 9, 8, 7, 8, 8, 2, 1, 1, 4, 1, 7, 8, 5, 4, 6, 6, 2, \
               9, 4, 8, 3, 5, 8, 4, 2, 2, 7, 2, 9, 4, 7, 1, 3, 1, 2, 4, 5, 6, 4, 3, 7, 7, 7, 8, 9, 7, 8, 7, 4, 9, 7, 5, 3, 9, 2, 7, 2, \
               5, 1, 4, 3, 1, 6, 7, 7, 5, 3, 3, 5, 7, 5, 7, 5, 2, 3, 1, 2, 4, 4, 7, 4, 8, 8, 3, 3, 7, 1, 5, 6, 9, 5, 6, 2, 1, 7, 4, 5, \
               1, 9, 6, 5, 6, 4, 3, 4, 5, 4, 4, 4, 5, 3, 2, 9, 7, 5, 8, 3, 2, 7, 1, 2, 9, 9, 6, 6, 6, 5, 7, 1, 8, 9, 3, 3, 2, 8, 2, 4, \
               9, 6, 9, 1, 4, 1, 4, 4, 8, 5, 3, 8, 6, 8, 1, 9, 7, 9, 6, 3, 2, 6, 1, 1, 1, 9, 9, 3, 8, 5, 8, 9, 6, 9, 6, 5, 9, 4, 6, 8, \
               4, 9, 7, 2, 5, 4, 2, 1, 9, 7, 8, 1, 3, 7, 7, 5, 3, 3, 6, 6, 2, 5, 2, 4, 5, 9, 9, 1, 4, 9, 1, 3, 6, 3, 7, 8, 5, 8, 7, 8, \
               3, 1, 4, 6, 7, 3, 5, 4, 6, 9, 7, 5, 8, 7, 1, 6, 7, 5, 2, 7, 6, 5, 7, 1, 8, 1, 8, 9, 1, 7, 5, 5, 8, 3, 9, 5, 6, 4, 7, 6, \
               9, 3, 5, 1, 8, 5, 9, 8, 5, 9, 1, 8, 5, 3, 6, 3, 1, 8, 4, 2, 4, 2, 4, 8, 4, 2, 5, 4, 2, 6, 3, 9, 8, 1, 5, 8, 2, 7, 8, 1, \
               1, 1, 7, 5, 1, 7, 1, 1, 9, 1, 1, 2, 2, 7, 8, 1, 8, 8, 2, 6, 7, 6, 6, 1, 7, 7, 9, 9, 6, 2, 2, 3, 7, 1, 8, 8, 3, 7, 4, 2, \
               8, 9, 7, 2, 7, 8, 4, 3, 2, 8, 9, 2, 5, 7, 4, 3, 8, 6, 9, 8, 8, 5, 2, 3, 2, 2, 6, 6, 1, 2, 7, 7, 2, 7, 8, 6, 5, 2, 6, 7, \
               8, 8, 1, 5, 9, 2, 3, 9, 5, 6, 4, 3, 8, 3, 6, 9, 9, 9, 2, 4, 4, 2, 1, 8, 3, 4, 5, 1, 8, 4, 4, 7, 4, 6, 1, 3, 1, 2, 9, 8, \
               2, 3, 9, 3, 3, 6, 5, 9, 4, 2, 2, 2, 2, 3, 6, 8, 5, 4, 2, 2, 7, 3, 2, 1, 8, 6, 5, 3, 6, 1, 9, 9, 1, 5, 3, 9, 8, 8, 7, 1, \
               7, 4, 5, 5, 5, 6, 8, 5, 2, 3, 7, 8, 1, 6, 7, 3, 3, 9, 3, 6, 9, 8, 3, 5, 6, 9, 6, 7, 3, 5, 5, 8, 7, 5, 1, 2, 3, 5, 5, 4, \
               7, 9, 7, 7, 5, 5, 4, 9, 1, 1, 8, 1, 7, 9, 1, 5, 9, 3, 1, 5, 6, 4, 3, 3, 7, 3, 5, 5, 9, 1, 5, 2, 9, 4, 9, 5, 9, 8, 4, 2, \
               5, 6, 5, 1, 9, 6, 3, 1, 1, 8, 7, 8, 4, 9, 6, 5, 4, 6, 3, 3, 2, 4, 3, 2, 2, 5, 1, 1, 8, 1, 3, 2, 1, 5, 2, 5, 4, 9, 7, 1, \
               2, 6, 4, 3, 2, 7, 3, 8, 1, 9, 3, 1, 4, 4, 3, 3, 8, 7, 7, 5, 9, 2, 6, 4, 4, 6, 9, 3, 8, 2, 6, 8, 6, 1, 5, 2, 3, 2, 4, 3, \
               9, 4, 6, 9, 9, 8, 6, 1, 5, 7, 2, 2, 9, 5, 1, 1, 8, 2, 4, 7, 4, 7, 7, 3, 1, 7, 3, 2, 1, 5, 5, 2, 7, 5, 9, 8, 9, 4, 9, 5, \
               5, 3, 1, 8, 5, 3, 1, 3, 2, 5, 9, 9, 9, 2, 2, 2, 7, 8, 7, 9, 9, 6, 4, 4, 8, 2, 1, 2, 1, 7, 6, 9, 6, 1, 7, 2, 1, 8, 6, 8, \
               5, 3, 9, 4, 7, 7, 6, 7, 7, 8, 4, 2, 3, 3, 7, 8, 1, 8, 2, 4, 6, 2, 4, 2, 2, 7, 8, 8, 2, 7, 7, 9, 9, 7, 5, 2, 3, 9, 1, 3, \
               1, 7, 6, 3, 2, 6, 4, 6, 8, 9, 5, 7, 3, 4, 2, 2, 9, 6, 3, 6, 8, 1, 7, 8, 3, 2, 1, 9, 5, 8, 6, 2, 6, 1, 6, 8, 7, 8, 5, 5, \
               7, 8, 9, 7, 7, 4, 1, 4, 5, 3, 7, 3, 6, 8, 6, 8, 6, 4, 3, 8, 3, 4, 8, 1, 2, 4, 2, 8, 3, 7, 8, 9, 7, 4, 8, 7, 7, 5, 1, 6, \
               3, 8, 2, 1, 4, 5, 7, 6, 4, 1, 1, 3, 5, 1, 6, 3, 4, 9, 5, 6, 4, 9, 3, 3, 1, 1, 4, 4, 4, 3, 6, 1, 5, 7, 8, 3, 6, 6, 4, 7, \
               9, 1, 2, 8, 5, 2, 4, 8, 3, 1, 7, 7, 5, 4, 2, 2, 2, 4, 8, 6, 4, 9, 5, 2, 2, 7, 1, 8, 7, 4, 6, 4, 5, 2, 7, 4, 5, 7, 2, 4, \
               2, 6, 4, 5, 8, 6, 1, 4, 3, 8, 4, 9, 1, 7, 9, 2, 3, 6, 2, 3, 6, 2, 7, 5, 3, 2, 4, 8, 7, 6, 2, 5, 3, 9, 6, 9, 1, 4, 1, 1, \
               1, 5, 8, 2, 7, 5, 4, 9, 5, 3, 9, 4, 4, 9, 6, 5, 4, 6, 2, 5, 7, 6, 6, 2, 4, 7, 2, 8, 8, 9, 6, 9, 1, 7, 1, 3, 7, 5, 9, 9, \
               7, 7, 8, 8, 2, 8, 7, 6, 9, 9, 5, 8, 6, 2, 6, 7, 8, 8, 6, 8, 5, 3, 7, 4, 7, 4, 9, 6, 6, 1, 7, 4, 1, 2, 2, 3, 7, 4, 1, 8, \
               3, 4, 8, 4, 4, 6, 4, 3, 7, 2, 5, 4, 8, 6, 9, 2, 5, 8, 8, 6, 9, 3, 3, 1, 1, 8, 3, 8, 2, 6, 4, 9, 5, 8, 1, 4, 8, 1, 3, 5, \
               1, 8, 4, 4, 9, 4, 3, 3, 6, 8, 4, 8, 4, 8, 5, 3, 9, 5, 6, 7, 5, 9, 8, 7, 7, 2, 1, 5, 2, 5, 2, 7, 6, 6, 2, 9, 4, 8, 9, 6, \
               4, 9, 6, 4, 4, 4, 8, 3, 5, 2, 6, 4, 3, 5, 7, 1, 6, 9, 6, 4, 2, 3, 4, 1, 2, 9, 1, 4, 1, 2, 7, 6, 8, 9, 4, 6, 5, 8, 9, 7, \
               8, 1, 8, 1, 2, 4, 9, 3, 4, 2, 1, 3, 7, 9, 5, 7, 5, 5, 6, 9, 5, 9, 3, 6, 7, 8, 3, 5, 4, 2, 4, 1, 2, 2, 3, 3, 6, 3, 7, 3, \
               9, 1, 2, 9, 8, 1, 3, 6, 3, 3, 2, 3, 6, 9, 9, 6, 5, 8, 8, 7, 1, 1, 7, 9, 1, 9, 1, 9, 4, 2, 1, 5, 7, 4, 5, 8, 3, 9, 2, 4, \
               7, 4, 3, 1, 1, 9, 8, 6, 7, 6, 2, 2, 2, 2, 9, 6, 5, 9, 2, 1, 1, 7, 9, 3, 4, 6, 8, 7, 4, 4, 1, 6, 3, 2, 9, 7, 4, 7, 8, 9, \
               5, 2, 4, 7, 5, 9, 3, 3, 1, 6, 3, 2, 5, 9, 7, 6, 9, 5, 7, 8, 3, 4, 5, 8, 9, 4, 3, 6, 7, 8, 5, 5, 5, 3, 4, 2, 9, 4, 4, 9, \
               3, 6, 1, 3, 7, 6, 7, 5, 6, 4, 4, 9, 7, 1, 3, 7, 3, 6, 9, 9, 6, 9, 3, 1, 5, 1, 9, 2, 4, 4, 3, 7, 9, 5, 5, 1, 2, 5, 8, 5
    end.p1: len.p1 = $ - p1

    p2t1    db 1,2,1,2          ; produces 6: the list contains 4 items, and all four digits match the digit 2 items ahead.
    end.p2t1: len.p2t1 = $ - p2t1

    p2t2    db 1,2,2,1          ; produces 0, because every comparison is between a 1 and a 2.
    end.p2t2: len.p2t2 = $ - p2t2

    p2t3    db 1,2,3,4,2,5      ; produces 4, because both 2s match each other, but no other digit has a match.
    end.p2t3: len.p2t3 = $ - p2t3

    p2t4    db 1,2,3,1,2,3      ; produces 12.
    end.p2t4: len.p2t4 = $ - p2t4

    p2t5    db 1,2,1,3,1,4,1,5  ; produces 4.
    end.p2t5: len.p2t5 = $ - p2t5

    nums     = p1
    len.nums = len.p1
    end.nums = end.p1

    fmtDigit db "%d", 13, 10, 0

section '.text' code readable executable
start:
    xor     eax, eax            ; accumulator
    xor     ebx, ebx            ; current value
    
    mov     esi, nums                   ; current entry
    lea     edi, [esi + len.nums / 2]   ; comparison entry

sum_loop:
    mov     bl, byte [esi]

    cmp     bl, byte [edi]
    jne     sum_loop.maybe
    add     eax, ebx

sum_loop.maybe:
    inc     edi
    cmp     edi, end.nums
    jne     sum_loop.maybe.next_esi
    mov     edi, nums

sum_loop.maybe.next_esi:
    inc     esi
    cmp     esi, end.nums
    jnz     sum_loop

output:
    push    eax
    push    fmtDigit
    call    [printf]
    add     esp, 8

exit:
    push    eax
    call    [ExitProcess]