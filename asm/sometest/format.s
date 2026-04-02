section .data
    msg     db  "Hello world!", 10, 0
    msglen  equ $ - msg

section .text
    global main

main:
push    rbp
        mov     rbp, rsp
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, msg
        mov     rdx, msglen
        syscall
leave
ret
