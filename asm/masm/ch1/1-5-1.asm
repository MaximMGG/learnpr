    option casemap:none

.data
    msg db "Hello world", 10, 0

.code
externdef printf:proc

main PROC
    sub     rbp, 56
    lea     rcx, msg
    call    printf
    ret
main ENDP
END

