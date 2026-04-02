section .data
    bNum    db  123
    wNum    dw  12345
    dNum    dd  1234567890
    qNum1   dq  12345678901234567890
    qNum2   dq  123456
    qNum3   dq  3.14
section .bss
section .text
    global main
main:
push    rbp
mov     rbp, rsi
        mov     rax, -1             ;fill register rax 1 value
        mov     al, byte [bNum]     ;hight bits of register do not free
        xor     rax, rax            ;free rax register
        mov     al, byte [bNum]     ;now rax contain bNum value
        mov     rax, -1             ;fill register rax 1 value
        mov     ax, word [wNum]     ;gight bits of register do not free
        xor     rax, rax            ;free rax register
        mov     ax, word [wNum]     ;now rax contain wNum value
        mov     rax, -1             ;fill register rax 1 value
        mov     eax, dword [dNum]   ;free hight bits of rax register
        mov     rax, -1             ;fill register rax 1 value
        mov     rax, qword [qNum1]  ;free hight bits of rax register
        mov     qword [qNum2], rax  ;
        mov     rax, 123456
        movq    xmm0, [qNum3]
mov rsp, rbp
pop rbp
ret
    
