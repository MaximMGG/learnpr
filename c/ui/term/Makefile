APP = term
SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)
debug_flag = 
LIB = cext

.PHONY: build run clear default

default: build run

build: $(OBJ)
	gcc -o $(APP) $(OBJ) -l$(LIB) $(debug_flag)

run:
	./$(APP)

%.o: %.c
	gcc -o $@ -c $< -l$(LIB) $(debug_flag)

clear:
	rm $(APP) *.o
