extern printf
section .data
    msg     db      "Hello world!", 0
    len     equ     $ - msg
section .bss
    buf     resb    64
section .text
    global main

main:
push    rbp
mov     rbp, rsp
        mov     rsi, msg
        mov     rdi, buf
        mov     rcx, len
        rep     movsb
        inc     rdi
        mov     byte[rdi], 10
        inc     rdi
        mov     byte[rdi], 0

        mov     rdi, buf
        xor     rax, rax
        call    printf 
leave
ret

