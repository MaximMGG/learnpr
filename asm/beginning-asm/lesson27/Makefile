GCC = gcc -o $@ $^ -no-pie -g
NASM = nasm -f elf64 -g -F dwarf $^

mxcsr: mxcsr.o print_hex.c print_mxcsr.c
	$(GCC)

mxcsr.o: mxcsr.asm
	$(NASM)

