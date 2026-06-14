#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct {
  int a;
} Allocator;


Allocator def_alloc = {.a = 666};


__attribute__((aligned(4)))
typedef struct {
  Allocator *al;
  int type_size;
  int cap;
  int len;
} Arr;



int *createArr() {
  Arr *a = malloc(sizeof(Arr) + sizeof(int) * 32);
  printf("Address of Arr in %s - %p\n", __FUNCTION__, a);
  a->al = &def_alloc;
  a->type_size = 4;
  a->cap = 32;
  a->len = 0;

  int *arr = (int *)(((char *)a) + sizeof(Arr));

  printf("Address of arr in %s - %p\n", __FUNCTION__, arr);
  return arr;
}

Arr *toArr(int *a) {
  printf("Address of arr in %s - %p\n", __FUNCTION__, a);
  Arr *p = (Arr *)(((char *)a) - sizeof(Arr));
  printf("Address of Arr in %s - %p\n", __FUNCTION__, p);
  return p;
}

int main() {

  int *arr = createArr();
  for(int i = 0; i < 24; i++) {
	arr[i] = i;
  }

  Arr *p = toArr(arr);

  for(int i = 0; i < 24; i++) {
	printf("%d - %d\n", i, arr[i]);
  }

  
  free(p);
  
  return 0;
}
