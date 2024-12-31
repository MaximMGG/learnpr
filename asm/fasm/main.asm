format ELF64 
public _start

section '.data' writable


NL equ 10

msg db "Hello world!", NL, 0

section '.text' executable
_start:
    mov     rax, msg
    call print
    call exit


section '.print_msg' executable

print:
    push    rax
    push    rbx
    push    rcx
    push    rdx
    mov rcx, rax
    call len_str
    mov rdx, rax
    mov rax, 4
    mov rbx, 1
    int 0x80
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rax
    ret

section '.print_msg_len' executable

len_str:
    push    rdx
    xor     rdx, rdx

    .next_iter:
        cmp [rax + rdx], byte 0
        je .close
        inc rdx
        jmp .next_iter

    .close:
        mov rax, rdx
        pop rdx
        ret

section '.exit_section' executable
exit:
    mov rax, 1 ; 1 - exit
    mov rbx, 0 ; return
    int 0x80

