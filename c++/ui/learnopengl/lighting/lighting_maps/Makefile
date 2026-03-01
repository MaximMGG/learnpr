APP = map
SRC = main.cpp
OBJ = $(SRC:%.cpp=%.o)


.PHONY: default build run clear



default: build run



build: $(OBJ)
	g++ -o $(APP) $^ -lGL -lGLEW -lglfw

run:
	./$(APP)

clear:
	rm $(APP) *.o

%.o: %.cpp
	g++ -c $< -o $@ -lGL -lGLEW -lglfw
