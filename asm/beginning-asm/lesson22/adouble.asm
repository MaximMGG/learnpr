section .data
section .text
global  adouble
adouble:
    section .text
    mov     rcx, rsi
    mov     rbx, rdi
    mov     r12, 0
aloop:
    movsd   xmm0, qword[rbx + r12 * 8]
    addsd   xmm0, xmm0
    movsd   qword[rbx + r12 * 8], xmm0
    inc     r12
    loop    aloop
ret
