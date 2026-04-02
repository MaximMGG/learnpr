NAME = chip
LIB = -lSDL2
FLAGS = -Wall -Wextra -Werror

SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)

.PHONY = build clear

default: build

build: $(OBJ)
	gcc -o $(NAME) $^ $(LIB) $(FLAGS)

%.o: %.c
	gcc -o $@ -c $< $(LIB) $(FLAGS)

clear:
	rm $(NAME) *.o



