extern print16b
extern printf
section .data
    string1     db  "eeAecdkkFijlmeoZa"
                db  "bcefgeKlkmeDad"
                db  "fdsafadfaseeE", 10, 0
    startrange  db  "A", 10, 0
    stoprange   db  "Z", 10, 0
    NL          db  10, 0
    fmt         db  "Find the uppercase letter in:", 10, 0
    fmt_oc      db  "I found %ld uppercase letters", 10, 0

section .text
    global main

main:
push    rbp
mov     rbp, rsp
;print source string
        mov     rdi, fmt
        xor     rax, rax
        call    printf
        mov     rdi, string1
        xor     rax, rax
        call    printf
    ;search in string
        mov     rdi, string1
        mov     rsi, startrange
        mov     rdx, stoprange
        call    prangesrch
    ;print count of find symbols
        mov     rdi, fmt_oc
        mov     rsi, rax
        xor     rax, rax
        call    printf
leave
ret

;----------------------------------------
;func of search and print mask
prangesrch:
push    rbp
mov     rbp, rsp
        sub     rsp, 16 ; space in stack for xmm1 saving
        xor     r12, r12 ; for search count
        xor     rcx, rcx ; for end of string
        xor     rbx, rbx  ; for adress multiply
        mov     rax, -16  ; for evoid ZF setting
    ;xmm1 filling
        pxor    xmm1, xmm1
        pinsrb  xmm1, byte[rsi], 0
        pinsrb  xmm1, byte[rdx], 1
    .loop:
        add     rax, 16
        mov     rsi, 16
        movdqu  xmm2, [rdi + rbx]
        pcmpistrm   xmm1, xmm2, 01000100b  ;equal each method | bit mask in xmm0
        setz    cl
    ;if end 0 was find, set position
        cmp     cl, 0
        je      .gotoprint
        ;end 0 was find
        ;left less the 16 bytes
        ;rdi contein string adress
        ;rbx conteins number bytes in blocks, 
        add     rdi, rbx ; take only tail this string
        push    rcx      ; save register
        call    pstrlen
        pop     rcx
        dec     rax ; length withour end 0
        mov     rsi, rax 

    ;mask print
    .gotoprint:
        call    print_mask 
    ;continue finding metches
        popcnt  r13d, r13d ; count bints == 1
        add     r12d, r13d ; save number of matching in r12
        or      cl, cl    ; end byte was find?
        jnz     .exit
        add     rbx, 16
        jmp     .loop
    .exit:
        mov     rdi, NL
        call    printf
        mov     rax, r12 ;return number of metches
leave
ret


;--------------------------------------------------------
pstrlen:
push    rbp
mov     rbp, rsp
        sub     rsp, 16
        movdqu  [rbp - 16], xmm0
        mov     rax, -16
        pxor    xmm0, xmm0
    .loop:
        add     rax, 16
        pcmpistri xmm0, [rdi + rax], 0x08 ; equal each method
        jnz     .loop
        add     rax, rcx
        movdqu  xmm0, [rbp + 16]
leave
ret


;-----------------------------------------------------------
;func pring mask
;xmm0 have mask
;rsi conteins count printed bytes (16 or less)
print_mask:
push    rbp
mov     rbp, rsp
        sub     rsp, 16
        call    revers_xmm0
        pmovmskb    r13d, xmm0
        movdqu  [rbp - 16], xmm1 ;save xmm1 in stack before calling printf
        push    rdi
        mov     edi, r13d  ;conteins printed mask
        push    rdx
        push    rcx
        call    print16b
        pop     rcx
        pop     rdx
        pop     rdi
        movdqu  xmm1, [rbp - 16]
leave
ret


;----------------------------------------------------------
;reversal func
revers_xmm0:
section .data
    .bytereverse    db  15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
section .text
push    rbp
mov     rbp, rsp
        sub     rsp, 16
        movdqu  [rsp - 16], xmm2
        movdqu  xmm2, [.bytereverse]
        pshufb  xmm0, xmm2
        movdqu  xmm2, [rsp + 16]
leave
ret



