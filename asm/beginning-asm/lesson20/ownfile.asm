
section .data
    CREATE      equ     1
    PRINT       equ     0
    msg         db      "Hello from file"
    msglen      equ     $ - msg
    path        db      "testf.txt", 0
section .bss

section .text
    global main
main:
push    rbp
mov     rbp, rsp

%IF CREATE
        mov     rax, 85
        mov     rdi, path
        syscall

        mov     rax, 2
        mov     rsi, 2
        mov     rdx, 1
        syscall

        mov     rdi, rax
        mov     rax, 1
        mov     rsi, msg
        mov     rdx, msglen
        syscall
%ENDIF




%IF PRINT
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, path
        mov     rdx, 9
        syscall
%ENDIF


pop     rbp
mov     rsp, rbp
mov     rax, 60
mov     rdi, 0
syscall
