APP = chess

SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)

.PHONY: default run build clear

default: build run clear

build: $(OBJ)
	gcc -o $(APP) $^ -lGL -lGLEW -lglfw -lcext

run:
	./$(APP)

clear:
	rm *.o $(APP)

%.o: %.c
	gcc -o $@ -c $< -lGL -lGLEW -lglfw -lcext
