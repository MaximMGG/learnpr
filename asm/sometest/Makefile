NASM = nasm -f elf64 -g -F dwarf $^
GCC = gcc -o $@ $^ -g -no-pie


wor: word.o
	gcc -o word $^ -g -no-pie

word.o: word.asm
	nasm -f elf64 -g -F dwarf $^


macro: macro.o
	gcc -o $@ $^ -g -no-pie

macro.o: macro.asm
	nasm -f elf64 -g -F dwarf $^

format: format.o
	$(GCC)

format.o: format.asm
	$(NASM)

login: getlogin.o
	$(GCC)

getlogin.o: getlogin.asm
	$(NASM)
