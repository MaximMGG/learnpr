CC = gcc -O0
.PHONY: default build run clean
default: build run
build: main.c builder.c
	$(CC) -o builder builder.c
	$(CC) -o main main.c

run:
	./builder
	./main

clean:
	rm ./builder ./main
