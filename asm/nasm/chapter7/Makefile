
all = greater jumploop

jumploop: jumploop.o
	gcc -o $@ $^ -g -no-pie

jumploop.o: jumploop.asm
	nasm -f elf64 -g -F dwarf $<

greater: greater.o
	gcc -o $@ $^ -g -no-pie

greater.o: greater.asm
	nasm -f elf64 -g -F dwarf $<
