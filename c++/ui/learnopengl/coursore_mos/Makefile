APP = mouse
SRC = $(wildcard *.cpp)
OBJ = $(SRC:%.cpp=%.o)
LIBS = -lGL -lGLEW -lglfw

.PHONY: default build run clear

default: clear build run

run:
	./$(APP)

build: $(OBJ)
	c++ -o $(APP) $^ $(LIBS)

clear:
	rm *.o $(APP)

%.o: %.cpp
	c++ -o $@ -c $< $(LIBS)
