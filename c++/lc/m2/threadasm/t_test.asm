extern t_print

section .data
    msg     db      "Test psg", 10, 0 
    msg_len equ     $ - msg

section .text
    global main

main:
push    rbp
mov     rbp, rsp
        mov     rsi, msg
        mov     rdx, msg_len
        call    t_print
leave
ret
