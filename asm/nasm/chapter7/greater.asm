section .data
    number1     dq  43
    number2     dq  43
    fmt1        db  "NUMBER1 >= NUMBER2", 10, 0
    fmt2        db  "NUMBER1 < NUMBER2", 10, 0

section .bss
section .text
extern printf
    global  main

main:
    push    rbp
    mov     rbp, rsp
    mov     rax, [number1]
    mov     rbx, [number2]
    cmp     rax, rbx
    jge     .greater
    mov     rdi, fmt2
    mov     rax, 0
    call    printf
    jmp     .exit
.greater:
    mov     rdi, fmt1
    mov     rax, 0
    call    printf
.exit:
    mov     rsp, rbp
    pop     rbp
    ret

