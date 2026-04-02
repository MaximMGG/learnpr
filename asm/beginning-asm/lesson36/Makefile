GCC = gcc -o $@ $^ -no-pie
NASM = nasm -f elf64 -g -F dwarf $^

mat: matrix4x4.o
	$(GCC)

matrix4x4.o: matrix4x4.asm
	$(NASM)
