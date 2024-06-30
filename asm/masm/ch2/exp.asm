    option casemap:none

.data
    msg     db  "Hello", 0
    format  db  "%s", 10, 0;

.code
externdef printf:proc

public main

main proc
    sub     rsp, 56
    lea     rcx, format
    lea     rdx, msg
    call    printf
    add     rsp, 56
    ret
main endp
end
