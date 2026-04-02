APP = map_test
SRC = main.cpp
OBJ = $(SRC:%.cpp=%.o)


.PHONY: default run build clear



default: build run


build: $(OBJ)
	g++ -o $(APP) $^ -lGL -lGLEW -lglfw -g


clear:
	rm $(APP) *.o


run:
	./$(APP)

%.o: %.cpp
	g++ -c $< -o $@ -lGL -lGLEW -lglfw -g

