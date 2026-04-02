extern printf
%macro pr 1
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, %1
    call    strlen
    mov     rdx, rcx
    syscall
%endmacro


section .data
    msg     db      "This is test string!", 10, 0
    fmt     db      "Symbol at position %d", 10, 0
    symbol  db      "r"

section .bss
    copymsg     resb    124

section .text
    global main

main:
push    rbp
mov     rbp, rsp
    xor     rbx, 0
    mov     rsi, msg
    call    strlen 
    lea     rdi, [copymsg]
copyloop:
    mov     al , byte[msg + rbx]
    stosb
    inc     rbx
    loop    copyloop
copyend:
    pr      copymsg 
    mov     rsi, copymsg
    call    strlen
    call    findr
    mov     rdi, fmt
    mov     rsi, r12
    mov     rax, 0
    call    printf
leave
ret


global strlen
strlen:
    xor     rcx, rcx
    mov     r12, rsi
strloop:
    cmp     byte [r12], 0  
    je      endstr
    inc     rcx
    inc     r12
    jmp     strloop
endstr:
ret

global  findr
findr:
    xor     rdi, rdi
    lea     rdi, [copymsg]
    mov     r12, rcx
    mov     rax, 0x72 
findloop:
    repne   scasb
    je      findend
findend:
    sub     r12, rcx
ret
