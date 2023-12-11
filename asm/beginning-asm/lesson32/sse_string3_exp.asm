extern printf
section .data
    string1     db  "the quick brown fox jumps over the lazy river" 
    string1len  equ $ - string1
    string2     db  "the quick brown fox jumps over the lazy river" 
    string2len  equ $ - string2
    string3     db  "the quick brown fox jumps over the lazy dog" 
    string3len  equ $ - string3

    fmt1        db  "Strings 1 and 2 are equal.", 10, 0
    fmt11       db  "Strings 1 and 2 differ at position %d.", 10, 0
    fmt2        db  "Strings 2 and 3 are equal.", 10, 0
    fmt22       db  "Strings 2, 3 differ at posotion %d", 10, 0

section .bss
    buffer  resb    128 
section .text
    global main

main:
push    rbp
mov     rbp, rsp
;comparing 1 and 2
        mov     rdi, string1
        mov     rsi, string2
        mov     rdx, string1len
        mov     rcx, string2len
        call    pstrcmp
        push    rax
;creating string with new line symbol and zero symbol
        mov     rsi, string1
        mov     rdi, buffer
        mov     rcx, string1len
        rep     movsb
        inc     rdi
        mov     byte[rdi], 10
        inc     rdi
        mov     byte[rdi], 0
    ;print
        mov     rdi, buffer
        mov     rax, 0 
        call    printf  
    ;string2
        mov     rsi, string2
        mov     rdi, buffer
        mov     rcx, string2len
        rep     movsb
        mov     byte[rdi], 10
        inc     rdi
        mov     byte[rdi], 0
    ;print
        mov     rdi, buffer
        xor     rax, rax
        call    printf
    ;print result of comparing
        pop     rax
        mov     rdi, fmt1
        cmp     rax, 0
        je      eql1
        mov     rdi, fmt11
    eql1:
        mov     rsi, rax
        xor     rax, rax
        call    printf
    ;
    ;
    ;comparing string2 and string3
        mov     rdi, string2
        mov     rdi, string3
        mov     rdx, string2len
        mov     rcx, string3len
        call    pstrcmp
        push    rax
    ;print string3 and result
        mov     rsi, string3
        mov     rdi, buffer
        mov     rcx, string3len
        rep     movsb
        mov     byte[rdi], 10
        inc     rdi
        mov     byte[rdi], 0
    ;print
        mov     rdi, buffer
        xor     rax, rax
        call    printf
    ;print result of comparing
        pop     rax
        mov     rdi, fmt2
        cmp     rax, 0
        je      eql2
        mov     rdi, fmt22
    eql2:
        mov     rsi, rax
        xor     rax, rax
        call    printf
    leave
    ret

pstrcmp:
push    rbp
mov     rbp, rsp
        xor     rbx, rbx
        mov     rax, rdx ; length of first string in rax
        mov     rdx, rcx ; length of second string in rdx
        xor     rcx, rcx   ; index
    .loop:
        movdqu  xmm1, [rdi + rax]
        pcmpestri   xmm1, [rsi + rbx], 0x18
        jc      .differ
        jz      .equal
        add     rbx, 16
        sub     rax, 16
        sub     rdx, 16
        jmp     .loop
    .differ:
        mov     rax, rbx
        add     rax, rcx  ;position different symbol in rcx
        inc     rax
        jmp     exit
    .equal:
        xor     rax, rax
    exit:
    leave
    ret

