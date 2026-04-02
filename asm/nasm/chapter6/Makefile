
number: number.o
	gcc -o $@ $^ -g -no-pie

number.o: number.asm
	nasm -f elf64 -g -F dwarf $<
