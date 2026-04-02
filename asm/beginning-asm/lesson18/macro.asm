
%define double_it(r)  sal r, 1 ;one line macro

%macro  prntf 2   ;macro with several lines with 2 args
    section .data
        %%arg1      db  %1, 0 ; first arg   %1
        %%fmtint    db  "%s %ld", 10, 0 ;string format
    section .text
        mov     rdi, %%fmtint
        mov     rsi, %%arg1
        mov     rdx, [%2]  ; put second arg
        mov     rax, 0
        call    printf
%endmacro

section .data
    number  dq 15
section .text
extern printf
    global main

main:
push rbp
mov  rbp, rsp 
        prntf   "The number is", number
        mov     rax, [number]
        double_it(rax)
        mov     [number], rax
        prntf   "The number 2 is", number
leave
ret
