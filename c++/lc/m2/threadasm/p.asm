section .text
    global print

print:
push    rbp
mov     rbp, rsp
        mov     rax, 1
        mov     rdi, 1 
        syscall
leave
ret
