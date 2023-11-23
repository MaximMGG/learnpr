extern printf
section .data
    pp      db "%s", 10, 0
    msg     db "qwer", 0
    len     equ  $ - msg - 1

section .bss
    rev     resb 5

section .text
    global main

main:

    xor     rax, rax
    xor     rbx, rbx
    mov     rdx, msg 
    add     rdx, len - 1

    
loop:
    mov     rcx, 4
    mov     [rev], byte dl
    inc     rev
    dec     rcx
    dec     rdx
    cmp     rcx, 0
    jne     loop


end:
    mov rev, 0
    mov rdi, pp 
    mov rsi, rev 
    mov rax, 0
    call printf
    ret

