APP = app
SRC = main.c 
OBJ = $(SRC:%.c=%.o)

default: build run


debug:
	gcc -o $(APP) main.c -lGL -lglfw -lcext -lGLEW -g



build:
	gcc -o $(APP) main.c -lGL -lglfw -lcext -lGLEW

run:
	./$(APP)


%.o: %.c
	gcc -o $@ -c $<


clear:
	rm $(APP) *.o
