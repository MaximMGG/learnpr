APP = cube

SRC = $(wildcard *.cpp)
OBJ = $(SRC:%.cpp=%.o)

.PHONY: default build run clear

default: build run

build: $(OBJ)
	g++ -o $(APP) $^ -lGL -lGLEW -lglfw

run:
	./$(APP)

clear:
	rm *.o ./$(APP)

%.o: %.cpp
	g++ -c $< -o $@ -lGL -lGLEW -lglfw
