extern printf
section .data
    string1 db  "The quick brown fox jumps over the lazy river.", 0
    fmt1    db  "This is our string: %s ", 10, 0
    fmt2    db  "Our string is %d characters long.", 10, 0

section .text
    global main

main:
push    rbp
mov     rbp, rsp
        mov     rdi, fmt1
        mov     rsi, string1
        xor     rax, rax
        call    printf
        mov     rdi, string1
        call    pstrlen
        mov     rdi, fmt2
        mov     rsi, rax
        xor     rax, rax
        call    printf
leave
ret
;func for finding string length
pstrlen:
push    rbp
mov     rbp, rsp
        mov     rax, -16
        pxor    xmm0, xmm0
    .not_found:
        add     rax, 16

        pcmpistri   xmm0, [rdi + rax], 00001000b  ; equalse to symbol in xmm0
        jnz     .not_found
        add     rax, rcx
        inc     rax
leave
ret
