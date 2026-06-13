#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
  int i;
} Allocator;
 


void *_arrCreate(int data_size, int count, ...) {
  va_list li;

  va_start(li, count);

  Allocator *a = va_arg(li, Allocator *);
  if (a == NULL) {
	printf("Use std allocator\n");
  } else {
	printf("Use custom allocator\n");
  }
  va_end(li);
  return NULL;
}

#define arrCreate(data_size, count, args...) _arrCreate(data_size, count, ## args, NULL)

int main() {
  Allocator *a = malloc(sizeof(Allocator));

  int *arr = arrCreate(4, 10, a);
  int *ii = _arrCreate(1, 2);

  int *arr2 = arrCreate(4, 10);
  return 0;
}
