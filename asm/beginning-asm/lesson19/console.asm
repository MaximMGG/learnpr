section .data
    msg1        db  "Hello, World!", 10, 0
    msg1len     equ $ - msg1
    msg2        db  "Your turn: ", 0
    msg2len     equ $ - msg2
    msg3        db  "You answer: ", 0
    msg3len     equ $ - msg3
    inputlen    equ     10  ;length of buffer

section .bss
    input resb  inputlen + 1;  one more for endings 0
section .text
    global main

main:
push    rbp
mov     rbp, rsp
        ;print first str
        mov     rsi, msg1
        mov     rdx, msg1len
        call    prints
        ;print second str
        mov     rsi, msg2
        mov     rdx, msg2len
        call    prints
        ;input first str
        mov     rsi, input
        mov     rdx, inputlen
        call    reads
        ;print third str
        mov     rsi, msg3
        mov     rdx, msg3len
        call    prints
        ;wait for input
        mov     rsi, input
        mov     rdx, inputlen
        call    prints
leave
ret
;-----------------------------
prints:
push rbp
mov  rbp, rsp
;rsi - has adres of string
;rdx - has length of this string
    mov rax, 1  ;1  =  writing
    mov rdi, 1  ;1  = stdout   - in console
    syscall
leave
ret
;---------------------------------
reads:
push rbp
mov  rbp, rsp
    mov rax, 0  ; 0 = reading
    mov rdi, 1  ; 1 = stdio  - from console
    syscall
leave
ret


