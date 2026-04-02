CC = g++
.PHONY: default build run clean;
SRC = headers/compare.cpp func.cpp
OBJ = $(patsubst %.cpp, %.o, $(SRC))

#OBJ = headers/compare.o func.o

default: build run

build: $(OBJ)
	$(CC) -o main $^

run:
	./main

%.o: %.cpp
	$(CC) -c $< -o $@

clean:
	rm *.o headers/*.o main


