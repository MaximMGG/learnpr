extern printf
section .data
    mmm     db  "%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c", 10, 0
    char    db  "abcdifjklmnoprst"
section .bss
section .text
    global main

main:
push    rbp
mov     rbp, rsp
        movdqu  xmm0, [char]
        mov     rdi, mmm
        pextrb  esi, xmm0, 0
        pextrb  edx, xmm0, 1
        pextrb  ecx, xmm0, 2
        pextrb  r8d, xmm0, 3
        pextrb  r9d, xmm0, 4
        sub     rsp, 8
        pextrb  eax, xmm0, 15
        push rax
        pextrb  eax, xmm0, 14
        push rax
        pextrb  eax, xmm0, 13
        push rax
        pextrb  eax, xmm0, 12
        push rax
        pextrb  eax, xmm0, 11
        push rax
        pextrb  eax, xmm0, 10
        push rax
        pextrb  eax, xmm0, 9
        push rax
        pextrb  eax, xmm0, 8
        push rax
        pextrb  eax, xmm0, 7
        push rax
        pextrb  eax, xmm0, 6
        push rax
        pextrb  eax, xmm0, 5
        push rax

        ; mov     [rsp], eax
        ; sub     rsp, 8
        ; pextrb  eax, xmm0, 14
        ; mov     [rsp], eax
        ; sub     rsp, 8
        ; pextrb  eax, xmm0, 13
        ; mov     [rsp], eax
        ; sub     rsp, 8
        ; pextrb  eax, xmm0, 12
        ; mov     [rsp], eax
        ; sub     rsp, 8
        ; pextrb  eax, xmm0, 11
        ; mov     [rsp], eax
        ; sub     rsp, 8
        ; pextrb  eax, xmm0, 10
        ; mov     [rsp], eax
        ; sub     rsp, 8
        ; pextrb  eax, xmm0, 9
        ; mov     [rsp], eax
        ; sub     rsp, 8
        ; pextrb  eax, xmm0, 8
        ; mov     [rsp], eax
        ; sub     rsp, 8
        ; pextrb  eax, xmm0, 7
        ; mov     [rsp], eax
        ; sub     rsp, 8
        ; pextrb  eax, xmm0, 6
        ; mov     [rsp], eax
        ; sub     rsp, 8
        ; pextrb  eax, xmm0, 5
        ; mov     [rsp], eax
        ; sub     rsp, 8
        xor     rax, rax
        pxor    xmm0, xmm0
        call    printf
leave
ret
