extern malloc
extern free
section .data
    std_len     equ     10
    std_int_size equ    4

section .bss
    arr     resq    1

section .test
    global create_arr
create_arr:
push    rbp
mov     rbp, rsp
        mov     rax, std_len
        mov     rbx, std_int_size
        mul     rbx
        mov     rdi, rax 
        call    malloc
        mov     [arr], rax
leave
ret
        
