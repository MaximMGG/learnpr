fcalc: fcalc.o
	gcc -o fcalc fcalc.o -no-pie -g 
%.o:%.asm
	nasm -f elf64 -g -F dwarf $^ -l fcalc.lst

