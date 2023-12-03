MAIN = run 
GCC = gcc -o $@ $^ -no-pie -g
NASM = nasm -f elf64 -g -F dwarf $^

SRC_ASM = $(wildcard *.asm)
OBJ_ASM	= $(patsubst %.asm, %.o, $(SRC_ASM))

$(MAIN): $(OBJ_ASM) fromc.c
	$(GCC)

%.o: %.asm
	$(NASM)

