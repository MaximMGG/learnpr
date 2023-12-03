file: file.o
	gcc -o $@ $^ -g -no-pie

file.o: file.asm
	nasm -f elf64 -g -F dwarf $^
