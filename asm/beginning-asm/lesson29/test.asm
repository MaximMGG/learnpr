extern printf
section .data
align 16


    arr     db  1
            db  2
            db  3
            db  4
            db  5
            db  6
            db  7
            db  8
            db  9
            db  10
            db  11
            db  12
            db  13
            db  14
            db  15
            db  16

    pinter  db  0
    msg     db  "Print byte %d", 10, 0
section .bss
align 16
    result  resd    4
section .text
    global main

main:
push    rbp
mov     rbp, rsp
        movdqa  xmm0, [arr]
        mov     rcx, 16
        mov     rdx, 0
        xor     rax, rax
pack:
        pextrb  rax, xmm0, 2
        pinsrb  xmm1, al, 2
        inc     rdx
        loop    pack
        movdqa  [result], xmm1
        mov     rcx, 16
        xor     rax, rax
        xor     rdx, rdx
        movdqa  xmm0, [result]
print:
        pextrb  rax, xmm0, 4
        mov     byte [rsi], al
        mov     rdi, msg
        mov     rax, 0
        call    printf
        loop    print
leave
ret
