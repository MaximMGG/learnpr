BIND = func func2
all: $(BIND)

func:func.o
	gcc -o func func.o -no-pie
%.o:%.asm
	nasm -f elf64 -g -F dwarf $^ -l func.lst

func2:func2.o
	gcc -o func2 func2.o -no-pie

clean:
	rm *.o *.lst $(BIND)
