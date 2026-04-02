extern printf
section .data
    string1     db  "the quick brown fox jumps over the lazy river", 0
    string2     db  "e", 0
    fmt1        db  "This is our string: %s", 10, 0 
    fmt2        db  "The first '%s' is at position %d.", 10, 0
    fmt3        db  "The last '%s' is at position %d.", 10, 0
    fmt4        db  "The character '%s' didn't show up!", 10, 0

section .text
    global main

main:
push    rbp
mov     rbp, rsp
        mov     rdi, fmt1
        mov     rsi, string1
        xor     rax, rax
        call    printf
    ;search first matching
        mov     rdi, string1
        mov     rsi, string2
        call    pstrscan_f
        cmp     rax, 0
        je      no_show
        mov     rdi, fmt2
        mov     rsi, string2
        mov     rdx, rax
        xor     rax, rax
        call    printf
    ;search last matching
        mov     rdi, string1
        mov     rsi, string2
        call    pstrscan_l
        mov     rdi, fmt3
        mov     rsi, string2
        mov     rdx, rax
        xor     rax, rax
        call    printf
        jmp     exit
    no_show:
        mov     rdi, fmt4
        mov     rsi, string2
        xor     rax, rax
        call    printf
exit:
leave
ret
;search first matching
pstrscan_f
push    rbp
mov     rbp, rsp
        xor     rax, rax
        pxor    xmm0, xmm0
        pinsrb  xmm0, [rsi], 0
    .block_loop:
        pcmpistri   xmm0, [rdi + rax], 00000000b
        jc      .found
        jz      .none
        add     rax, 16
        jmp     .block_loop
    .found:
        add     rax, rcx
        inc     rax
        leave
        ret
    .none:
        xor     rax, rax
        leave
        ret
;search last matching
pstrscan_l:
push    rbp
mov     rbp, rsp
push    r12
push    rbx
        xor     rax, rax
        pxor    xmm0, xmm0
        pinsrb  xmm0, [rsi], 0
        xor     r12, r12
    .block_loop:
        pcmpistri   xmm0, [rdi + rax], 01000000b
        setz    bl
        jc      .found
        jz      .done
        add     rax, 16
        jmp     .block_loop
    .found:
        mov     r12, rax
        add     r12, rcx
        inc     r12
        cmp     bl, 1
        je      .done
        add     rax, 16
        jmp     .block_loop
pop r12
pop rbx
leave
ret
    .done:
        mov     rax, r12
        pop     r12
        pop     rbx
        leave
        ret

