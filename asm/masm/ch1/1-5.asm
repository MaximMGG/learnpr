    option casemap:none
.data
    msg db  "Hello world!", 10, 0

.code
externdef printf:proc
    public asmFunc

asmFunc proc
    sub     rsp, 56
    lea     rcx, msg
    call    printf
    add     rsp, 56
    ret
asmFunc endp
end
