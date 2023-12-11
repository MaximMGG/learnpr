extern printf
section .data
    fmt0    db  "These are the numbers in memory: ", 10, 0
    fmt00   db  "This is xmm0: ", 10, 0
    fmt1    db  "%d ", 0
    fmt2    db  "Shuffle-broadcase double word %i:", 10, 0
    fmt3    db  "%d %d %d %d", 10, 0
    fmt4    db  "Shuffle-reverse double words: ", 10, 0
    fmt5    db  "Shuffle-reversse packed bytes in xmm0:", 10, 0
    fmt6    db  "Shuffle-rotate left:", 10, 0
    fmt7    db  "Shuffle-rotate right:", 10, 0
    fmt8    db  "%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c", 10, 0
    fmt9    db  "Packed bytes in xmm0:", 10, 0
    NL      db  10, 0

    number1  dd 1
    number2  dd 2
    number3  dd 3
    number4  dd 4

    char    db  "abcdefghijklmnop", 0
    bytereverse db  15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0

section .bss
section .text
    global main

main:
push    rbp
mov     rbp, rsp
        sub     rsp, 32  ;place in stack for source xmm0 and changed xmm0
;shuffling dwords
;print in reversal order
        mov     rdi, fmt0
        call    printf
        mov     rdi, fmt1
        mov     rsi, [number4]
        xor     rax, rax
        call    printf
        mov     rdi, fmt1
        mov     rsi, [number3]
        xor     rax, rax
        call    printf
        mov     rdi, fmt1
        mov     rsi, [number2]
        xor     rax, rax
        call    printf
        mov     rdi, fmt1
        mov     rsi, [number1]
        xor     rax, rax
        call    printf
        mov     rdi, NL
        call    printf
    ;fill xmm0 numbers
        pxor    xmm0, xmm0
        pinsrd  xmm0, dword[number1], 0
        pinsrd  xmm0, dword[number2], 1
        pinsrd  xmm0, dword[number3], 2
        pinsrd  xmm0, dword[number4], 3
        movdqu  [rbp - 16], xmm0
        mov     rdi, fmt00
        call    printf
        movdqu  xmm0, [rbp - 16]
        call    print_xmm0d
        movdqu  xmm0, [rbp - 16]

    ;shuffling in random order
        movdqu  xmm0, [rbp - 16]
        pshufd  xmm0, xmm0, 00000000b
        mov     rdi, fmt2
        mov     rsi, 0
        movdqu  [rbp - 32], xmm0 ; printf setting xmm0 -> 0, here we need to push it in stack
        call    printf
        movdqu  xmm0, [rbp - 32]
        call    print_xmm0d
    ;shuffling 1 dword with index 1
        movdqu  xmm0, [rbp - 16]
        pshufd  xmm0, xmm0, 01010101b
        mov     rdi, fmt2
        mov     rsi, 1
        movdqu  [rbp - 32], xmm0
        call    printf
        movdqu  xmm0, [rbp - 32]
        call    print_xmm0d
    ;shuffling 1 dword with index 2
        movdqu  xmm0, [rbp - 16]
        pshufd  xmm0, xmm0, 10101010b
        mov     rdi, fmt2
        mov     rsi, 2
        movdqu  [rbp - 32], xmm0
        call    printf
        movdqu  xmm0, [rbp - 32]
        call    print_xmm0d
    ;shuffling 1 dword with index 3
        movdqu  xmm0, [rbp - 16]
        pshufd  xmm0, xmm0, 11111111b
        mov     rdi, fmt2
        mov     rsi, 3
        movdqu  [rbp - 32], xmm0
        call    printf
        movdqu  xmm0, [rbp - 32]
        call    print_xmm0d

    ;shuffling in revers order
        movdqu  xmm0, [rbp - 16]
        pshufd  xmm0, xmm0, 00011011b
        mov     rdi, fmt4
        movdqu  [rbp - 32], xmm0
        call    printf
        movdqu  xmm0, [rbp - 32]
        call    print_xmm0d
    ;moving; rotating
        movdqu  xmm0, [rbp - 16]
        pshufd  xmm0, xmm0, 10010011b
        mov     rdi, fmt6
        movdqu  [rbp - 32], xmm0
        call    printf
        movdqu  xmm0, [rbp - 32]
        call    print_xmm0d
    ;right rotating
        movdqu  xmm0, [rbp - 16]
        pshufd  xmm0, xmm0, 00111001b
        mov     rdi, fmt7
        movdqu  [rbp - 32], xmm0
        call    printf
        movdqu  xmm0, [rbp - 32]
        call    print_xmm0d
    ;byte shuffling
        mov     rdi, fmt9
        call    printf
        movdqu  xmm0, [char]
        movdqu  [rbp - 32], xmm0
        call    print_xmm0b
        movdqu  xmm0, [rbp - 32]
        movdqu  xmm1, [bytereverse]
        pshufb  xmm0, xmm1
        mov     rdi, fmt5
        movdqu  [rbp - 32], xmm0
        call    printf
        movdqu  xmm0, [rbp - 32]
        call    print_xmm0b
leave
ret


print_xmm0d:
push    rbp
mov     rbp, rsp
        mov     rdi, fmt3
        pextrd  esi, xmm0, 3
        pextrd  edx, xmm0, 2
        pextrd  ecx, xmm0, 1
        pextrd  r8d, xmm0, 0
        call    printf
leave
ret

print_xmm0b:
push    rbp
mov     rbp, rsp
sub     rsp, 8
        mov     rdi, fmt8
        xor     rax, rax
        pextrb  esi, xmm0, 0
        pextrb  edx, xmm0, 1
        pextrb  ecx, xmm0, 2
        pextrb  r8d, xmm0, 3
        pextrb  r9d, xmm0, 4
        pextrb  eax, xmm0, 15
        push    rax
        pextrb  eax, xmm0, 14
        push    rax
        pextrb  eax, xmm0, 13
        push    rax
        pextrb  eax, xmm0, 12
        push    rax
        pextrb  eax, xmm0, 11
        push    rax
        pextrb  eax, xmm0, 10
        push    rax
        pextrb  eax, xmm0, 9
        push    rax
        pextrb  eax, xmm0, 8
        push    rax
        pextrb  eax, xmm0, 7
        push    rax
        pextrb  eax, xmm0, 6
        push    rax
        pextrb  eax, xmm0, 5
        push    rax
        xor     rax, rax
        pxor    xmm0, xmm0
        call    printf
leave
ret


