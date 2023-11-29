extern printf
section .data
    msg     db  "Test string", 10, 0
    msg2    db  "String length is %i", 10, 0

section .bss
    convert     resb    100

section .text
    global main

main:
    push    rbp
    mov     rbp, rsp
    xor     rax, rax
    mov     rax, msg
    mov     rcx, 4
    mov     rbx, convert
loop:
    mov     [rbx], byte 32 
    inc     rbx
    dec     rcx
    cmp     rcx, 0
    jne     loop
fil:
    mov     dl, [rax]
    mov     [rbx], dl
    inc     rax
    inc     rbx
    cmp     [rax], byte 0
    jne     fil
    mov     dl, 0
    mov     [rax], dl

    mov     rcx, 0
    mov     rax, convert

len:
    cmp     [rax], byte 10
    inc     rax
    inc     rcx
    jne     len


    mov     rdi, convert
    mov     rax, 0
    call    printf

    mov     rdi, msg2
    mov     rsi, rcx
    mov     rax, 0
    call    printf

    leave
    ret

    
