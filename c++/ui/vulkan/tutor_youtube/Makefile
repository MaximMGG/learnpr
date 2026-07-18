APP = vk
LIBS = -lglfw -lvulkan
FLAGS = -Wall -Wextra

SRC = $(wildcard *.cpp)
OBJ = $(SRC:%.cpp=%.o)

VERT_SHADERS_SRC = $(shaders/*.vert)
FRAG_SHADERS_SRC = $(shaders/*.frag)
VERT_SHADERS_SPV = $(VERT_SHADERS_SRC:%.vert=%.vert.spv)
FRAG_SHADERS_SPV = $(FRAG_SHADERS_SRC:%.frag=%.frag.spv)

SHADERS_SRC = $(wildcard shaders/*.*)

.PHONY: default run build clean rebuild compile_shaders

default: build run

rebuild: clean build

build: $(OBJ)
		g++ -o $(APP) $^ $(LIBS) $(FLAGS)

run:
		./$(APP)

clean:
		rm $(APP) *.o

%.o: %.cpp
		g++ -c $< -o $@ $(LIBS) $(FLAGS)

compile_shaders: $(SHADERS_SRC)
		glslc $< -o $<.spv

%.vert: %.vert.spv
		glslc $@ -o $<

$.frag: %.frag.spv
		glslc %@ -o %<


