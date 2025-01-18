CC = g++
.PHONY: default build run clean
FLAG = -std=c++20
SECTION = section1-29
PROGRAM = template
SRC = $(SECTION)/$(PROGRAM).cpp
OBJ = $(SRC:$(SECTION)/%.cpp=$(SECTION)/%.o)

#OBJ = headers/compare.o func.o

default: build run

build: $(OBJ)
	$(CC) -o main $^ $(FALG)

run:
	./main

$(SECTION)/$(PROGRAM).o: $(SECTION)/$(PROGRAM).cpp
	$(CC) -c $< -o $@

clean:
	rm *.o headers/*.o main


