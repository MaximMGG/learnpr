section .data

section .bss

section .text
    global sum2

sum2:
push    rbp
mov     rbp, rsp
    mov     [rbp - 8], edi
    mov     [rbp - 12], esi
    mov     eax, [rbp - 8]
    add     eax, [rbp - 12]
leave
ret
