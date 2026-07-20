APP = app
CC = g++
LIBS = -lmh -lglfw -lglad


SRC = main.cpp shader.hpp


.PHONY: build run clean default


default: build run


build: $(SRC)
		$(CC) -o $(APP) $^ $(LIBS)

run:
		./$(APP)


clean:
		rm $(APP)
