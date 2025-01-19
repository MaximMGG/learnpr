CC = g++
.PHONY: default build run clean
FLAG = -std=c++20
SECTION = section30
PROGRAM = example
SRC = $(SECTION)/$(PROGRAM).cpp
OBJ = $(SRC:$(SECTION)/%.cpp=$(SECTION)/%.o)

#OBJ = headers/compare.o func.o

default: build run

build: $(OBJ)
	$(CC) -o main $^ $(FALG)

run:
	./main

$(SECTION)/$(PROGRAM).o: $(SECTION)/$(PROGRAM).cpp
	$(CC) $(FLAG) -c $< -o $@

clean:
	rm $(SECTION)/*.o ./main


