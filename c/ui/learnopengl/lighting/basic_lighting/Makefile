APP = app
FLAGS = -Wall -g
LIBS = -lglfw -lglad -lm -lcext

SRC = $(wildcard *.c)
OBJ = $(SRC:%.o=%.c)

.PHONY: default build run clean

default: build run

build: $(OBJ)
	gcc -o $(APP) $^ $(FLAGS) $(LIBS)

run: 
	./$(APP)

clean:
	rm $(APP) *.o

%.o: %.c
	gcc -c $< -o $@ $(FLAGS) $(LIBS)
