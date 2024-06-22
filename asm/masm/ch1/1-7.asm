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
    lea     rax, titlestr
    ret
getTitle ENDP
