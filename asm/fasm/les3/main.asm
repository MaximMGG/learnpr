format ELF64
public _start

section '.data' writable
    _buffer.size equ 20

section '.bss' writable
    _buffer rb _buffer.size
    _bss_char rb 1


section '.text' executable

_start:

    mov     rax, 571
    mov     rbx, _buffer
    mov     rcx, _buffer.size
    call    number_to_string
    mov     rax, _buffer
    call    print_string
    call    print_line

    call exit


;rsi, rdi, rbp, rsp
;r8 .. r15 ; 64 bits
;mm0 .. mm7; 64 bits


section '.number_to_string' executable
; | input = 
; rax = number
; rbx = buffer
; rcx = buffer.size

number_to_string:
    push    rax
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    mov     rsi, rcx
    xor     rcx, rcx
    .next_iter:
        push    rbx
        mov     rbx, 10
        div     rbx
        inc     rcx
        pop     rbx
        add     rdx, '0'
        push    rdx
        cmp     rax, 0
        je      .next_step
        jmp     .next_iter
    .next_step:
        mov     rdx, rcx
        xor     rcx, rcx
    .to_string:
        cmp     rcx, rsi
        je      .pop_iter
        cmp     rcx, rdx
        je      .close
        pop     rax
        mov     [rbx+rcx], rax
        inc     rcx
        jmp     .to_string
    .pop_iter:
        cmp     rcx, rdx
        je      .close
        pop     rax
        inc     rcx
        jmp     .pop_iter

    .close:
        pop     rsi
        pop     rdx
        pop     rcx
        pop     rbx
        pop     rax
        ret

section '.print_string' executable



section '.exit' executable

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall
