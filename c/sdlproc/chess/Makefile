NAME = chess
SRC = main.c glad/src/glad.c
OBJ = $(patsubst %.o, %.c, $(SRC))
FLAGS = -Wall -Wextra


.PHONY: build run clear debug

defalut: build run


debug: __debug run

run:
	./$(NAME)

__debug:
	gcc -o $(NAME) $(OBJ) -lSDL2 -lcext -g

build: $(OBJ)
	gcc -o $(NAME) $^ -lSDL2 -lcext $(FLAGS)

# $(OBJ): $(SRC)
# 	gcc -o $@ -c $< -lSDL2 -lcext

%.o: %.c
	gcc -o $@ -c $< -lSDL2 -lcext
