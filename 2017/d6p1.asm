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

section '.data' data readable writeable
 ;  banks   db  0, 2, 7, 0
    banks   db  4, 10, 4, 1, 8, 4, 9, 14, 5, 1, 14, 15, 0, 15, 3, 5
    end.banks: BANK_COUNT = $ - banks

    MAX_NODE_COUNT = 1024 * 1024

    struct NODE
        banks   db  BANK_COUNT    dup(?)
        left    dd  ?
        right   dd  ?
    ends

    nodes       db  MAX_NODE_COUNT*sizeof.NODE  dup(0)
    end.nodes:
    
    next_node   dd  nodes

section '.text' code readable executable
start:
    mov     ebp, esp
    sub     esp, 8
    .remainder = -4
    .cycle_count = -8

    ; Initial Values
    mov     dword [ebp + .cycle_count], 0      ; cycle count
    call    store_banks

    ; Iterate and Keep Count
.cycle:
    inc     dword [ebp + .cycle_count]
        ; Pick largest -> EAX
    xor     eax, eax
    mov     edi, banks
    mov     ecx, BANK_COUNT
.pick_largest:
    scasb
    jb      .pick_largest.swap
    jmp     .pick_largest.n
.pick_largest.swap:
    mov     al, byte [edi-1]
    mov     dword [ebp + .remainder], ecx
.pick_largest.n:
    dec     ecx
    jnz     .pick_largest

        ; Base Amount = EAX: EAX / BANK_COUNT
        ; Leftover Amount = EDX: EAX % BANK_COUNT
    xor     edx, edx
    mov     ecx, BANK_COUNT
    div     ecx

    mov     ebx, dword [ebp + .remainder]
    neg     ebx
    lea     esi, [edi + ebx]
    mov     byte [esi], 0
.distribute:
    inc     esi
    cmp     esi, end.banks
    jnz     .distribute.n
    mov     esi, banks

.distribute.n:
        ; Distribute Amongst All Nodes
            ; N += N + B;
            ; ++N, --L (till 0)
    add     byte [esi], al
    test    edx, edx
    jz      .distribute.l
    inc     byte [esi]
    dec     edx

.distribute.l:
    dec     ecx
    jnz     .distribute

        ; Add Current Set to Tree (break, if already in tree)
    call    add_banks
    test    eax, eax
    jnz     .cycle

.exit:
    push    dword [ebp + .cycle_count]
    call    [ExitProcess]

add_banks:
    push    esi
    push    edi
    push    ecx

    mov     esi, nodes
.find_spot:
    mov     edi, banks
    mov     ecx, BANK_COUNT
    repe    cmpsb
    ; nodes[i] < banks[i]
    jb      .gt
    ; nodes[i] > banks[i]
    ja      .lt
    ; nodes[i] = banks[i]

.eq:
    mov     eax, 0
    jmp     .exit
.gt:
    ;       right
    lea     edi, [esi + ecx + 4] ; NODE.right
    jmp     .lp
.lt:
    ;       left
    lea     edi, [esi + ecx + 0] ; NODE.left
    
.lp:
    mov     esi, dword [edi]
    test    esi, esi
    jnz     .find_spot

.success:
    call    store_banks
    mov     dword [edi], eax
    mov     eax, 1

.exit:
    pop     ecx
    pop     edi
    pop     esi

    ret

store_banks:
    push    esi
    push    edi
    push    ecx

    mov     eax, dword [next_node]

    mov     esi, banks
    mov     edi, eax
    mov     ecx, BANK_COUNT
    rep     movsb

    add     dword [next_node], sizeof.NODE

    pop     ecx
    pop     edi
    pop     esi

    ret