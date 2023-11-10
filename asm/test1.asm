section .text

    global _start

_start: 
    mov edx, len
    mov ecx, text
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, 9
    mov ecx, star
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, 1 
    mov ecx, nline
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 1
    int 0x80


section .data
    text db 'Here is 9 stars', 0xa 
    nline db 0xa
    len equ $ - text
    star times 9 db '*' 

section .bss
    buf resb 2
