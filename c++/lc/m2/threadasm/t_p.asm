section .text

    global t_print

t_print:
push    rbp
mov     rbp, rsp
        mov     rax, 1
        mov     rdi, 1
        syscall
leave
ret
