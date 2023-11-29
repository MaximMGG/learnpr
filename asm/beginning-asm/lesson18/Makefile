macro: macro.o
	gcc -o $@ $^ -no-pie -g

macro.o: macro.asm
	nasm -f elf64 -g -F dwarf $^
