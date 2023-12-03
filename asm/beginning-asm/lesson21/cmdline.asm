extern printf
section .data
    msg     db  "The command and arguments: ", 10, 0
    fmt     db  "%s", 10, 0
section .bss
section .text
    global main

main:
push    rbp
mov     rbp, rsp
        mov     r12, rdi
        mov     r13, rsi
        ;print header
        mov     rdi, msg
        call    printf
        mov     r14, 0
        ;print name of command ond argument
.ploop:
        mov     rdi, fmt
        mov     rsi, qword[r13 + r14 * 8]
        call    printf
        inc     r14
        cmp     r14, r12
        jl      .ploop
leave
ret
    
