.DATA
    msg db "Hello", 0

    option casemap:none

.CODE
    public msgAsm

msgAsm PROC
    lea rax, msg 
    ret
msgAsm ENDP
    END
