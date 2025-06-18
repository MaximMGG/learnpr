NAME = chip
LIB = -lSDL2
FLAGS = -Wall

SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)

.PHONY = build clear

default: build

build: $(OBJ)
	gcc -o $(NAME) $^ $(LIB)

%.o: %.c
	gcc -o $@ -c $< $(LIB)

clear:
	rm $(NAME) *.o



