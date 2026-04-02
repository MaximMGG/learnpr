option casemap:none

nl = 10

.data
	i	dq	1
	j	dq	123
	k	dq	456789

	titleStr	db	"Listing 2-1", 0

	fmtStrI		db	"i=%d, converted to hex=%x", nl, 0
	fmtStrJ		db	"j=%d, converted to hex=%x", nl, 0
	fmtStrK		db	"k=%d, converted to hex=%x", nl, 0

.code

externdef	printf:proc

public getTitle

getTitle proc
	lea		rax, titleStr
	ret
getTitle endp

public asmMain
asmMain proc
	sub		rsp, 56
	lea		rcx, fmtStrI
	mov		rdx, i
	mov		r8, rdx
	call	printf

	lea		rcx, fmtStrK
	mov		rdx, j
	mov		r8, rdx
	call	printf

	lea		rcx, fmtStrJ
	mov		rdx, k
	mov		r8, rdx
	call	printf
	add		rsp, 56
	ret

asmMain endp
end
