extern printf
extern c_area
extern c_circum
extern r_area
extern r_circum
global pi
section .data
    pi      dq  3.14159254
    radius  dq  10.0
    side1   dq  4
    side2   dq  5
    fmtf    db  "%s %f", 10, 0
    fmti    db  "%s %d", 10, 0
    ca      db  "The circle area is", 0
    cc      db  "The circle circumference is ", 0
    ra      db  "The rectangle area is ", 0
    rc      db  "The rectangle circumferene", 0

section .text
    global main

main:
push    rbp
mov     rbp, rsp 
        movsd   xmm0, qword [radius]
        call    c_area
            mov rdi, fmtf
            mov rsi, ca
            mov rax, 1
            call    printf
        movsd   xmm0, qword [radius]
        call    c_circum
            mov rdi, fmtf
            mov rsi, cc
            mov rax, 1
            call    printf
        mov     rdi, [side1]
        mov     rsi, [side2]
        call    r_area  ;return in [rax] register
            mov rdi, fmti
            mov rsi, ra
            mov rdx, rax
            mov rax, 0
            call    printf
        mov     rdi, [side1]
        mov     rsi, [side2]
        call    r_circum
            mov rdi, fmti
            mov rsi, rc
            mov rdx, rax
            mov rax, 0
            call    printf
mov     rsp, rbp
pop     rbp
ret
 

