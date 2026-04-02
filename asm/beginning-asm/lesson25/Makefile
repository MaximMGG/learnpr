GCC = gcc -o $@ $^ -no-pie -g
NASM = nasm -f elf64 -g -F dwarf $^

cpu: cpu.o
	$(GCC)

cpu.o: cpu.asm
	$(NASM)
