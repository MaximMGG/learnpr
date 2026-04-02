APP = engine
SRC = $(wildcard ./editor/src/*.cpp) $(wildcard ./util/*.cpp) $(wildcard ./window/*.cpp)
OBJ = $(SRC:%.cpp=%.o)

.PHONY: default build run clear

default: clear build run

build: $(OBJ)
	g++ -o $(APP) $^ -lGL -lGLEW -lSDL2

clear:
	rm $(APP) 
	rm ./util/*.o
	rm ./window/*.o
	rm ./editor/src/*.o

run:
	./$(APP)

%.o: %.cpp
	g++ -o $@ -c $< -lGL -lGLEW -lSDL2
