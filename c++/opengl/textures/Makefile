APP = app
SRC = stb_image.cpp main.cpp
OBJ = $(SRC:%.cpp=%.o)


.PHONY: build clear run default


default: build run


build: $(OBJ)
	g++ -o $(APP) $(OBJ) -lGL -lglfw -lGLEW

run:
	./$(APP)


%.o: %.cpp
	g++ -o $@ -c $< -lGL -lglfw -lGLEW
