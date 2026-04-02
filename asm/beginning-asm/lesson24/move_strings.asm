%macro prnt 2
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, %1
    mov     rdx, %2
    syscall
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, NL 
        mov     rdx, 1
        syscall
%endmacro

section .data
    length      equ     95
    NL          db      0xa
    string1     db      "my_string of ASCII:"
    string2     db      10, "me_string of zeros:"
    string3     db      10, "my_string of ones:"
    string4     db      10, "again my_string of ASCII:"
    string5     db      10, "copy my_string to other_string:"   
    string6     db      10, "revers copy my_string to other_string:"

section .bss
    my_string       resb    length
    other_string    resb    length

section .text
    global  main

main:
push    rbp
mov     rbp, rsp
;------------------------------------
;fill line visible ascii - symbols
        prnt    string1, 18
        mov     rax, 32
        mov     rdi, my_string
        mov     rcx, length
str_loop1:
        mov     byte [rdi], al
        inc     rdi
        inc     rax
        loop    str_loop1 
        prnt    my_string, length
;------------------------------------
;filee lines ascii - symbols 0
        prnt    string2, 20
        mov     rax, 48
        mov     rdi, my_string
        mov     rcx, length
str_loop2:
        stosb;      dont need  ind rdi
        loop    str_loop2
        prnt    my_string, length
;------------------------------------
;fill line ascii - symbols 1
        prnt    string3, 19
        mov     rax, 49
        mov     rdi, my_string
        mov     rcx, length
        rep     stosb   ;dont need inc rdi, and do need a loop
        prnt    my_string, length
;------------------------------------
;secondary filling line visible ascii - symbols
        prnt    string4, 26
        mov     rax, 32
        mov     rdi, my_string
        mov     rcx, length
str_loop3:
        mov     byte [rdi], al
        inc     rdi
        inc     rax
        loop    str_loop3
        prnt    my_string, length
;------------------------------------
;copy string my_string in other string other_string
        prnt    string5, 32 
        mov     rsi, my_string
        mov     rdi, other_string
        mov     rcx, length
        rep     movsb
        prnt    other_string, length
;copy revers string my_string in other_string
        prnt    string6, 40
        mov     rax, 48
        mov     rdi, other_string
        mov     rcx, length
        rep     stosb
        lea     rsi, [my_string + length - 4]
        lea     rdi, [other_string + length]
        mov     rcx, 27 ;copy only 27-1 symbols
        std     ;std - set flag DF, cld - unset flag DF
        rep     movsb
        prnt    other_string, length
leave
ret
