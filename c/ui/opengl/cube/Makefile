APP = cube
SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)

.PHONY: default build run clear

default: build run

build: $(OBJ)
	gcc -o $(APP) $^ -lGL -lGLEW -lglfw -lcext -lm

run:
	./$(APP)

%.o: %.c
	gcc -o $@ -c $< -lGL -lGLEW -lglfw -lcext -lm

clear:
	rm $(APP) *.o
