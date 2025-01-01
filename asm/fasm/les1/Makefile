CC = fasm
.PHONY: default complie build once dump hex run clear
default: build run
compile: 

build: main.asm
	$(CC) main.asm
	ld main.o -o main

once: main.asm
	$(CC) main.asm
	ld main.o -o main

dump: main
	objdump -S -M intel -d main > obj.dump
	cat obj.dump

hex: main
	hexeditor main

run: main
	./main

clear:
	rm main.o obj.dump main
