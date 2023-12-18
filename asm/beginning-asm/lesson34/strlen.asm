extern printf
section .data
    str1    db  "01234567890123456789012345678901", 0
    fmt     db  "String length is %d", 10, 0

section .text
    global main
main:
push    rbp
mov     rbp, rsp
        pxor    xmm1, xmm1
        mov     rax, -16
        mov     rdi, str1
    .loop:
        add     rax, 16
        pcmpistri   xmm1, [rdi + rax], 0x08
        jnz     .loop
        add     rax, rcx

        mov     rdi, fmt
        mov     rsi, rax
        mov     rax, 0
        call    printf
leave
ret

