extern getlogin_r
extern printf
section .data
    msg     db  "Login is %s , and code is %d", 10, 0
section .bss
    login       resb        128
    code        resq        1
section .text
    global main

main:
push    rbp
mov     rbp, rsp
        mov     rdi, login
        mov     rsi, 30
        call    getlogin_r
        mov     [code],rax
        mov     rdi, msg 
        mov     rsi, login 
        mov     rdx, [code]
        mov     rax, 0
        call    printf
leave
ret
