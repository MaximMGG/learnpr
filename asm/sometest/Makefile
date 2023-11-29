wor: word.o
	gcc -o word $^ -g -no-pie

word.o: word.asm
	nasm -f elf64 -g -F dwarf $^


macro: macro.o
	gcc -o $@ $^ -g -no-pie

macro.o: macro.asm
	nasm -f elf64 -g -F dwarf $^
