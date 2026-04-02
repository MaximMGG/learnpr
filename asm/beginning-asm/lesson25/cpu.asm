extern printf
section .data
    fmt_no_see  db  "This cpu does note support SSE", 10, 0
    fmt_sse42   db  "This cpu supports SSE 4.2", 10, 0
    fmt_sse41   db  "This cpu supports SSE 4.1", 10, 0
    fmt_ssse3   db  "This cpu supports SSSE 3", 10, 0
    fmt_sse3    db  "This cpu supports SSE 3", 10, 0
    fmt_sse2    db  "This cpu supports SSE 2", 10, 0
    fmt_sse     db  "This cpu supports SSE", 10, 0
section .bss
section .text
    global main

main:
push    rbp
mov     rbp, rsp
        call    cpu_sse ; return 1 in rax, if sse is supports, or 0
leave
ret

cpu_sse:
        push    rbp
        mov     rbp, rsp
        xor     r12, r12  ; flag SSE
        mov     eax, 1  ; colling flags chorcteristics CPU
        cpuid
        ; checking support SSE
        test    edx, 2000000h
        jz      sse2
        xor     rax, rax
        mov     rdi, fmt_sse
        push    rcx
        push    rdx
        call    printf
        pop     rdx
        pop     rcx
    sse2:
        test    edx, 4000000h
        jz      sse3
        mov     r12, 1
        xor     rax, rax
        mov     rdi, fmt_sse2
        push    rcx
        push    rdx
        call    printf
        pop     rdx
        pop     rcx
    sse3:
        test    ecx, 1
        jz      ssse3
        mov     r12, 1
        xor     rax, rax
        mov     rdi, fmt_sse3
        push    rcx
        call    printf
        pop     rcx
    ssse3:
        test    ecx, 9h
        jz      sse41
        mov     r12, 1
        xor     rax, rax
        mov     rdi, fmt_ssse3
        push    rcx
        call    printf
        pop     rcx
    sse41:
        test    ecx, 80000h
        jz      sse42
        mov     r12, 1
        xor     rax, rax
        mov     rdi, fmt_sse41
        push    rcx
        call    printf
        pop     rcx
    sse42:
        test    ecx, 100000h
        jz      wrapup
        mov     r12, 1
        xor     rax, rax
        mov     rdi, fmt_sse42
        push    rcx
        call    printf
        pop     rcx

    wrapup:
        cmp     r12, 1
        je      sse_ok
        mov     rdi, fmt_no_see
        xor     rax, rax
        call    printf
        jmp     the_exit
    sse_ok:
        mov     rax, r12
    the_exit:
    leave
    ret

