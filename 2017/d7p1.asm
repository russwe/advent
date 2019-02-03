format PE console
entry start

include 'win32a.inc'

section '.idata' import data readable

    library kernel,'kernel32.dll',\
            msvcrt,'msvcrt.dll'
    
    import  kernel,\
            ExitProcess, 'ExitProcess'

    import  msvcrt,\
            getchar, 'getchar',\
            printf, 'printf',\
            malloc, 'malloc',\
            free, 'free'

; macros and such

MAX_NAME = 25

MAX_CHILDREN = 10

struct NODE
    ; BTREE + TOWER
        szName        dd  ?
    
    ; BTREE
        pLeft         dd  ?
        pRight        dd  ?
    
    ; TOWER
        pParent       dd  ?
        nWeight       dd  ?
        pFirstChild   dd  ?
        pLastChild    dd  ?
        pNextSibling  dd  ?
ends

section '.text' code readable executable
start:
    ; SETUP
    push    ebp
    mov     ebp, esp

    sub     ebp, 8
    BTREE_ROOT = 8

    mov     dword [ebp + BTREE_ROOT], 0

.pass1:
    ; Build B-Tree
    ; Link Children, as found
    
    ; Read Name
    call    read_name
    test    eax, eax
    je      .pass2

    ; Lookup Node or add new Node
    push    eax
.pass1.lookup:
    mov     ebx, [ebp + BTREE_ROOT]
    xor     edx, edx
.pass1.lookup.compare:
    test    ebx, ebx
    jz      .pass1.newNode

    mov     edi, [ebx + NODE.szName]
    mov     esi, [esp]
    mov     ecx, MAX_NAME
    repe    cmpsb

    je      .pass1.existingNode
    setb    dl      ; 0, pRight; 1, pLeft
    lea     edx, [ebx + NODE.pRight + 8 * edx]
    mov     ebx, [edx]

    jmp     .pass1.lookup.compare

.pass1.newNode:
    push    sizeof.NODE
    call    [malloc]
    mov     ebx, eax

    test    edx, edx
    jz      .pass1.storeName
    mov     dword [edx], ebx

.pass1.storeName:
    pop     eax
    mov     dword [ebx + NODE.szName], eax
    jmp     .pass1.weight

.pass1.existingNode:
    pop     eax
    call    [free]

.pass1.weight:
    call    read_weight
    mov     dword [ebx + NODE.nWeight], eax

.pass1.children:    ; maybe children, maybe not!
    call    read_name
    test    eax, eax
    je      .pass1h 

    ; ??? How to add children to tree, but not end up in stupid loop with data we don't have
    ; !! TODO !!

.pass2:
    ; Walk to 'root' of tower

.pass3:
    ; Compute Weights until unbalenced node found

    ; OUTPUT
    ; Correction for unbalanced program

.end:
    push    eax
    call    [ExitProcess]

; IN: Input Handle
; OUT: eax = root node of btree
build_btree:

.end:
ret

; IN: Input String
; OUT: eax = new node ... children?
parse_node:

.end:
ret

; IN: BTree Root
; OUT: eax = Tower Base
find_tower_base:

.end:
ret

; IN: Tower Base
; OUT: correction for unbalanced program
compute_correction:

.end:
ret

;  O: eax
read_name:
    push    ecx
    push    esi
    push    edi

;   read to first lower-case letter
.consume:
    call    [getchar]
    cmp     eax, '\n'
    je      .read.err
    cmp     eax, '\n'

    sub     eax, 'a'
    cmp     eax, 'z' - 'a'
    ja      .consume

.consume.done:
    mov     ecx, eax
    add     ecx, 'a'

    push    MAX_NAME
    call    [malloc]
    mov     esi, eax
    mov     edi, eax

    mov     eax, ecx
    mov     ecx, MAX_NAME-1
    jmp     .read.entry
.read:
    call    [getchar]
.read.entry:
    cmp     eax, 'a'
    jb      .read.done
    cmp     eax, 'z'
    ja      .read.done
    stosb
    loop    .read

.read.err:
    mov     eax, 0
    test    ecx, ecx
    jz     .end

.read.done:
    mov     dword [edi], 0
    mov     eax, esi

.end:
    pop     edi
    pop     esi
    pop     ecx

    ret

read_weight:
    push    ebx
    push    ecx
    push    edx

;   read to first digit
.consume:
    call    [getchar]
    sub     eax, '0'
    cmp     eax, 9
    ja      .consume

    mov     ebx, 10
    mov     edx, eax
    
.read:
    call    [getchar]
    sub     eax, '0'
    cmp     eax, 9
    ja      .read.done

    xchg    eax, edx
    mul     ebx

    add     edx, eax
    jmp     .read

.read.done:
; paren

.end:
    pop     edx
    pop     ecx
    pop     ebx

    ret