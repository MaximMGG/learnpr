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

section .data
        x       dd      1222
        y       dd      1333
        z       dq      11111111
        name    db      "Alice", 0
section .bss
        xx      resd    1
        yy      resd    1
        zz      resd    1
        name2   resb    10
section .text
    global main
   
main:
push    rbp
mov     rbp, rsp
        mov     rdi, xx
        mov     rsi, x
        mov     rdx, 4
        call    mem_cpy_asm
        leave
        ret






