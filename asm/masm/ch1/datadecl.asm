.data
    char db 1 ;unsigned 8-bit
    char1 sbyte -1 ;signed 8-bit
    short dw 2; unsigned 16-bit 
    short1 sword -2; signed 16-bit 
    int dd 3 ; unsigned 32-bit
    int1 sdword -3 ; signed 32-bit
    long dq 4 ; unsigned 64-bit
    long1 sqword -4 ; signed 64-bit
    sp tbyte 5 ; unsigned 80-bit or (sp dt 5)
    moresp oword 6 ; 128-bit (orctal-word)
    float real4 1.0 ;32-bit float-point (single-precision)
    double real8 2.0 ; 64 bit float-point (double-precision)
    ddboule real10 ;Extended-precision 80-bit float-point
    ;alsough we can set ?
    i8 sbyte ?
    u8 byte ?
    i32 sdword ?
    ;...
    
