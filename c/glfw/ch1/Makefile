APP = app
SRC = main.c
OBJ = $(SRC:%.c=%.o)

default: build run


build:
	gcc -o $(APP) main.c -lGL -lglfw -lcext

run:
	./$(APP)


%.o: %.c
	gcc -o $@ -c $<


clear:
	rm $(APP) *.o
