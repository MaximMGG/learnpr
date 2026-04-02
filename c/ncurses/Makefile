
LIB = -lncurses -lpanel
SRC = panel.c
OBJ = $(SRC:%.c=%.o)
.PHONY: build run clear

default: build run

build: $(OBJ)
	gcc -o cur $^ -g $(LIB)

%.o: %.c
	gcc -o $@ -c $< -g $(LIB)

run:
	./cur

clear:
	rm *.o rm ./cur
