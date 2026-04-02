section .data

section .bss

section .text
    global sum

sum:
push    rbp
mov     rbp, rsp
        mov     rax, rdi
        add     rax, rsi
leave
ret


