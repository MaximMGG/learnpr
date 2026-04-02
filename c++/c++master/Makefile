CC = g++
.PHONY: default build run clean
FLAG = -std=c++20 -g
SECTION = section31
PROGRAM = class
#SRC = $(SECTION)/$(PROGRAM).cpp
#SRC = $(SECTION)/class.cpp $(SECTION)/cylinder.cpp // the same shit!
SRC = $(wildcard $(SECTION)/*.cpp)
OBJ = $(SRC:$(SECTION)/%.cpp=$(SECTION)/%.o)


#OBJ = headers/compare.o func.o

default: tell build run


tell:
	echo $(SRC)

debug: $(OBJ)
	$(CC) -o $(PROGRAM) $^ $(FALG)
	./$(PROGRAM)

build: $(OBJ)
	$(CC) -o $(PROGRAM) $^ $(FALG)

run:
	./$(PROGRAM)

#$(SECTION)/$(PROGRAM).o: $(SECTION)/$(PROGRAM).cpp
#	$(CC) $(FLAG) -c $< -o $@

$(SECTION)/%.o: $(SECTION)/%.cpp
	$(CC) $(FLAG) -c $< -o $@

clean:
	rm $(SECTION)/*.o ./$(PROGRAM)


