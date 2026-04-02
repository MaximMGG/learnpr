section .text
    global thread_run

thread_run:
push    rbp
mov     rbp, rsp
        push    rax
        mov     rax, 57
        syscall

        cmp     rax, 0
        mov     r10, rax
        pop     rax
        je      .invoke

        mov     rax, r10
        ret

.invoke:
        call    rax

        mov     rsp, rbp
        pop     rbp
        mov     rax, 60
        mov     rdi, 0
        syscall

    global  thread_wait
thread_wait:
push    rbp
mov     rbp, rsp
        sub     rbp, 4
        mov     rdi, rax
        mov     rax, 61
        mov     rsi, rsp
        mov     rdx, 0
        mov     r10, 0
        syscall

        mov     rax, [rsp]
        add     rbp, 4
        mov     rsp, rbp
        pop     rbp
        ret

