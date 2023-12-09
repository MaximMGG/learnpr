GCC = gcc -o $@ $^ -no-pie -g
NASM = nasm -f elf64 -g -F dwarf $^

sse: sse_string_length.o
	$(GCC)

sse_string_length.o: sse_string_length.asm
	$(NASM)

sse_l: sse_string_search.o
	$(GCC)

sse_string_search.o: sse_string_search.asm
	$(NASM)
