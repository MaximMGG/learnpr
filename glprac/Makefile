MAIN = gl
SRC = main2.c
OBJ = $(patsubst %.c, %.o, $(SRC))


$(MAIN): $(OBJ)
	gcc -o $@ $^ -g -lglfw  -lGL

%.o:%.c
	gcc -o $@ -c $< -g
