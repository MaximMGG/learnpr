%include "stud_io.inc"
global _start

section .text
_start:     mov         eax, 0
again:      PRINT       "Hello"
            PUTCHAR     10 
            inc         eax
            cmp         eax, 5
            jl          again
;arr         db 1, 2, 3, 4, 5, 7
;            PRINT       arr%%
;            inc         arr
; 556
            FINISH
