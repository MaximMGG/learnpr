MAIN = Cut
SRC = main.c
OBJ = $(SRC:%.c=%.o)
FLAGS = -g -Wall -DDEBUG
LIBS = -lcext


.PHONY: default build run clear


default: clear build


build: $(OBJ)
	gcc -o $(MAIN) $^ $(LIBS) $(FLAGS)

run:
	./$(MAIN)

clear:
	rm $(MAIN) *.o

%.o: %.c
	gcc -o $@ -c $< $(LIBS) $(FLAGS)
