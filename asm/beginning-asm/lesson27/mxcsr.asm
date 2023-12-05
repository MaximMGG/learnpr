extern printf
extern print_mxcsr
extern print_hex
section .data
    eleven      dq  11.0
    two         dq  2.0
    three       dq  3.0
    ten         dq  10.0
    zero        dq  0.0
    hex         db  "0x", 0
    fmt1         db  10, "Divide, default mxcrs:", 10, 0
    fmt2        db  10, "Divide by zero, default mxcrs:", 10, 0
    fmt4        db  10, "Divide, round up:", 10, 0
    fmt5        db  10, "Divide, round down:", 10, 0
    fmt6        db  10, "Divide, truncate:", 10, 0
    f_div       db  "%.1f divided by %.1f is %.16f, in hex: ", 0
    f_before    db  10, "mscsr before:", 9, 0
    f_after     db  "mxcrs after:", 9, 0

    default_mxcsr       dd  0001111100000000b
    round_nearest       dd  0001111100000000b
    round_down          dd  0011111100000000b
    round_up            dd  0101111100000000b
    truncate            dd  0111111100000000b

section .bss
    mxcsr_before    resd    1
    mxcsr_after     resd    1
    xmm             resq    1
section .text
    global main

main:
push    rbp
mov     rbp, rsp
;dividing
;mxcsr is default
        mov     rdi, fmt1
        mov     rsi, ten
        mov     rdx, two
        mov     ecx, [default_mxcsr]
        call    apply_mxcsr
;---------------------------------------
;Dividing with fail 
        mov     rdi, fmt1
        mov     rsi, ten
        mov     rdx, three
        mov     ecx, [default_mxcsr]
        call    apply_mxcsr
;dividing by zero
        mov     rdi, fmt2
        mov     rsi, ten
        mov     rdx, zero
        mov     ecx, [default_mxcsr]
        call    apply_mxcsr
;dividing with fail lost frequancy
;rounding to bigger side
        mov     rdi, fmt4 
        mov     rsi, ten
        mov     rdx, three
        mov     ecx, [round_up]
        call    apply_mxcsr
;dividing with fail lost frequancy
;rounding to less side
        mov     rdi, fmt5
        mov     rsi, ten
        mov     rdx, three
        mov     ecx, [round_down]
        call    apply_mxcsr
;dividing with miss frequancy
;mxcsr is default
        mov     rdi, fmt1
        mov     rsi, eleven
        mov     rdx, three
        mov     ecx, [default_mxcsr]
        call    apply_mxcsr
;dividing with fail lost frequancy
;rounding to bigger side
        mov     rdi, fmt4 
        mov     rsi, eleven
        mov     rdx, three
        mov     ecx, [round_up]
        call    apply_mxcsr
;dividing with fail lost frequancy
;rounding to less side
        mov     rdi, fmt5
        mov     rsi, eleven
        mov     rdx, three
        mov     ecx, [round_down]
        call    apply_mxcsr
;dividing with miss frequancy
;truncate value
        mov     rdi, fmt6
        mov     rsi, eleven
        mov     rdx, three
        mov     ecx, [truncate]
        call    apply_mxcsr
leave
ret
;function
apply_mxcsr:
push    rbp
mov     rbp, rsp
        push    rsi
        push    rdx
        push    rcx
        push    rbp
        call    printf
        pop     rbp
        pop     rcx
        pop     rdx
        pop     rsi
        mov     [mxcsr_before], ecx
        ldmxcsr [mxcsr_before]
        movsd   xmm2, [rsi] ;floating value double frequancy in register xmm2
        divsd   xmm2, [rdx] ;dividing xmm2
        stmxcsr [mxcsr_after] ; saving mxcsr in memory
        movsd   [xmm], xmm2; for using function print_xmm
        mov     rdi, f_div
        movsd   xmm0, [rsi]
        movsd   xmm1, [rdx]
        call    printf
        call    print_xmm
        ;output mxcsr
        mov     rdi, f_before
        call    printf
        mov     rdi, [mxcsr_before]
        call    print_mxcsr
        mov     rdi, f_after
        call    printf
        mov     rdi, [mxcsr_after]
        call    print_mxcsr
leave
ret

;-----------------------------
;func
print_xmm:
push    rbp
mov     rbp, rsp
        mov     rdi, hex
        call    printf
        mov     rcx, 8
    .loop
        xor     rdi, rdi
        mov     dil, [xmm + rcx - 1]
        push    rcx
        call    print_hex
        pop     rcx
        loop    .loop
leave
ret


