extern printf
section .data
    msgn1   db  "Number 1 is = %d", 0
    msgn2   db  "Number 2 is = %d", 0
    msg1    db  "SHL 2 = OK multiply by 4", 0
    msg2    db  "SHR 2 = WRONG divide by 4", 0
    msg3    db  "SAL 2 = correctly multiply by 4", 0
    msg4    db  "SAR 2 = correctly dividy by 4", 0
    msg5    db  "SHR 2 = OK divide by 4", 0
    number1 dq  8
    number2 dq  -8

section .text
    global main
main:
push    rbp
mov     rbp, rsp
;number +
    mov     rsi, msg1
    call    printmsg
    mov     rsi, [number1]
    call    printnbr
    mov     rax, [number1]
    shl     rax, 2
    mov     rsi, rax
    call    printres
;nubmer -
    mov     rsi, msg1
    call    printmsg
    mov     rsi, [number2]
    call    printnbr
    mov     rax, [number2]
    shl     rax, 2
    mov     rsi, rax
    call    printres
;SAL
;number +
    mov     rsi, msg3 
    call    printmsg
    mov     rsi, [number1]
    call    printnbr
    mov     rax, [number1]
    sal     rax, 2
    mov     rsi, rax
    call    printres
;number -
    mov     rsi, msg3
    call    printmsg
    mov     rsi, [number2]
    call    printnbr
    mov     rax, [number2]
    sal     rax, 2
    mov     rsi, rax
    call    printres
;SHR
;number +
    mov     rsi, msg5 
    call    printmsg
    mov     rsi, [number1]
    call    printnbr
    mov     rax, [number1]
    shr     rax, 2
    mov     rsi, rax
    call    printres
;number -    
    mov     rsi, msg5
    call    printmsg
    mov     rsi, [number2]
    call    printnbr
    mov     rax, [number2]
    shr     rax, 2
    mov     rsi, rax
    call    printres
;SAR
;number +
    mov     rsi, msg4 
    call    printmsg
    mov     rsi, [number1]
    call    printnbr
    mov     rax, [number1]
    sar     rax, 2
    mov     rsi, rax
    call    printres
;number -    
    mov     rsi, msg4
    call    printmsg
    mov     rsi, [number2]
    call    printnbr
    mov     rax, [number2]
    sar     rax, 2
    mov     rsi, rax
    call    printres
    leave
    ret

printmsg:
    section .data
        .fmtstr db 10, "%s", 10, 0
    section .text 
        push    rbp
        mov     rbp, rsp
        mov     rdi, .fmtstr
        mov     rax, 0
        call    printf
    leave
    ret

printnbr:
    section .data
        .fmtstr db "The original number is %lld", 10, 0
    section .text 
        push    rbp
        mov     rbp, rsp
        mov     rdi, .fmtstr
        mov     rax, 0
        call    printf
    leave
    ret

printres:
    section .data
        .fmtstr db "The result number is %lld", 10, 0
    section .text 
        push    rbp
        mov     rbp, rsp
        mov     rdi, .fmtstr
        mov     rax, 0
        call    printf
    leave
    ret


