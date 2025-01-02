format ELF64
public _start

section '.data' writable
    _buffer.size equ 20

section '.bss' writable
    _buffer rb _buffer.size
    _bss_char rb 1


section '.text' executable

_start:
    mov     rdi, 571
    mov     rsi, _buffer
    mov     rdx, _buffer.size
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
    push    rbp
    mov     rbp, rsp
    push    rax
    push    rbx
    push    rcx
    push    rdx
    sub     rbp, 8
    mov     [rbp], rdx
    mov     rax, rdi
    mov     rbx, 10
    xor     rcx, rcx
    xor     rdx, rdx


    .next_iter:
        div     rbx
        add     rdx, '0'
        push     rdx
        inc     rcx
        xor     rdx, rdx
        cmp     rax, 0
        je      .to_string
        cmp     rcx, rdi
        jmp     .next_iter

    .to_string:
        xor     rdx, rdx
        .to_string_loop:
            cmp     rdx, rcx
            je      .to_string_end
            pop     rax
            mov     [rsi+rdx], rax
            inc     rdx
        .to_string_end:

    push    rdx
    push    rcx
    push    rbx
    push    rax
    mov     rsp, rbp
    pop     rbp
    ret

section '.print_string' executable
print_string:
    push    rsi
    push    rdx

    mov     rsi, rax
    xor     rcx, rcx
    .str_len:
    cmp     byte [rsi + rcx], byte 0
    je      .end
    inc     rcx
    .end:
    mov     rdx, rcx
    mov     rax, 1
    mov     rdi, 1
    syscall
    pop rdx
    pop rsi

section '.print_line' executable
print_line:
    mov     [_bss_char], 10
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, _bss_char
    mov     rdx, 1
    syscall


section '.exit' executable
exit:
    mov     rax, 60
    mov     rdi, 0
    syscall
