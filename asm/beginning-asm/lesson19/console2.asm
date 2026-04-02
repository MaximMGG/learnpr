section .data
    msg1    db  "Hello, World!", 10, 0
    msg2    db  "Your turn (only a-z): ", 0
    msg3    db  "You asnwered: ", 0
    inputlen    equ 10
    NL      db  0xa
section .bss
    input resb  inputlen + 1
section .text
    global main
main:
push    rbp
mov     rbp, rsp
        mov     rdi, msg1 
        call    prints
        
        mov     rdi, msg2
        call    prints

        mov     rdi, input
        mov     rsi, inputlen
        call    reads

        mov     rdi, msg3
        call    prints

        mov     rdi, input
        call    prints

        mov     rdi, NL
        call    prints
leave
ret
;-=-=-=-=-=-=-=-=-=-=-=-=-=
prints:
push    rbp
mov     rbp, rsp
push    r12
;count symbols
        xor     rdx, rdx
        mov     r12, rdi
.lengthloop:
        cmp     byte [r12], 0
        je      .lengthfound
        inc     rdx 
        inc     r12
        jmp     .lengthloop
.lengthfound:
        cmp     rdx, 0
        je      .done
        mov     rsi, rdi ; rdi has adress of sring
        mov     rax, 1 ; writing
        mov     rdi, 1 ; stdout
        syscall
.done:
pop r12
leave
ret
;----------------------------
reads:
section .data
section .bss
    .inputchar   resb    1
section .text
push    rbp
mov     rbp, rsp
        push r12
        push r13
        push r14
        mov     r12, rdi; adress of buffer input
        mov     r13, rsi; maxlength in r13
        xor     r14, r14
.readc:
        mov     rax, 0 ; reading
        mov     rdi, 1 ; stdin
        lea     rsi, [.inputchar]  ;adress input income
        mov     rdx, 1
        syscall
        mov     al, [.inputchar] ; input symbol NL?
        cmp     al, byte[NL]
        je      .done
        cmp     al, 97 ; code of symbol less then "a"
        jl      .readc  ; agane
        cmp     al, 122 ; code of symbol greter then "z"?
        jg      .readc
        inc     r14
        cmp     r14, r13
        ja      .readc ; buffer is full, throw left
        mov     byte [r12], al ; save symbol in buffer
        inc     r12
        jmp     .readc
.done:
        inc     r12
        mov     byte[r12], 0
        pop     r14
        pop     r13
        pop     r12
leave
ret
        


