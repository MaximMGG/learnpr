MAIN = sse_a
GCC = gcc -o $@ $^ -no-pie
NASM = nasm -f elf64 -g -F dwarf $^



$(MAIN): sse_aligned.o
	$(GCC)

sse_aligned.o: sse_aligned.asm
	$(NASM)
