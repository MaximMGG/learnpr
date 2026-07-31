APP = app


SRC = $(wildcard *.c)
OBJ = $(SRC:%.o=%.c)


.PHONY: default build run clean


default: build run

build: $(OBJ)
	gcc -o $(APP) $^ -lcext -lglad -lglfw -lm -g

run:
	./$(APP)

%.o: %.c
	gcc -c $< -o $@ -lcext -lglad -lglfw -lm -g

clean:
	rm $(APP) *.o


