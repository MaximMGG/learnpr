extern printb
extern printf
section .data
    msg1    db  "No bits are set:", 10, 0
    msg2    db  10, "Set bit #4, that is the 5th bit:", 10, 0
    msg3    db  10, "Set bit #7, that is the 8th bit:", 10, 0
    msg4    db  10, "Set bit #8, that is the 9th bit:", 10, 0
    msg5    db  10, "Set bit #61, that is the 62th bit:", 10, 0
    msg6    db  10, "Clear bit #8, that is the 9th bit:", 10, 0
    msg7    db  10, "Test bit #61, and display rdi", 10, 0
    bitflags    dq  0

section .text
    global main

main:
push    rbp
mov     rbp, rsp
    mov     rdi, msg1
    xor     rax, rax
    call    printf
    ;print bitflags
    mov     rdi, [bitflags]
    call    printb
    ;set in 1 #4 bit (5th bit)
    mov     rdi, msg2
    xor     rax, rax
    call    printf
    bts     qword [bitflags], 4
    ;print bitflags
    mov     rdi, [bitflags]
    call    printb
    ;set in 1 #7 bit (8th bit)
    mov     rdi, msg3
    xor     rax, rax
    call    printf
    bts     qword [bitflags], 7
    ;print bitflags
    mov     rdi, [bitflags]
    call    printb
    ;set in 1 #8 bit (9th bit)
    mov     rdi, msg4
    xor     rax, rax
    call    printf
    bts     qword [bitflags], 8
    ;print bitflags
    mov     rdi, [bitflags]
    call    printb
    ;set in 1 #61 bit (62th bit)
    mov     rdi, msg5
    xor     rax, rax
    call    printf
    bts     qword [bitflags], 61
    ;print bitflags
    mov     rdi, [bitflags]
    call    printb
    ;reset in 0 #8 bit (9th bit)
    mov     rdi, msg6
    xor     rax, rax
    call    printf
    btr     qword [bitflags], 8 
    ;print bitflags
    mov     rdi, [bitflags]
    call    printb
    ;check #61 bit (CF will be 1 if #61 bit is 1)
    mov     rdi, msg7
    xor     rax, rax
    call    printf

    mov     rax, 61
    xor     rdi, rdi
    bt      [bitflags], rax
    setc    dil
    call    printb
    leave
    ret

    



