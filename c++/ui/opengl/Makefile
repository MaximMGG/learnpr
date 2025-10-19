APP = app

SRC = $(wildcard *.cpp)
OBJ = $(SRC:%.cpp=%.o)
LIBS = -lGL -lglfw -lGLEW


.PHONY: default build run clear

default: build run

build: $(OBJ)
	g++ -o $(APP) $(OBJ) $(LIBS)

run:
	./$(APP)


clear:
	rm *.o $(APP)

%.o: %.cpp
	g++ -o $@ -c $<
