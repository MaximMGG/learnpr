APP = app
SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)

default: build run

debug: $(OBJ)
	gcc -o $(APP) $(OBJ) -lGL -lglfw -lcext -lGLEW -g

build: $(OBJ)
	gcc -o $(APP) $(OBJ) -lGL -lglfw -lcext -lGLEW

run:
	./$(APP)

# $(OBJ): $(SRC)
# 	gcc -o $@ -c $<

%.o: %.c
	gcc -o $@ -c $<

clear:
	rm $(APP) *.o
