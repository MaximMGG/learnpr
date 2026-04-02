NAME = neuro
FLAG = -std=c++17

SRC_DIR = ./src
SRC = $(wildcard $(SRC_DIR)/*.cpp)
OBJ_DIR = ./build
OBJ = $(SRC:$(SRC_DIR/%.cpp=$(OBJ_DIR)/%.o)

.PHONY: build run clean debug
default: build run



build: $(OBJ)
	g++ -o $(NAME) $(FLAG) $^ -O2

run:
	./$(NAME)

debug: $(OBJ)
	g++ -o $(NAME) $(FLAG) -g $^


%.o: %.cpp
	g++ -o $@ -c $< $(FLAG)


claen:
	rm $(NAME) ./$(OBJ_DIR)/*.o

