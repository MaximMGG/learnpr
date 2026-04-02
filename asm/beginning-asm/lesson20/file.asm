section .data
    ;expressions used for conditional assembly
    CREATE      equ     1
    OVERWRITE   equ     0
    APPEND      equ     0
    O_WRITE     equ     0
    READ        equ     0
    O_READ      equ     0
    DELETE      equ     0
    ;syscall symbols
    NR_read     equ     0
    NR_write    equ     1
    NR_open     equ     2
    NR_close    equ     3
    NR_lseek    equ     8
    NR_create   equ     85
    NR_unlink   equ     87
    ;creation and status flags
    O_CREAT     equ     00000100q
    O_APPEND    equ     00002000q
    ;access mode
    O_RDONLY    equ     000000q
    O_WRONLY    equ     000001q
    O_RDWR      equ     000002q
    ;create node (permissions)
    S_IRUSR     equ     00400q
    S_IWUSR     equ     00200q
    NL          equ     0xa
    bufferlen   equ     64
    fileName    db      "testfile.txt", 0
    FD          dq      0; file discriptor

    text1       db      "1. Hello...to everyone!", NL, 0
    len1        equ     $ - text1 - 1 ; delete 0
    text2       db      "2. Here I am!", NL, 0
    len2        equ     $ - text2 - 1
    text3       db      "3. Alife and kicking!", NL, 0
    len3        equ     $ - text3 - 1
    text4       db      "Adios !!!", NL, 0
    len4        equ     $ - text4 - 1

    error_Create    db  "error creating file", NL, 0
    error_Close     db  "error closing file", NL, 0 
    error_Write     db  "error writing to file", NL, 0
    error_Open      db  "error opening file", NL, 0
    error_Append    db  "error appending to file", NL, 0
    error_Delete    db  "error deleting file", NL, 0
    error_Read      db  "error reading file", NL, 0
    error_Print     db  "error printing string", NL, 0 
    error_Position  db  "error positioning if file", NL, 0

    success_Create  db  "File created and opened", NL, 0
    success_Close   db  "File close", NL, 0
    success_Write   db  "Written in file", NL, 0
    success_Open    db  "File opened for R/W", NL, 0
    success_Append  db  "File opened for appending", NL, 0
    success_Delete  db  "File deleted", NL, 0
    success_Read    db  "Reading file", NL, 0
    success_Position    db  "Positioning in file", NL, 0

section .bss
    buffer  resb    bufferlen
section .text
    global main

main:
push    rbp
mov     rbp, rsp

%IF CREATE
;creating and opening file, than closing
;creating and opening
    mov     rdi, fileName
    call    createFile
    mov     qword[FD], rax; save discriptor
;writing in file #1
    mov     rdi, qword [FD]
    mov     rsi, text1
    mov     rdx, qword[len1]
    call    writeFile
;closing file
    mov     rdi, qword[FD]
    call    closeFile
%ENDIF

%IF OVERWRITE
;opening and rewriting file, than cloging
;opening file
    mov     rdi, fileName
    call    openFile
    mov     qword[FD], rax
;writing in file #2  - Rewriting (overwrite!)
    mov     rdi, qword[FD]
    mov     rsi, text2
    mov     rdx, qword[len2]
    call    writeFile
;closing file
    mov     rdi, qword[FD]
    call    closeFile
%ENDIF

%IF APPEND
;opening and appending in file, than closing
;open and appending data in file
    mov     rdi, fileName
    call    appendFile
    mov     qword[FD], rax
;writing in file - APPENDING
    mov     rdi, qword[FD]
    mov     rsi, text3
    mov     rdx, qword[len3]
    call    writeFile
    mov     rdi, qword[FD]
    call    closeFile
%ENDIF

%IF O_WRITE
;opening and rewriting in position in file, than closing
;opening file for writing
    mov     rdi, fileName
    call    openFile
    mov     qword[FD], rax
;position in file at offset
    mov     rdi, qword[FD]
    mov     rsi, qword[len2]
    mov     rdx, 0
    call    positionFile
;writing in fill position with offset
    mov     rdi, qword[FD]
    mov     rsi, text4
    mov     rdx, qword [len4]
    call    writeFile
