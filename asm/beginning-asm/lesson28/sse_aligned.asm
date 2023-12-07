extern printf
section .data
    dummy       db  13
align   16
    spvector1   dd  1.1
                dd  2.2
                dd  3.3
                dd  4.4
    spvector2   dd  1.1
                dd  2.2
                dd  3.3
                dd  4.4

    dpvector1   dq  1.1
                dq  2.2
    dpvector2   dq  3.3
                dq  4.4

    fmt1    db  "Single Precision Vector 1: %f, %f, %f, %f", 10, 0
    fmt2    db  "Single Precision Vector 2: %f, %f, %f, %f", 10, 0
    fmt3    db  "Sum of Single Precision Vecotr 1 and Vector 2: "
            db  " %f, %f, %f, %f", 10, 0
    fmt4    db  "Double Precision Verctor 1: %lf, %lf", 10, 0
    fmt5    db  "Double Precision Verctor 2: %lf, %lf", 10, 0
    fmt6    db  "Sum of Double Precision Vexotr 1 and Vector 2: " 
            db  " %lf, %lf", 10, 0

section .bss
    spvector_res    resq    4
    dpvector_res    resq    4

section .text
    global main

main:
push    rbp
mov     rbp, rsp
        ;sum of two float point vectors
        mov     rsi, spvector1
        mov     rdi, fmt1
        call    printspfp

        mov     rsi, spvector2
        mov     rdi, fmt2
        call    printspfp

        movaps  xmm0, [spvector1]
        addps   xmm0, [spvector2]

        movaps  [spvector_res], xmm0
        mov     rsi, spvector_res
        mov     rdi, fmt3
        call    printspfp
        ;sum of two double point vectors
        mov     rsi, dpvector1
        mov     rdi, fmt4
        call    printdpfp

        mov     rsi, dpvector2
        mov     rdi, fmt5
        call    printdpfp

        movapd  xmm0, [dpvector1]
        addpd   xmm0, [dpvector2]

        movapd  [dpvector_res], xmm0
        mov     rsi, fmt6
        call    printdpfp
leave
ret

printspfp:
push    rbp
mov     rbp, rsp
        movss       xmm0, [rsi]
        cvtss2sd    xmm0, xmm0
        movss       xmm1, [rsi + 4]
        cvtss2sd    xmm1, xmm1
        movss       xmm2, [rsi + 8]
        cvtss2sd    xmm2, xmm2
        movss       xmm3, [rsi + 12]
        cvtss2sd    xmm3, xmm3
        mov         rax, 4
        call        printf
leave
ret

printdpfp:
push    rbp
mov     rbp, rsp
        movsd   xmm0, [rsi]
        movsd   xmm1, [rsi + 8]
        mov     rax, 2
        call    printf
leave
ret


