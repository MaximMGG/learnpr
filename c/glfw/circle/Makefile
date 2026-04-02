MAIN = circle


$(MAIN):
	gcc -o $@ circle.c -lglfw -lGL -lm
	./$(MAIN)

debug:
	gcc -o $@ circle.c -lglfw -lGL -g

clear:
	rm $(MAIN)
