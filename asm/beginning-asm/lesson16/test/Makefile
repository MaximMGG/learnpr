tes: test.o pp.o
	gcc -g -o tes $^ -no-pie

test.o: test.asm 
	nasm -f elf64 -g -F dwarf $^

pp.o: pp.c
	gcc -c $^ -g
