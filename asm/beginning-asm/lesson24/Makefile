GCC = gcc -o $@ $^ -no-pie -g
NASM = nasm -f elf64 -g -F dwarf $^
MAIN = run

$(MAIN): move_strings.o
	$(GCC)

move_strings.o: move_strings.asm
	$(NASM)

str: strings.o
	$(GCC)

strings.o: strings.asm
	$(NASM)

tests: test.o
	$(GCC)

test.o: test.asm
	$(NASM)

