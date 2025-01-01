CC = fasm
.PHONY: default compile once run hex dump clear

default: main.asm
	$(CC) main.asm
	ld main.o -o main
	./main

once: main.asm
	$(CC) main.asm
	ld main.o -o main

dump: main
	objdump -S -M intell ./main > obj.dump

hex: main
	hexdump

run: main
	./main

clear:
	rm main main.o obj.dump
