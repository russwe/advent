;

format PE console
entry start

include 'win32a.inc'

EDGES = ('z'-'a' + 1)
struct NODE
    nCount      db  0
    aidxNode    db  EDGES dup(0)
ends
padded.sizeof.NODE = 32

section '.idata' import data readable
 
    library kernel,'kernel32.dll',\
            msvcrt,'msvcrt.dll'
    
    import  kernel,\
            ExitProcess,'ExitProcess'

    import  msvcrt,\
            printf, 'printf',\
            gets, 'gets',\
            fopen, 'fopen',\
            fgets, 'fgets'

section '.const' data readable
    fmtDigit    db      "%u",13,10,0
    fmtScan     db      "%s"
    MAXLEN = 256

section '.bss' readable writable
    stdin       dd      ?
    buffer      db      MAXLEN dup (?)

section '.data' data readable writable
    phrase_trie     db  padded.sizeof.NODE*MAXLEN dup (0)

section '.text' code readable executable
start:
    ; Get input (note: unsafe, buffer overflow, etc)
    push    buffer
    call    [gets]
    ; eax = buffer
    test    eax, eax
    jz      error

    mov     ecx, 0      ; last allocated index
    mov     esi, buffer
.swallow_whitespace:
    cmp     byte [esi], ' '
    jne     .process_word
    inc     esi
    jmp     .swallow_whitespace
.process_word:
    mov     edi, phrase_trie
.process_char:
    xor     eax, eax
    mov     al, byte [esi]
    
    cmp     eax, ' '
    je      .swallow_whitespace

    test    eax, eax
    jz      .scan    
    cmp     eax, 13
    je      .scan
    cmp     eax, 10
    je      .scan

    inc     byte [edi + NODE.nCount]

    sub     eax, 'a'

    xor     ebx, ebx
    mov     bl, byte [edi + NODE.aidxNode + eax]
    test    ebx, ebx
    jnz     .follow

    inc     ecx
    cmp     ecx, MAXLEN
    je      error

    mov     ebx, ecx
    mov     byte [edi + NODE.aidxNode + eax], bl

.follow:
    shl     ebx, 5; 2^5 = 32
    lea     edi, [phrase_trie + ebx]

    inc     esi
    jmp     .process_char

.scan:
    mov     ebp, esp
    push    phrase_trie
.scan.l:
    cmp     ebp, esp
    je      .no_duplicates

    pop     esi
    mov     edx, esp

    xor     eax, eax
    xor     ecx, ecx
    mov     al, byte [esi + NODE.nCount]
.scan.child.l:
    ; sum (and push) children, validate against cur count

    xor     ebx, ebx
    mov     bl, byte [esi + NODE.aidxNode + ecx]
    test    ebx, ebx
    jz      .scan.child.l.next

    shl     ebx, 5
    lea     edi, [phrase_trie + ebx]
    sub     al, byte [edi + NODE.nCount]
    push    edi

.scan.child.l.next:
    inc     ecx
    cmp     ecx, EDGES
    jne     .scan.child.l

.scan.child.validate:
    cmp     eax, 1
    jbe     .scan.l
    mov     esp, edx
    
    mov     eax, 0
    jmp     exit

.no_duplicates:
    mov     eax, 1

exit:
    mov     esp, ebp

    push    eax
    call    prnt

    push    eax
    call    [ExitProcess]
error:
    push    -1
    call    [ExitProcess]

prnt:
    push    ebp
    mov     ebp, esp
    .num = 8

    pushad

    push    dword [ebp + .num]
    push    fmtDigit
    call    [printf]
    add     esp, 8

    popad

    mov     esp, ebp
    pop     ebp
    ret     4