calc: icalc.o
	gcc -o calc icalc.o -no-pie
icalc.o: icalc.asm
	nasm -f elf64 -g -F dwarf icalc.asm -l icalc.lst
clean:
	rm *.o *.lst calc
