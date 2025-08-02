CC = gcc
FLAGS = -Wall -std=c2x -lSDL2 -lm
NAME = cube

SRC = main.c
OBJ = $(SRC:%.c=%.o)


.PHONY: default build clear run

default: build run

run:
	./$(NAME)

build: $(OBJ)
	$(CC) -o $(NAME) $^ $(FLAGS)

%.o: %.c
	$(CC) -c $< -o $@ $(FLAGS)

clear:
	rm $(NAME) *.o
