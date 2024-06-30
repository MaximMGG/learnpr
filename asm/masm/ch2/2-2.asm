option casemap:none

nl = 10
.data

leftOp		dd	0f0f0f0fh
rightOp1	dd	0f0f0f0f0h
rightOp2	dd	12345678h
titleStr	db	"Listening 2-2", 0

fmtStr1		db	"%lx AND %lx = %lx", nl, 0
fmtStr2		db	"%lx OR %lx = %lx", nl, 0
fmtStr3		db	"%lx XOR %lx = %lx", nl, 0
fmtStr4		db	"NOT %lx = %lx", nl, 0

mainFmt		db	"Calling %s", 10, 0
mainFmt2	db	"Terminating %s", 10, 0


.code

externdef	printf:proc

public getTitle
getTitle proc
	lea		rax, titleStr
	ret
getTitle endp

public main
main proc
	sub		rsp, 56	
	call	getTitle
	mov		rdx, rax
	lea		rcx, mainFmt
	call	printf
	call	asmMain
	call	getTitle
	mov		rdx, rax
	lea		rcx, mainFmt2
	call	printf
	add		rsp, 56
	ret

main endp

public asmMain
asmMain proc
	sub		rsp, 56

;Demontrating AND operation
	lea		rcx, fmtStr1
	mov		edx, leftOp
	mov		r8d, rightOp1
	mov		r9d, edx
	and		r9d, r8d
	call	printf

	lea		rcx, fmtStr1
	mov		edx, leftOp
	mov		r8d, rightOp2
	mov		r9d, edx
	and		r9d, r8d
	call	printf
;Demonstrating OR operationg

	lea		rcx, fmtStr2
	mov		edx, leftOp
	mov		r8d, rightOp1
	mov		r9d, edx
	or		r9d, r8d
	call	printf

	lea		rcx, fmtStr2
	mov		edx, leftOp
	mov		r8d, rightOp2
	mov		r9d, edx
	or		r9d, r8d
	call	printf

;Demonstrating XOR operation	
	
	lea		rcx, fmtStr3
	mov		edx, leftOp
	mov		r8d, rightOp1
	mov		r9d, edx
	xor		r9d, r8d
	call	printf
	
	lea		rcx, fmtStr3
	mov		edx, leftOp
	mov		r8d, rightOp2
	mov		r9d, edx
	xor		r9d, r8d
	call	printf

;Demonstrating NOT operation
	lea		rcx, fmtStr4
	mov		edx, leftOp
	mov		r8d, edx 
	not		r8d
	call	printf

	lea		rcx, fmtStr4
	mov		edx, rightOp1
	mov		r8d, edx 
	not		r8d
	call	printf

	lea		rcx, fmtStr4
	mov		edx, rightOp2
	mov		r8d, edx 
	not		r8d
	call	printf

	add		rsp, 56
	ret

asmMain endp
end

