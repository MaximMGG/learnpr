APP = light
SRC = $(wildcard *.cpp)
OBJ = $(SRC:%.cpp=%.o)
LIBS = -lGL -lGLEW -lglfw

.PHONY: default build run clear

build: $(OBJ)
		g++ -o $(APP) $^ $(LIBS)

run:
			./$(APP)

claer:
		rm $(APP) *.o

%.o: %.cpp
		g++ -o $@ -c $< $(LIBS)
