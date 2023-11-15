extern printf
section .data
    
    number1     dq  12345678901234567
    number2     dq  10000
    neg_sum     dq  -12
    fmt         db  "The numbers are %ld and %ld", 10, 0
    fmtint      db  "%s %ld", 10, 0
    sumi        db  "The sum is:", 0
    difi        db  "The difference:", 0
    ince        db  "Number 1 Incremented:", 0
    deci        db  "Number 1 Decrimented:", 0
    sali        db  "Number 1 Shift left 2 (x4):", 0
    sari        db  "Number 1 Shift right 2 (/4):", 0
    sariex      db  "Number 1 Shift right 2 (/4) with "
                db  "sign extension:", 0
    multi       db  "The product is:", 0
    divi        db  "The integer quotient is:", 0
    remi        db  "The modulo is:", 0
section .bss
    result      resq 1
    modulo      resq 1
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    ;print numbers
    mov     rdi, fmt
    mov     rsi, [number1]
    mov     rdx, [number2]
    mov     rax, 0
    call    printf

;sum--------------------------------
    mov     rax, [number1]
    add     rax, [number2]  ;sum rax and number2
    mov     [result], rax   ;move sum to result variable
    ;display the result
        mov     rdi, fmtint
        mov     rsi, sumi
        mov     rdx, [result]
        mov     rax, 0
        call    printf
;Difference-------------------------
    mov     rax, [number1]
    sub     rax, [number2]
    mov     [result], rax
    ;display the result
        mov     rdi, fmtint
        mov     rsi, difi 
        mov     rdx, [result]
        mov     rax, 0
        call    printf
;increment--------------------------
    mov     rax, [number1]
    inc     rax
    mov     [result], rax
    ;display the result
        mov     rdi, fmtint
        mov     rsi, ince
        mov     rdx, [result]
        mov     rax, 0
        call    printf
;dicrement-------------------------
    mov     rax, [number1]
    dec     rax
    mov     [result], rax
    ;display the result
        mov     rdi, fmtint
        mov     rsi, deci
        mov     rdx, [result]
        mov     rax, 0
        call    printf
;ariphetical shift to the left-----
    mov     rax, [number1]
    sal     rax, 2
    mov     [result], rax
    ;display the result
        mov     rdi, fmtint
        mov     rsi, sali
        mov     rdx, [result]
        mov     rax, 0
        call    printf
;ariphetical shift to the right----
    mov     rax, [number1]
    sar     rax, 2
    mov     [result], rax
    ;display the result
        mov     rdi, fmtint
        mov     rsi, sari
        mov     rdx, [result]
        mov     rax, 0
        call    printf
;ariphetical shift to the rigth with negative numbers
    mov     rax, [neg_sum]
    sar     rax, 2
    mov     [result], rax
    ;display the result
        mov     rdi, fmtint
        mov     rsi, sariex
        mov     rdx, [result]
        mov     rax, 0
        call    printf
;multiply
    mov     rax, [number1]
    imul    qword[number2]
    mov     [result], rax
    ;display the result
        mov     rdi, fmtint
        mov     rsi, multi
        mov     rdx, [result]
        mov     rax, 0
        call    printf
;divide
    mov     rax, [number1]
    mov     rdx, 0          ;needs 0 in value of rdx before dividing
    idiv    qword [number2]  ;  result in rax, but rest in rdx  
    mov     [result], rax
    mov     [modulo], rdx
    ;display the result
        mov     rdi, fmtint
        mov     rsi, divi
        mov     rdx, [result] 
        mov     rax, 0
        call    printf
        mov     rdi, fmtint
        mov     rsi, remi
        mov     rdx, [modulo]
        mov     rax, 0
        call    printf
    mov     rsp, rbp
    pop     rbp
    ret



















