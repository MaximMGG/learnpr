extern printf

%macro pri 2
    section .data
        %%fmt   db  "First arg %s, and second %s", 10, 0
    section .text
        mov     rdi, %%fmt 
        mov     rsi, %1 
        mov     rdx, %2
        mov     rax, 0
        call    printf
%endmacro

section .data
    str1    db  "Hello", 0
    str2    db  "Bye", 0
section .text
    global main

main:
push    rbp
mov     rbp,    rsp
        pri     str1, str2
        leave
        ret
