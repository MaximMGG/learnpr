extern printf

section .data
    strng   db "ABCDE", 0
    strngLen equ $ - strng - 1 ; string length without 0
    fmt1    db "The original string: %s", 10, 0
    fmt2    db "Thre reversed string: %s", 10, 0
section .bss
section .text
    global main

main:
            push    rbp
            mov     rbp, rsp

            mov     rdi, fmt1
            mov     rsi, strng
            mov     rax, 0
            call    printf

            xor     rax, rax
            mov     rbx, strng ; adress of strng in rbx register
            mov     rcx, strngLen; length of strng
            mov     r12, 0; register r12 lick pointer
pushLoop:
            mov     al, byte [rbx+r12] ; write symbol in al register
            push    rax                     ; push value of rax in stack
            inc     r12     
            loop    pushLoop

            mov     rbx, strng
            mov     rcx, strngLen
            mov     r12, 0
            popLoop:
                pop     rax     ; pop smbol from stack
                mov     byte [rbx + r12], al
                inc     r12
                loop    popLoop
                mov     byte [rbx + r12], 0  ; symbol 0 in the end of string

            mov     rdi, fmt2
            mov     rsi, strng
            mov     rax, 0
            call    printf

            mov rsp, rbp
            pop rbp
            ret



