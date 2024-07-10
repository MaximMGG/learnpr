section .data
    bNum    db  123
    wNum    dw  12345
    warr    times   5 dw  0

    dNum    dd  12345
    qNum1   dq  12345
    text1   db  "abc", 0
    qNum2   dq  3.1415
    text2   db  "cde", 0

section .bss
    bvar    resb    1
    dvar    resd    1
    wvar    resw    10
    qvar    resq    3
section .text
    global main

main:
    push    rbp
    mov     rbp, rsp
    lea     rax, [bNum]
    mov     rax, bNum
    mov     rax, [bNum]
    mov     [bvar], rax
    lea     rax, [bvar]
    lea     rax, [bNum]
    mov     rax, [wNum]
    lea     rax, [text1]
    mov     rax, text1
    mov     rax, text1 + 1
    lea     rax, [text1 + 1]
    mov     rax, [text1]
    mov     rax, [text1 + 1]
    mov     rsp, rbp
    pop     rbp
    ret

