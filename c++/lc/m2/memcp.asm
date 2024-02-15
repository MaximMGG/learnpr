section .text
    global mem_cpy_asm

mem_cpy_asm:
push    rbp
mov     rbp, rsp
;rdi    dest
;rsi    source
;rdx     size
        mov     [rbp - 8], rdi
        mov     [rbp - 16], rsi
        mov     [rbp - 24], rdx
        xor     rcx, rcx
        mov     r10, [rbp - 16]; source
        mov     r11, [rbp - 8]; dest
    .loop:
        cmp     rcx, qword [rbp - 24]
        je      .exit

        mov     rax, [r10]
        inc     r10
        mov     byte [r11], al
        inc     r11
        inc     rcx
        jmp     .loop

    .exit:
        leave
        ret

