APP = draw
SRC = drow_triangle.c
OBJ = $(SRC:%.c=%.o)


.PHONY: default build run clear

default: build run


build: $(OBJ)
	gcc -o $(APP) $(OBJ) -lGL -lglfw -lGLEW -lcext

debug: $(OBJ)
	gcc -o $(APP) $(OBJ) -lGL -lglfw -lGLEW -lcext -g

run:
	./$(APP)

%.o: %.c
	gcc -o $@ -c $< -lGL -lglfw -lGLEW -lcext -g

clear:
	rm $(APP) *.o



