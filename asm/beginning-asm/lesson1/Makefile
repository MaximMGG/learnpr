lesson: lesson1.o
	gcc -o lesson lesson1.o -no-pie
lesson1.o: lesson1.asm
	nasm -f elf64 -g -F dwarf lesson1.asm -l lesson1.lst
clean:
	rm *.o lesson1.lst lesson
