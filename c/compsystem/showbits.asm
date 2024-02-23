section .data
    one       db  "1"
    zero       db  "0"
    NL      db  10

section .bss
    bits    resb    64 

section .text
    global  show_bits

show_bits:
push    rbp
mov     rbp, rsp
        mov     dword [rbp - 4], edi
        mov     dword [rbp - 8], 0
        mov     dword [rbp - 16], 0
        xor     rcx, rcx
        mov     rcx, 31

    .loop:
        cmp     rcx, -1
        je      .exit
        mov     rax, [rbp - 4]
        shr     rax, cl
        and     rax, 0b0001
        cmp     al, 1
        je      setone
        jne     setzero
        inc     dword [rbp - 8]
        cmp     dword [rbp - 8], 8 
        je      setspace
        jmp     .loop

    .setone:
        mov     rbx, [one]
        mov     byte [bits + [rbp - 16]], bl  ; one
        inc     dword [rbp - 16]
        ret
    .setzero:
        mov     rbx, [zero]
        mov     byte [bits + [rbp - 16]], bl; zero
        inc     dword [rbp - 16]
        ret
    .setspace:
        mov     rbx, [NL]
        mov     byte [bits + [rbp - 16]], bl  ;space
        inc     dword [rbp - 16]
        mov     [rbp - 8], 0
        ret

    .exit:
        mov     rsi, bits
        mov     rdx, 36
        call    print
        leave
        ret


print:
push    rbp
mov     rbp, rsp
        mov     rax, 1
        mov     rdi, 1
        syscall
leave
ret
