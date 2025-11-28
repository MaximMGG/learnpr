APP = net
SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)
LIBS = -lssl -lcrypto -lcext -lcurses
FLAGS = -Wall -Wextra

.PHONY: default build run clear

default: build run

build: $(OBJ)
		gcc -o $(APP) $^ $(LIBS) $(FLAGS) -g

clear:
		rm $(APP) *.o

%.o: %.c
		gcc -o $@ -c $< $(LIBS) -g
