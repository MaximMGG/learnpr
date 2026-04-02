option casemap:none

nl = 10
maxLen = 256

.data
    titleStr    byte    "Listen 1-7", 0
    prompt      byte    "Enter a string: ", 0
    fmtStr      byte    "User entered: '%s'", nl, 0

    input   byte    maxLen  dup (?)

.code
externdef   printf:proc
externdef   readLine:proc

public getTitle
getTitle PROC
    lea     rax, titleStr
    ret
getTitle ENDP

public asmMain
asmMain PROC
    sub     rsp, 56
    lea     rcx, prompt
    call    printf
    mov     input, 0

    lea     rcx, input
    mov     rdx, maxLen
    call    readLine

    lea     rcx, fmtStr
    lea     rdx, input
    call    printf
    add     rsp, 56
    ret
asmMain ENDP 

END
