section .data
    radius      dq  10.0
    pi          dq  3.14
    fmt         db  "The area of the circle is %.2f", 10, 0
section .text
extern printf
    global main

main:
push    rbp
mov     rbp, rsp 
    call    area  ;function call
    mov     rdi, fmt ;print 
    movsd   xmm1, [radius]
    mov     rax, 1
    call    printf
leave
ret
;------------------------------
area:
    push    rbp
    mov     rbp, rsp
    movsd   xmm0, [radius]  ; put radius in xmm0
    mulsd   xmm0, [radius] ; multiply xmm0 on radius
    mulsd   xmm0, [pi] ; mult xmm0 on [pi]
leave
ret
