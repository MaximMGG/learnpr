    option casemap:none

nl = 10 ;ASCII code for newline
maxLen = 256

.data

    beforetitle  db  "Bigining %s", nl, 0
    aftertitle  db  "Ending %s", nl, 0

    titleStr    db  "Listening 2-3", 0

    prompt1     db  "Enter an integer betwee 0 and 127:", 0 
    prompt2     db  "Value in hexadecimal: %x", nl, 0
    prompt3     db  "Inver all the bits (hexadecimal): %x", nl, 0
    prompt4     db  "Add 1 (hexadecimal): %x", nl, 0
    prompt5     db  "Output as signed integer: %d", nl, 0
    prompt6     db  "Using neg insgeruction: %d", nl, 0

    intValue    dq  ?
    input       db  maxLen  dup (?)

.code

    externdef getc:proc
    externdef atoi:proc
    externdef printf:proc

    public main
main proc
    sub     rsp, 56
    lea     rcx, beforetitle
    lea     rdx, titleStr
    call    printf
    call    asmMain

    lea     rcx, aftertitle
    lea     rdx, titleStr
    call    printf
    add     rsp, 56
    ret
main endp

    public  asmMain
asmMain proc
    call    readLine
    ret
asmMain endp

    public  readLine
readLine proc

    xor     rcx, rcx
.loop
    call    putc
    cmp     al, nl
    je      end
    mov     bl, al
    mov     intut + rcx, bl
    jmp     loop

.end
    lea     rcx, input
    call    printf
    ret
readLine endp
end


