APP = win
SRC = ./glfwinit.c ./glad.c
OBJ = $(patsubst %.c, %.o, $(SRC))


all: $(APP)


$(APP): $(OBJ)
	gcc $^ -o $@ -lglfw -lGL

%.o: %.c
	gcc -c $< -o $@

clear:
	rm *.o win
