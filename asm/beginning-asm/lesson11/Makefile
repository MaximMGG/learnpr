fcalc: fcalc.o
	gcc -o fcalc fcalc.o -no-pie
%.o:%.asm
	nasm -f elf64 -g $^ -l fcalc.lst

