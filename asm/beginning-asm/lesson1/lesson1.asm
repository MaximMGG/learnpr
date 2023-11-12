;hello.asm
section .data
    msg db "Hello, world!", 0
    len equ $ - msg ; equ is constant
section .bss
section .text
    global main

main: 
    mov rax, 1  ; 1 = write
    mov rdi, 1  ; 1 = to stdout
    mov rsi, msg  ; string to display on rsi
    mov rdx, len ; length of the string, wighout 0
    syscall     ; display the string
    mov rax, 60 ; 60 = exit
    mov rdi, 0  ; 0 = success exit code
    syscall    ; quit

