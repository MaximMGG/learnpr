section .data
    msghello    db  "Hello, write your word", 10, 0
    hellolen    equ $ - msghello
    msg     db      "Your word is %s", 10, 0
    len     equ     $ - msg
section .bss
    buf     resb    1024
    newstr  resb    1024
section .text
    global main 

main:
push    rbp
mov     rbp, rsp
        mov     rsi, msghello
        mov     rdx, hellolen
        call    printstr
        mov     rsi, buf
        mov     rdx, 1
        call    readstr
        ;lengs of buf
        mov     rsi, buf
        call    strlen
        mov     rsi, buf
        mov     rdx, rax
        call    printstr
leave
ret


global printstr
printstr:
push    rbp
mov     rbp, rsp
        mov     rax, 1
        mov     rdi, 1
        syscall
leave
ret

global  readstr
readstr:
push    rbp
mov     rbp, rsp
readloop:
        mov     rax, 0
        mov     rdi, 1
        syscall
        cmp     byte[rsi], 10 
        je      readend
        inc     rsi
        jmp     readloop
readend:
leave
ret
        
global strlen
strlen:
push    rbp
mov     rbp, rsp
        mov     rax, 0
lenloop:
        cmp     byte [rsi], 10 
        je      lenend
        cmp     byte [rsi], 0
        je      lenend
        inc     rax
        inc     rsi
        jmp     lenloop

lenend:
leave
ret
        
        
