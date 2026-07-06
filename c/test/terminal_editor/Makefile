CC = gcc
FLAGS = -lcext -Wall -g
PROG = term


SRC = $(wildcard *.c)
OBJ = $(SRC:*.c=*.o)


.PHONY: default build run clear


default: build run



build: $(OBJ)
	$(CC) -o $(PROG) $^ $(FLAGS)

run: 
	./$(PROG)


clear:
	rm $(PROG) *.o

%.o: %.c
	$(CC) -o $@ -c $< $(FLAGS)