;closing file
    mov     rdi, qword[FD]
    call    closeFile
%ENDIF

%IF READ
;opening file and reading from file, than closin
;opening file for reading
    mov     rdi, fileName
    call    openFile
    mov     qword[FD], rax
;reading from file
    mov     rdi, qword[FD]
    mov     rsi, buffer
    mov     rdx, bufferlen
    call    readFile
    mov     rdi, rax
    call    printString
;closing file
    mov     rdi, qword[FD]
    call    closeFile
%ENDIF

%IF O_READ
;opening and reading in position, with offset, than closing
;opening file
    mov     rdi, fileName
    call    openFile
    mov     qword[FD], rax
;position in file at offset
    mov     rdi, qword[FD]
    mov     rsi, qword[len2]
    mov     rdx, 0
    call    positionFile
;read from file in position
    mov     rdi, qword[FD]
    mov     rsi, buffer
    mov     rdx, 10
    call    readFile
    mov     rdi, rax
    call    printString
;closing file
    mov     rdi, qword[FD]
    call    closeFile
%ENDIF
leave
ret

%IF DELETE
;deleting file
    mov     rdi, fileName
    call    deleteFile
%ENDIF
leave
ret

;file manipulation functions
global readFile
readFile:
    mov     rax, NR_read
    syscall
    cmp     rax, 0
    jl      readerror
    mov     byte [rsi + rax], 0
    mov     rdi, success_Read
    push    rax
    call    printString
    pop     rax
    ret
readerror:
    mov     rdi, error_Read
    call    printString
    ret
;-----------------------------
global deleteFile
deleteFile:
    mov     rax, NR_unlink
    syscall
    cmp     rax, 0
    jl      deleteerror
    mov     rdi, success_Delete
    call    printString
    ret
deleteerror:
    mov     rdi, error_Delete
    call    printString
    ret
;-----------------------------
global appendFile
appendFile:
    mov     rax, NR_open
    mov     rsi, O_RDWR|O_APPEND
    syscall
    cmp     rax, 0
    jl      appenderror
    mov     rdi, success_Append
    push    rax
    call    printString
    pop     rax
    ret
appenderror:
    mov     rdi, error_Append
    call    printString
    ret
;---------------------------------
global  openFile
openFile:
    mov     rax, NR_open
    mov     rsi, O_RDWR
    syscall
    cmp     rax, 0
    jl      openerror
    mov     rdi, success_Open
    push    rax
    call    printString
    pop     rax
    ret
openerror:
    mov     rdi, error_Open
    call    printString
    ret
;-----------------------------------
global  writeFile
writeFile:
    mov     rax, NR_write
    syscall
    cmp     rax, 0
    jl      writeerror
    mov     rdi, success_Write
    call    printString
    ret
writeerror:
    mov     rdi, error_Write
    call    printString
    ret
;------------------------------------
global positionFile
positionFile:
    mov     rax, NR_lseek
    syscall
    cmp     rax, 0
    jl      positionerror
    mov     rdi, success_Position
    call    printString
    ret
positionerror:
    mov     rdi, error_Position
    call    printString
    ret
;--------------------------------
global closeFile
closeFile:
    mov     rax, NR_close
    syscall
    cmp     rax, 0
    jl      closeerror
    mov     rdi, success_Close
    call    printString
    ret
closeerror:
    mov     rdi, error_Close
    call    printString
    ret
;------------------------------
global createFile
createFile:
    mov     rax, NR_create
    mov     rsi, S_IRUSR| S_IWUSR
    syscall
    cmp     rax, 0
    jl      createerror
    mov     rdi, success_Create
    push    rax
    call    printString
    pop     rax
    ret
createerror:
    mov     rdi, error_Create
    call    printString
    ret
;---------------------------------
global printString
printString:
    mov     r12, rdi
    mov     rax, 0
strLoop:
    cmp     byte [r12], 0
    je      strDone
    inc     rdx
    inc     r12
    jmp     strLoop
strDone:
    cmp     rdx, 0
    je      prtDone
    mov     rsi, rdi
    mov     rax, 1
    mov     rdi, 1
    syscall
prtDone:
    ret



