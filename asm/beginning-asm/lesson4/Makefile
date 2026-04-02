lesson: alive2.o
	gcc -o lesson alive2.o -no-pie

alive2.o: alive2.asm
	nasm -f elf64 -g -F dwarf alive2.asm -l lesson.lst

clean: 
	rm *.o *.lst lesson
