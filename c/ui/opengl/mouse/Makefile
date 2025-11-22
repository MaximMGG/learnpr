APP = mouse
SRC = main.c camera.c
OBJ = $(SRC:%.c=%.o)
LIBS = -lGL -lGLEW -lglfw -lcext

.PHONY: default build run clear

default: build run


build: $(OBJ)
	gcc -o $(APP) $^ $(LIBS) ../lib/libutil.a

run:
	./$(APP)

clear:
	rm *.o $(APP)

%.o: %.c
	gcc -o $@ -c $<
