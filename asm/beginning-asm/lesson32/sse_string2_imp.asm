extern printf
section .data
    string1     db  "the quick brown fox jumps over the lazy river", 10, 0
    string2     db  "the quick brown fox jumps over the lazy river", 10, 0
    string3     db  "the quick brown fox jumps over the lazy dog", 10, 0
    fmt1        db  "Strings 1 and 2 are equal.", 10, 0
    fmt11       db  "Strings 1 and 2 differ at position %i.", 10, 0
    fmt2        db  "Strings 2 and 3 are equal.", 10, 0
    fmt22       db  "Strings 2, 3 differ at posotion %i", 10, 0


section .text
    global main

main:
push    rbp
mov     rbp, rsp
;firstly print strings 
        mov     rdi, string1
        xor     rax, rax
        call    printf
        mov     rdi, string2
        xor     rax, rax
        call    printf
        mov     rdi, string3
        xor     rax, rax
        call    printf
;comparing string1 and string2
        mov     rdi, string1
        mov     rsi, string2
        call    pstrcmp
        mov     rdi, fmt1
        cmp     rax, 0
        je      eql1
        mov     rdi, fmt11
    eql1:
        mov     rsi, rax
        xor     rax, rax
        call    printf
;comparing string2 and string3
        mov     rdi, string2
        mov     rsi, string3
        call    pstrcmp
        mov     rdi, fmt2
        cmp     rax, 0
        je      eql2
        mov     rdi, fmt22
    eql2:
        mov     rsi, rax
        xor     rax, rax
        call    printf
    ;leave
leave
ret
;comparing strings
pstrcmp:
push    rbp
mov     rbp, rsp
        xor     rax, rax
        xor     rbx, rbx
    .loop:
        movdqu  xmm1, [rdi + rbx]
        pcmpistri   xmm1, [rsi + rbx], 0x18
        jc      .differ
        jz      .equal
        add     rbx, 16
        jmp     .loop
    .differ:
        mov     rax, rbx
        add     rax, rcx
        inc     rcx
    .equal:
    leave
    ret
