extern printf
section .data
    msg     db  "%d %d %d %d %d %d %d %d", 10, 0
    val1    dd  1
    val2    dd  2
    val3    dd  3
    val4    dd  4
    val5    dd  5
    val6    dd  6
    val7    dd  7
    val8    dd  8

section .text
    global main
main:
push    rbp
mov     rbp, rsp
        mov     rdi, msg
        mov     esi, [val1]
        mov     edx, [val2] 
        mov     ecx, [val3]
        mov     r8d, [val4]
        mov     r9d, [val5]
        mov     eax, [val8]
        mov     [rsp], eax
        sub     rsp, 8
        mov     eax, [val7]
        mov     [rsp], eax
        mov     eax, [val6]
        sub     rsp, 8
        mov     [rsp], eax
        call    printf
leave
ret


