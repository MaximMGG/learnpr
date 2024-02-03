section .data
    a       db  "a", 0
    count   equ  1000000

section .text

    global main

main:
push    rbp
mov     rbp, rsp
        mov     r12, count
    .loop:
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, a
        mov     rdx, 1
        syscall
        dec     r12
        cmp     r12, 0
        jne     .loop
leave
ret


