section .data

section .bss

section .text
    global do_sum

do_sum:
push    rbp
mov     rbp, rsp
        addpd   xmm0, xmm1
leave
ret

section .text
    global vec_sum

vec_sum:
push    rbp
mov     rbp, rsp
        movsd   xmm0, [rdi]
        movsd   xmm1, [rdi + 8]
        addsd   xmm0, xmm1
        movsd   [rdi], xmm0
leave
ret


