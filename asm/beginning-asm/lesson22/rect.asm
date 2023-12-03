section .data
section .text
global rarea
rarea:
    section .text
        push    rbp
        mov     rbp, rsp
        mov     rax, rdi
        imul    rsi 
        leave
        ret
global rcircum
rcircum:
    section .text
        push    rbp
        mov     rbp, rsp
        mov     rax, rdi
        add     rax, rsi
        imul    rax, 2
        leave
        ret

        

