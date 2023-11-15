section .data
    f   dw  121
    s   dw  120

    msg     db "Step One", 10, 0
    msgLen  equ $ - msg - 1
    msgTwo  db "Step Two", 10, 0
    msgTwoLen equ $ - msgTwo - 1

section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    xor     ax, ax
    mov     ax, word [f]
    mov     bx, word [s]
    cmp     ax, bx
    je stepOne
    cmp ax, bx
    jg  stepTwo
end:
    mov rsp, rbp
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall


stepOne:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msgLen
    syscall
    jmp end
stepTwo:
    mov rax, 1
    mov rdi, 1
    mov rsi, msgTwo
    mov rdx, msgTwoLen
    syscall
    jmp end

    
