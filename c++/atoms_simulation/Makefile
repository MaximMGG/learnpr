APP = atom
SRC = atom.cpp
OBJ = $(SRC:%.cpp=%.o)


.PHONY: default build run clear



default: build run

build: $(OBJ)
	g++ -o $(APP) $^ -lGL -lGLEW -lglfw
	

%.o: %.cpp
	g++ -c $< -o $@ -lGL -lGLEW -lglfw

clear:
	rm $(APP) *.o

run:
	./$(APP)
