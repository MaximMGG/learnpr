

alive2: alive2.o
	gcc -o $@ $^ -g -no-pie

alive2.o: alive2.asm
	nasm -f elf64 -g -F dwarf $< -o $@
