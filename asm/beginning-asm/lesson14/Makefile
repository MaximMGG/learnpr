MAIN = func
SRC = $(wildcard *.asm)
OBJ = $(patsubst %.asm, %.o, $(SRC))

$(MAIN): $(OBJ)
	gcc -g -o $(MAIN) $(OBJ)

$(OBJ): $(SRC)
	nasm -f elf64 -g -F dwarf funcion4.asm
	nasm -f elf64 -g -F dwarf circle.asm
	nasm -f elf64 -g -F dwarf rect.asm


