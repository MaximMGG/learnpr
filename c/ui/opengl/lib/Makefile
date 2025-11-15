OUT = libutil.a
SRC = ArrayBuffer.c ElementBuffer.c shader.c texture.c VertexArray.c
OBJ = $(SRC:%.c=%.o)
LIBS = -lGL -lGLEW -lcext

.PHONY: build clear default

default: build


build: $(OBJ)
	ar rcs -o $(OUT) $^

clear:
	rm *.o

%.o: %.c
	gcc -o $@ -c $< $(LIBS)

