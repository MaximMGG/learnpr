section .data
    hello   db  "Hello ", 0
    hellolen    equ $ - hello - 1
    last    db  " how are you doing today?", 0
    lastlen     equ $ - last

section .bss
    buf     resb    256

section .text
    global greets

greets:
    push    rdi
    mov     rcx, hellolen 
    mov     rdx, hello
    mov     r8, buf
.loop1:
    mov     al, byte[rdx]
    mov     byte[r8], al
    inc     r8
    inc     rdx 
    loop    .loop1
    pop     rdi
    push    r8
    call    strlen
    pop     r8
    mov     rcx, rax
    mov     rdx, rdi
    dec     rcx
.loop2:
    mov     al, byte[rdx]
    mov     byte[r8], al
    inc     rdx
    inc     r8
    loop    .loop2

    mov     rdx, last
    mov     rcx, lastlen
.loop3:
    mov     al, byte[rdx]
    mov     byte[r8], al
    inc     rdx
    inc     r8
    loop    .loop3

    mov     rax, buf
ret



strlen:
    xor     rcx, rcx
    mov     r8, rdi
.loop:
    cmp     byte [r8], 0
    je      .exit
    inc     r8
    inc     rcx
    jmp     .loop
.exit:
    inc     rcx
    mov     rax, rcx
ret


