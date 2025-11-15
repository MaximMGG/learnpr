APP = chess 
LIBS = -lGL -lGLEW -lglfw -lcext
WARN = -Wall -Wextra

SRC = $(wildcard *.c)
OBJ = $(SRC:%.c=%.o)

.PHONY: default run build clear

default: build run clear

build: $(OBJ)
	gcc -o $(APP) $^ $(LIBS) $(WARN)

run:
	./$(APP)

clear:
	rm *.o $(APP)

%.o: %.c
	gcc -o $@ -c $< $(LIBS) $(WARN)
