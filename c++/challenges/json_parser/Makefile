NAME = jsonp
CC = g++

SRC = $(wildcard *.cpp)
OBJ = $(SRC:*.cpp=*.o)

.PHONY: build run clear

build: $(OBJ)
	$(CC) -o $(NAME) $^

%.o:%.cpp
	$(CC) -o $@ -c $<

clear:
	rm $(NAME) *.o
