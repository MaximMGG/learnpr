extern printf
section .data
align 16
    svector1    dd  1.1
                dd  2.1
                dd  3.1
                dd  4.1
                dd  5.1
                dd  6.1
                dd  7.1
                dd  8.1
    dvector1    dq  1.1
                dq  2.2
                dq  3.3 
                dq  4.4

    fmt1        db  "%.1lf ", 0
    NL         db  10, 0
section .bss
    svector_res     resd    8
    dvector_res     resq    4
section .text
    global  main

main:
push    rbp
mov     rbp, rsp
        mov     rdi, svector1
        call    printv
        vmovups ymm0, [svector1]
        vmovups ymm1, [svector1]
        vaddps  ymm2, ymm0, ymm1
        vmovups [svector_res], ymm2
        mov     rdi, svector_res
        call    printv
        mov     rdi, dvector1
        call    printdv
        vmovups ymm0, [dvector1]
        vmovups ymm1, [dvector1]
        vaddpd  ymm2, ymm0, ymm1
        vmovups [dvector_res], ymm2
        mov     rdi, dvector_res
        call    printdv
        mov     rsi, dvector1
        call    printvv
leave
ret



printv:
push    rbp
mov     rbp, rsp
        mov     r8, rdi
        mov     rbx, 0
        mov     rcx, 8
        mov     rax, 1
.loop:
        mov     rdi, fmt1
        movss   xmm0, [r8 + rbx]
        cvtss2sd    xmm0, xmm0
        mov     rax, 1
        push    rcx
        push    r8
        call    printf
        pop     r8
        pop     rcx
        add     rbx, 4
        loop    .loop
        mov     rdi, NL
        call    printf
leave
ret


printdv:
push    rbp
mov     rbp, rsp
        mov     r8, rdi
        mov     rcx, 4 
        mov     rbx, 0
    .loop:
        mov     rdi, fmt1
        mov     rax, 1
        movsd   xmm0, [r8 + rbx]
        push    rcx
        push    r8
        call    printf
        pop     r8
        pop     rcx
        add     rbx, 8
        loop    .loop
        mov     rdi, NL
        call    printf
leave
ret
        
printvv:
section .data
    .fmt    db  "%.1lf, %.1lf, %.1lf, %.1lf", 10, 0
section .text
push    rbp
mov     rbp, rsp
        movsd   xmm0, [rsi]
        movsd   xmm1, [rsi + 8]
        movsd   xmm2, [rsi + 16]
        movsd   xmm3, [rsi + 24]
        mov     rax, 4
        mov     rdi, .fmt
        call    printf
leave
ret


