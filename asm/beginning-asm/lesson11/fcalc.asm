section .data
    number1     dq  9.3
    number2     dq  73.0
    fmt         db  "The numbers are %f nad %f", 10, 0
    fmtFloat    db  "%s %f", 10, 0
    f_sum       db  "The float sum of %f and %f is %f", 10, 0
    f_dif       db  "The float difference of %f and %f is %f", 10, 0 
    f_mul       db  "The product of %f and %f is %f", 10, 0
    f_div       db  "The division of %f and %f is %f", 10, 0
    f_sqrt      db  "The float squareroot of %f is %f", 10, 0

section .text
extern printf

    global main
main:
    push    rbp
    mov     rbp, rsp
    ;print numbers
    movsd   xmm0, [number1]
    movsd   xmm1, [number2]
    mov     rdi, fmt
    mov     rax, 2   ;number with float point
    call    printf
    ;sum
    movsd   xmm2, [number1]
    addsd   xmm2, [number2]
    ;print
    movsd   xmm0, [number1]
    movsd   xmm1, [number2]
    mov     rdi, f_sum 
    mov     rax, 3   ;number with float point
    call    printf
    ;difference
    movsd   xmm2, [number1]
    subsd   xmm2, [number2]
    ;print
    movsd   xmm0, [number1]
    movsd   xmm1, [number2]
    mov     rdi, f_dif 
    mov     rax, 3   ;number with float point
    call    printf
    ;multiply
    movsd   xmm2, [number1]
    mulsd   xmm2, [number2]
    ;print
    movsd   xmm0, [number1]
    movsd   xmm1, [number2]
    mov     rdi, f_mul 
    mov     rax, 3   ;number with float point
    call    printf
    ;division
    movsd   xmm2, [number1]
    divsd   xmm2, [number2]
    ;print
    mov     rdi, f_div 
    movsd   xmm0, [number1]
    movsd   xmm1, [number2]
    mov     rax, 1   ;number with float point
    call    printf
    ;sqrt
    sqrtsd  xmm1, [number1]
    ;print
    mov     rdi, f_sqrt 
    movsd   xmm0, [number1]
    mov     rax, 2   ;number with float point
    call    printf

    mov     rsp, rbp
    pop     rbp
    ret


