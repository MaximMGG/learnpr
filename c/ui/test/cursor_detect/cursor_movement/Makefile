APP = app
LIBS = -lcext -lglfw -lglad -lm
FLAGS = -Wall -g

SRC = $(wildcard *.c)
OBJ = $(SRC:*.o=*.c)

.PHONY: default build run clean

default: build run

build: $(OBJ)
	gcc -o $(APP) $^ $(LIBS) $(FLAGS)

run:
	./$(APP)

clean:
	rm $(APP) *.o

%.o: %.c
	gcc -c $< -o $@ $(LIBS) $(FLAGS)
