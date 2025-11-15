APP = cube
SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)
LIBS = -lGL -lGLEW -lglfw -lcext -lm ../lib/libutil.a


.PHONY: default build run clear

default: build run

build: $(OBJ)
	gcc -o $(APP) $^ $(LIBS)

run:
	./$(APP)

%.o: %.c
	gcc -o $@ -c $<

clear:
	rm $(APP) *.o
