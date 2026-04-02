extern printnum
section .data
    num     dd  1234
section .text
    global main
    
main:
    push rbp
    mov  rbp, rsp
    xor     rdi, rdi 
    mov     edi, dword[num]
    call    printnum
    
    leave
    ret

global mult
section .data
section .text

mult:
    push    rbp
    mov     rbp, rsp
    imul    edi, 2
    xor     rax, rax
    mov     eax, edi
    leave
    ret
