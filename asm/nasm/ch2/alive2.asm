section .data
    msg1    db  "Hello world!", 0
    msg2    db  "Alive and Kicking!", 0
    radius  dd  357
    pi      dq  3.14
    fmtstr  db  "%s", 10, 0
    fmtflt  db  "%lf", 10, 0
    fmtint  db  "%d", 10, 0

section .bss
section .text
extern printf
    global main

main:
    push    rbp
    mov     rbp, rsp
    mov     rdi, fmtstr
    mov     rsi, msg1
    mov     rax, 0
    call    printf
    mov     rdi, fmtstr
    mov     rsi, msg2
    mov     rax, 0
    call    printf
    mov     rax, 1
    mov     rdi, fmtflt
    movq    xmm0, [pi]
    call    printf
    mov     rdi, fmtint
    mov     rsi, [radius]
    mov     rax, 0
    call    printf
    mov     rsp, rbp
    pop     rbp
    mov     rax, 60
    mov     rdi, 0
    syscall

