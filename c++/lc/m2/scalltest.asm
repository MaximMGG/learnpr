section .data

section .bss
    cwdd     resb  200
section .text
    global main
main:
push    rbp
mov     rbp, rsp
        mov     rax, 79
        mov     rdi, cwdd
        mov     rsi, 200
        syscall
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, cwdd
        mov     rdx, 200
        syscall
        leave
        ret
