bits: bits3.o printb.o
	gcc -o bits $^ -g -no-pie

bits3.o: bits3.asm
	nasm -f elf64 -g -F dwarf $^

printb.o: printb.c
	gcc -c $^
