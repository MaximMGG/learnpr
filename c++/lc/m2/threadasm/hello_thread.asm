extern thread_run
extern thread_wait
extern print

section .data
    log_msg         db  10, "Creating a thread ...", 10, 0
    log_msg_len     equ $ - log_msg

    thread_msg      db  "Hello from thread 1!", 10, 0
    thread_msg_len  equ $ - thread_msg

    thread2_msg     db  "Hello from thread 2!", 10, 0
    thread2_msg_len equ $ - thread2_msg

    parent_msg      db  "Hello from parent!", 10, 0
    parent_msg_len  equ $ - parent_msg
        
section .text
    global main
main:
push    rbp
mov     rbp, rsp
        call    .log
        mov     rax, print
        mov     rdi, thread_msg
        mov     rsi, thread_msg_len
        call    thread_run

        call    thread_wait
        call    .pmsg

        call    .log
        mov     rax, print
        mov     rdi, thread2_msg
        mov     rsi, thread2_msg_len
        call    thread_run


        call    .pmsg
        jmp     .exit

.pmsg:
        mov     rsi, parent_msg
        mov     rdx, parent_msg_len
        call    print
        ret

.log:
        mov     rsi, log_msg
        mov     rdx, log_msg_len
        call    print
        ret

.exit:
        mov     rsp, rbp
        pop     rbp
        mov     rax, 60
        mov     rdi, 0
        syscall
