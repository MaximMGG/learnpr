GCC = gcc -o $@ $^ -no-pie
NASM = nasm -f elf64 -g -F dwarf $^


avx: cpu_avx.o
	$(GCC)

cpu_avx.o: cpu_avx.asm
	$(NASM)

avx2: avx_unaligned.o
	$(GCC)

avx_unaligned.o: avx_unaligned.asm
	$(NASM)

avxtest: avx_test.o
	$(GCC)

avx_test.o: avx_test.asm
	$(NASM)
