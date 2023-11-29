bits: bits1.o printb.o
	gcc -g -o bits bits1.o printb.o -no-pie 

bits1.o: bits1.asm
	nasm -f elf64 -g -F dwarf bits1.asm -l bits1.lst

printb.o: printb.c
	gcc -c printb.c -g


bits2: bits2.o
	gcc -g -o bits2 $^ -no-pie

bits2.o: bits2.asm
	nasm -f elf64 -g -F dwarf $^
