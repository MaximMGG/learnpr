gcc = gcc -o $@ $^ -no-pie
nasm = nasm -f elf64 -g -F dwarf $^

sse: sse_string2_imp.o
	$(gcc)

sse_string2_imp.o: sse_string2_imp.asm
	$(nasm)

sse_e: sse_string3_exp.o
	$(gcc)

sse_string3_exp.o: sse_string3_exp.asm
	$(nasm)

tat: test.o
	$(gcc)

test.o: test.asm
	$(nasm)
