GCC = gcc -o $@ $^ -no-pie -g
NASM = nasm -f elf64 -g -F dwarf $^

shuff: shuffle.o
	$(GCC)

shuffle.o: shuffle.asm
	$(NASM)

tt: test.o
	$(GCC)

test.o: test.asm
	$(NASM)

tt2: test2.o
	$(GCC)

test2.o: test2.asm
	$(NASM)
