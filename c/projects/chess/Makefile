APP = chess
SRC = main.c
OBJ = $(SRC:%.c=%.o)

.PHONY: default build run clear

default: build run


build: $(OBJ)
	gcc -o $(APP) $(OBJ) -lcext -lGL -lGLEW -lglfw

run:
	./$(APP)


clear:
	rm *.o $(APP)


%.o: %.c
	gcc -o $@ -c $< -lcext -lGL -lGLEW -lglfw
