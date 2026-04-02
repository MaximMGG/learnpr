V = 2


con: console$(V).o
	gcc -o $@ $^ -g -no-pie

console$(V).o: console$(V).asm
	nasm -f elf64 -g -F dwarf $^
