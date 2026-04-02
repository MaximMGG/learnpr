APP = calc
SRC = calc.c

.PHONY: default run clear build

default: build run

build:
	gcc -o $(APP) $(SRC) -lcext -g

run:
	./$(APP)

clear:
	rm $(APP)
