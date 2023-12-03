GCC = gcc -o $@	$^ -no-pie
NASM = nasm -f elf64 -g -F dwarf $^

cmd: cmdline.o
	$(GCC)

cmdline.o: cmdline.asm
	$(NASM)

mcmd: mcmd.o
	$(GCC)

mcmd.o: mcmd.asm
	$(NASM)
