MAIN = sse_i
GCC = gcc -o $@ $^ -no-pie
NASM = nasm -f elf64 -g -F dwarf $^

$(MAIN): sse_integer.o
	$(GCC)

sse_integer.o: sse_integer.asm
	$(NASM)

tt:test.o
	$(GCC)

test.o: test.asm
	$(NASM)
