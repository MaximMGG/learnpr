extern printf
section .data
    msg     db      "%s", 10, 0

section .text
    global main
main:
push    rbp
mov     rbp, rsp
        mov     r12, rdi
        mov     r13, rsi
        xor     rbx, rbx 
loop:
        mov     rdi, msg
        mov     rsi, qword [r13 + rbx * 8]
        call    printf
        inc     rbx
        cmp     rbx, r12
        jl      loop

leave
ret

