APP = vk
LIBS = -lglfw -lvulkan -lcext
FLAGS = -Wall -Wextra -g

SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)


.PHONY: default build run clean


default: build run


run:
	./$(APP)

build: $(OBJ)
	gcc -o $(APP) $^ $(LIBS) $(FLAGS)


clean:
	rm $(APP) *.o

%.o: %.c
	gcc -c $< -o $@ $(LIBS) $(FLAGS)
