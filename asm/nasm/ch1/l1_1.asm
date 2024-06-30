section .data
    msg     db  "Hello wolrd!", 10, 0
    msg_len equ $ - msg

section .text
    global main
main:
push    rbp
mov     rbp, rsp
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, msg
        mov     rdx, msg_len
        syscall
        pop     rbp
        mov     rsp, rbp
        mov     rax, 60
        syscall

