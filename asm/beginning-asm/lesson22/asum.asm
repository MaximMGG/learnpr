section .data
section .text
global asum
asum:
    section .text
    push    rbp 
    mov     rbp, rsp
    mov     rcx, rsi ; length of array
    mov     rbx, rdi ; pointer to array
    mov     r12, 0
    movsd   xmm0, qword[rbx + r12 * 8]
    dec     rcx
sloop:
    inc     r12
    addsd   xmm0, qword[rbx + r12 * 8]
    loop    sloop
leave
ret
