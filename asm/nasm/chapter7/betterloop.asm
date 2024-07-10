section .data
    number  dq  5
    msg     db  "The sum from 0 to %ld is %ld", 10, 0

section .bss

section .text
extern printf

    global main

main:
    push    rbp
    mov     rbp, rsp
    xor     rax, rax
    mov     rcx, [number]
    
jloop
    add     rax, rcx
    loop    jloop

    mov     rdi, msg
    mov     rsi, [number]
    mov     rdx, rax
    mov     rax, 0
    call    printf
    mov     rsp, rbp
    pop     rbp
    ret
