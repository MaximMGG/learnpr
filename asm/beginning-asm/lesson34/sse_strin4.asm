extern print16b
extern printf
section .data
    string1     db  "qdacdekkfijlmdoze"
                db  "becdfgdklkmdddaf"
                db  "fffffffdedeee",10, 0
    string2     db  "e", 0
    string3     db  "a", 0
    fmt         db  "Find all the characters '%s' "
                db  "and '%s' in:", 10, 0
    fmt_oc      db  "I found %ld characters '%s'"
                db  "and '%s'",10, 0
    NL          db  10, 0
section .text
    global main

main:
push    rbp
mov     rbp, rsp
;print symbols
        mov     rdi, fmt
        mov     rsi, string2
        mov     rdx, string3
        call    printf
;print string
        mov     rdi, string1
        call    printf
    ;find in string and print mask
        mov     rdi, string1
        mov     rsi, string2
        mov     rdx, string3
        call    pcharsrch
    ;print count of symbols in string
        mov     rdi, fmt_oc
        mov     rsi, rax
        mov     rdx, string2
        mov     rcx, string3
        call    printf
leave
ret

;--------------------------------------------
;func search in string and return mask
pcharsrch:
push    rbp
mov     rbp, rsp
        sub     rsp, 16; space in stack for saving xmm1
        xor     r12, r12; for count symbols in string
        xor     rcx, rcx; end of string
        xor     rbx, rbx; for adress
        mov     rax, -16; for byte count, 

        pxor    xmm1, xmm1
        pinsrb  xmm1, byte[rsi], 0
        pinsrb  xmm1, byte[rdx], 1

    .loop:
        add     rax, 16
        mov     rsi, 16
        movdqu  xmm2, [rdi + rbx]
        pcmpistrm   xmm1, xmm2, 40h
        setz    cl

        cmp     cl, 0
        je      .gotoprint; end 0 byte do not find
        ;end 0 byte was find
        ;left < 16 bytes
        add     rdi, rbx
        push    rcx
        call    pstrlen
        pop     rcx
        dec     rax
        mov     rsi, rax
    .gotoprint:
        call    print_mask
        popcnt  r13d, r13d
        add     r12d, r13d
        or      cl, cl
        jnz     .exit
        add     rbx, 16
        jmp     .loop
    .exit:
        mov     rdi, NL
        call    printf
        mov     rax, r12
leave
ret

;func find end 0
pstrlen:
push    rbp
mov     rbp, rsp
        sub     rsp, 16
        movdqu  [rbp - 16], xmm0
        mov     rax, -16
        pxor    xmm0, xmm0
    .loop:
        add     rax, 16
        pcmpistri   xmm0, [rdi + rax], 0x08
        jnz     .loop
        add     rax, rcx


        movdqu  xmm0, [rbp - 16]
leave
ret

print_mask:
push    rbp
mov     rbp, rsp
        sub  rsp, 16
        call    reverse_xmm0
        pmovmskb    r13d, xmm0
        movdqu  [rbp - 16], xmm1
        push    rdi
        mov     edi, r13d
        push    rdx
        push    rcx
        call    print16b
        pop     rcx
        pop     rdx
        pop     rdi
        movdqu  xmm1, [rbp - 16]
leave
ret

reverse_xmm0: 
section .data
    .bytereverse    db  15, 14, 14 ,12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0,
section .text
push    rbp
mov     rbp, rsp
        sub     rsp, 16
        movdqu  [rbp - 16], xmm2
        movdqu  xmm2, [.bytereverse]
        pshufb  xmm0, xmm2
        movdqu  xmm2, [rbp - 16]
leave
ret

