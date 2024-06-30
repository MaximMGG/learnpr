#include <stdio.h>

extern void asmMain(void);
extern char *getTitle(void);

int main() {

	printf("Calling %s\n", getTitle());
	asmMain();
	printf("Terminated %s\n", getTitle());

	return 0;
}