NAME = hello_window
CC = g++
LIB = -lglfw -lGL
FLAGS_DEBUG = -std=c++17 -Wall -g
FLAGS_RELEASE = -std=c++17 -O2

BUILD_TYPE = DEBUG
#RELEASE

ifeq ($(BUILD_TYPE), DEBUG)
	FLAGS = $(FLAGS_DEBUG)
else
	FLAGS = $(FLAGS_RELEASE)
endif


OBJ_DIR = ./obj

SRC_DIR = ./src

SRC_C = $(wildcard $(SRC_DIR)/*.c)
SRC_CPP = $(wildcard $(SRC_DIR)/*.cpp)
OBJ = $(SRC_C:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o) $(SRC_CPP:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)


.PHONY: default build run clear

default: $(OBJ)
	$(CC) $(FLAGS) -o $(NAME) $(OBJ) $(LIB)
	./$(NAME)

build: $(OBJ)
	$(CC) $(FLAGS) -o $(NAME) $(OBJ) $(LIB)

run:
	./$(NAME)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	$(CC) $(FLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(FALGS) -c $< -o $@

clear:
	rm $(OBJ_DIR)/*.o $(NAME)
