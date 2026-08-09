APP = app
FLAGS = -g -Wall
LIBS = -lcext -lglfw -lglad -lm

SRC = $(wildcard *.c)
OBJ = $(SRC:%.o=%.c)

.PHONY: default build run clean

default: build run

build: $(OBJ)
		gcc -o $(APP) $^ $(FLAGS) $(LIBS)

run:
		./$(APP)

clean:
		rm ./$(APP) *.o

%.o: %.c
		gcc -c $< -o $@ $(FLAGS) $(LIBS)
