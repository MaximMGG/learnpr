GCC = gcc -o $@ $^  -no-pie
NASM = nasm -f elf64 -g -F dwarf $^


sse: sse_strin4.o print16b.o
	$(GCC)

sse_strin4.o: sse_strin4.asm
	$(NASM)

sse2: sse_string5.o print16b.o
	$(GCC)

sse_string5.o: sse_string5.asm
	$(NASM)

strlen:	strlen.o
	$(GCC)

strlen.o: strlen.asm
	$(NASM)
