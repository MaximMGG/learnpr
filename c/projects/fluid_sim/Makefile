CC = gcc
NAME = fluid
FLAGS = -Wall -std=c2x -lSDL2 -lcext -O2

SRC = main.c
OBJ = $(SRC:%.c=%.o)

.PHONY: default build run clear

default: build run

build: $(OBJ)
	$(CC) -o $(NAME) $^ $(FLAGS)


run:
	./$(NAME)

clear:
	rm $(NAME) *.o

%.o: %.c
	$(CC) -c $< -o $@ $(FLAGS)

