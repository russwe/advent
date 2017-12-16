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
    MAXWORDS = 20

section '.bss' readable writable
    stdin       dd      ?
    buffer      db      MAXLEN dup (?)

section '.data' data readable writable
    phrase_trie     db  padded.sizeof.NODE*MAXLEN dup (0)
end.phrase_trie:
    words           db  EDGES*MAXWORDS dup (0)
end.words:

section '.text' code readable executable
start:
    ; Get input (note: unsafe, buffer overflow, etc)
    push    buffer
    call    [gets]
    ; eax = buffer
    test    eax, eax
    jz      error

    mov     esi, buffer
    mov     edi, words - EDGES
.swallow_whitespace:
    cmp     byte [esi], ' '
    jne     .transform_word
    inc     esi
    jmp     .swallow_whitespace
.transform_word:
    add     edi, EDGES
    cmp     edi, end.words
    jae     error
.transform_char:
    xor     eax, eax
    mov     al, byte [esi]
    
    cmp     eax, ' '
    je      .swallow_whitespace ; .transform_word

    test    eax, eax
    jz      .process
    cmp     eax, 13
    je      .process
    cmp     eax, 10
    je      .process

    cmp     eax, 'a'
    jb      error
    cmp     eax, 'z'
    ja      error

    sub     eax, 'a'
    inc     byte [edi + eax]

    inc     esi
    jmp     .transform_char

.process:
    xor     ecx, ecx        ; last allocated index

    mov     esi, edi        ; current word (working backwards)
    add     esi, EDGES
.process_word:
    cmp     esi, words
    je      .scan

    mov     edx, EDGES      ; current word character index (working backwards)
    sub     esi, edx
    mov     edi, phrase_trie
.find_char:
    test    edx, edx
    jz      .process_word
    dec     edx

    mov     al, byte [esi + edx]
.process_char:
    test    eax, eax
    jz      .find_char
    dec     eax    

.write_letter:
    inc     byte [edi + NODE.nCount]

    ; edx letter
    xor     ebx, ebx
    mov     bl, byte [edi + NODE.aidxNode + edx]
    test    ebx, ebx
    jnz     .follow

    inc     ecx
    cmp     ecx, MAXLEN
    je      error

    mov     ebx, ecx
    mov     byte [edi + NODE.aidxNode + edx], bl

.follow:
    shl     ebx, 5; 2^5 = 32
    lea     edi, [phrase_trie + ebx]
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