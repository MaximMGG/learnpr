
GCC = gcc -o $@ $^ -g -no-pie
NASM = nasm -f elf64 -g -F dwarf $^


all: file ownf 

file: file.o
	$(GCC)

file.o: file.asm
	$(NASM)

ownf: ownfile.o
	$(GCC)

ownfile.o: ownfile.asm
	$(NASM)
