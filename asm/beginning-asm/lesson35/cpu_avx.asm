extern printf
section .data
    fmt_noavx   db  "This cpu does not support AVX.", 10, 0
    fmt_avx     db  "This cpu supports AVX", 10, 0
    fmt_noavx2  db  "This cpu does not support AVX2.", 10, 0
    fmt_avx2    db  "This cpu supports AVX2.", 10, 0
    fmt_noavx512    db  "This cpu does not support AVX-512.", 10, 0
    fmt_avx512  db  "This cpu supports AVX-512.", 10, 0

section .text
    global  main

main:
push    rbp
mov     rbp, rsp
        call    cpu_sse
leave
ret


cpu_sse:
push    rbp
mov     rbp, rsp
        ;jeck supports avx
        mov     eax, 1 ;request flag charcter cpu
        cpuid
        mov     eax, 28 ;jeck bit 28 in ecx
        bt      ecx, eax
        jnc     no_avx
        xor     rax, rax
        mov     rdi, fmt_avx
        call    printf
        ;jeck supports avx2
        mov     eax, 7
        mov     ecx, 0
        cpuid
        mov     eax, 5 ;jeck bit 5 in ebx
        bt      ebx, eax
        jnc     the_exit
        xor     rax, rax
        mov     rdi, fmt_avx2
        call    printf
        ;jeck avx-512 functional
        mov     eax, 7
        mov     ecx, 0
        cpuid
        mov     eax, 16  ; jeck bit 16 in ebx
        bt      ebx, eax
        jnc     no_avx512
        xor     rax, rax
        mov     rdi, fmt_avx512
        call    printf
        jmp     the_exit
    no_avx:
        mov     rdi, fmt_noavx
        xor     rax, rax
        call    printf
        xor     rax, rax
        jmp     the_exit
    no_avx2: 
        mov     rdi, fmt_noavx2
        xor     rax, rax
        call    printf
        xor     rax, rax
        jmp     the_exit
    no_avx512:
        mov     rdi, fmt_noavx512
        xor     rax, rax
        call    printf
        xor     rax, rax
        jmp     the_exit
    the_exit:
leave
ret


