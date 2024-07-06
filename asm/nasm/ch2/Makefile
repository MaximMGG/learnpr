

alive: alive.o
	gcc -o $@ $^ -g -no-pie

alive.o: l4_1.asm
	nasm -f elf64 -g -F dwarf $< -o $@
