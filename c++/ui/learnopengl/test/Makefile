APP = cube
SRC = test_cube.cpp
OBJ = $(SRC:%.cpp=%.o)

.PHONY: default build run clear

default: build run

build: $(OBJ)
	g++ -o $(APP) $^ -lGL -lGLEW -lglfw -g

%.o: %.cpp
	g++ -o $@ -c $< -lGL -lGLEW -lglfw -g

run:
	./$(APP)

clear:
	rm $(APP) *.o
