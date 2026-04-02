test: test1.o
	ld -m elf_i386 test1.o -o test

test1.o: test1.asm
	nasm -f elf test1.asm

clean:
	rm *.o test
