section .data
    msg     db  "Hello world!", 10, 0

section .bss
section .text
extern printf
    global main

main:
    push    rbp
    mov     rbp, rsp
    mov     rdi, msg
    mov     rax, 0
    call    printf
    mov     rsp, rbp
    pop     rbp
    ret
    
