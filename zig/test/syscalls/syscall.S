
    .intel_syntax noprefix
    .global _start

_start:
    SYS_exit = 60
    SYS_write = 1


    mov     rax, SYS_write
    mov     rdi, 1
    lea     rsi, [rip + hello_world]
    mov     rdx, hello_world_end - hello_world
    syscall

    mov     rax, SYS_exit
    mov     rdi, 0
    syscall


hello_world:
    .ascii "Hello world!\n"
hello_world_end:
    
