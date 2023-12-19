global _print_m


_print_m:
section .data
    NL      db  10
section .text
    mov     r8, rdi
    mov     rcx, rsi
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, r8
    mov     rdx, rcx
    syscall
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, NL
    mov     rdx, 1
    syscall
ret
