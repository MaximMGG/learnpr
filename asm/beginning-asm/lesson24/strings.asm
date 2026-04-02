extern printf
section .data
    string1     db  "This is the 1st string.", 10, 0
    string2     db  "This is the 2nd string.", 10, 0
    strlen2     equ $ - string2 - 2
    string21    db  "Comparing strings: The strings do not differ.", 10, 0
    string22    db  "Comparing strings: The strings differ, "
                db  "starting at position: %d", 10, 0
    string3     db  "The queck brown fox jumps over the lazy dog.", 0
    strlen3     equ $ - string3 - 2
    string33    db  "New look oat this string: %s", 10, 0
    string4     db  "z", 0
    string44    db  "The character '%s' was found at position: %d.", 10, 0
    string45    db  "The character '%s' was note odund.", 10, 0
    string46    db  "Scanning for the character '%s'.", 10, 0
section .bdd
section .text
    global main
main:
push    rbp
mov     rbp, rsp
        ;print 2 strings
        xor     rax, rax
        mov     rdi, string1
        call    printf
        mov     rdi, string2
        call    printf
        ;comparing 2 strings
        lea     rdi, [string1]
        lea     rsi, [string2]
        mov     rdx, strlen2
        call    compare1
        cmp     rax, 0
        jnz     not_equal1
        ;strings the same, print
        mov     rdi, string21
        call    printf
        jmp     otherversion
        ;strings not the same, print
    not_equal1:
        mov     rdi, string22
        mov     rsi, rax
        xor     rax, rax
        call    printf
        ;comparing two strings, other version
    otherversion:
        lea     rdi, [string1]
        lea     rsi, [string2]
        mov     rdx, strlen2
        call    compare2
        cmp     rax, 0
        jnz     not_equal2
        ;strings the same, print
        mov     rdi, string21
        call    printf
        call    scanning
        ;strings not the same, print
    not_equal2:
        mov     rdi, string22
        mov     rsi, rax
        xor     rax, rax
        call    printf
        ;scanning for symbol in string
        ;firstly print all string
        mov     rdi, string33
        mov     rsi, string3
        xor     rax, rax
        call    printf
        ;then print finding arument, can be only one
        mov     rdi, string46
        mov     rsi, string4
        xor     rax, rax
        call    printf
    scanning:
        lea     rdi, [string3]
        lea     rsi, [string4]
        mov     rdx, strlen3
        call    cscan
        cmp     rax, 0
        jz      char_not_found
        ;symbol found
        mov     rdi, string44
        mov     rsi, string4
        mov     rdx, rax
        xor     rax, rax
        call    printf
        jmp     exit
    char_not_found:
        mov     rdi, string45
        mov     rsi, string4
        xor     rax, rax
        call    printf
exit:
leave
ret

;FUNCTIONS
;comparing two strings func
compare1:
        mov     rcx, rdx
        cld
cmpr:
        cmpsb
        jne     notequal
        loop    cmpr
        xor     rax, rax
        ret
notequal:
        mov     rax, strlen2
        dec     rcx
        sub     rax, rcx
        ret
        xor     rax, rax
        ret
;-----------------------------
;comparing two strings func
compare2:
        mov     rcx, rdx
        cld
        repe    cmpsb
        je      equal2
        mov     rax, strlen2
        sub     rax, rcx
        ret
equal2:
        xor     rax, rax
        ret
;-------------------------------------
;scanning for symbol in string func
cscan:
        mov     rcx, rdx
        lodsb
        repne   scasb
        jne     char_notfound
        mov     rax, strlen3
        sub     rax, rcx
        ret
char_notfound:
        xor     rax, rax
        ret


