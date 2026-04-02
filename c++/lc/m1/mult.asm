extern printf
section .data
    msg1    db      "Hello from Parent", 10, 0
    msg1_len    equ  $ - msg1
    msg2    db      "Hello from Child", 10, 0
    msg2_len    equ  $ - msg2
    fmt     db      "%d\n";

section .bss
    res     resq    1
    lock_point   resb    1

section .text
    global main
main:
push    rbp
mov     rbp, rsp
        mov     byte [lock_point], 0
        mov     qword [res],  1
        mov     rax, 57
        syscall
        cmp     rax, 0
        je      child

perent:
        mov     rsi, msg1
        mov     rdx, msg1_len
        call    print
        mov     eax, 0
        mov     dword [rbp - 4], eax
        xor     rcx, rcx
    _loop:
        cmp     dword [rbp - 4], 99999
        je      _loop_exit
        lock    inc qword [res]
        inc     dword [rbp - 4] 
        jmp     _loop
    _loop_exit:
        jmp     mutex

child:
        mov     rsi, msg2
        mov     rdx, msg2_len
        call    print
        mov     eax, 0
        mov     dword [rbp - 8], eax
        xor     rcx, rcx
    _loop_c:
        cmp     dword [rbp - 8], 99999
        je      _loop_c_exit
        lock    inc qword [res]
        inc     dword [rbp - 8]
        jmp     _loop_c
    _loop_c_exit:
        lock    inc byte [lock_point]

exit:
        mov  rax, 60
        mov  rdi, 0
        mov  rdi, fmt
        mov     rsi, [res]
        call    printf
        mov  rsp, rbp
        pop  rbp
        syscall

mutex:
    _mut_loop:
        cmp     byte[lock_point], 1
        je      exit
        jmp     _mut_loop

print:
push    rbp
mov     rbp, rsp
        mov     rdi, 1
        mov     rax, 1
        syscall
leave
ret
