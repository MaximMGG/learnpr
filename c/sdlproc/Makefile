CC = gcc
SRC = ray_trace.c
OBJ = ray_trace.o

.PHONY: default build run clear


default: $(OBJ)
	$(CC) $(OBJ) -o prog -lSDL2 -lm
	./prog

build: $(OBJ)
	$(CC) $(OBJ) -o prog -lSDL2 -lm

run: prog
	./prog

clear:
	rm prog *.o

%.o: %.c
	$(CC) -c $< -o $@ -lSDL2 -lm
