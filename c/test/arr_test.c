#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUMBER 1
#define POINTER 2
#define DEF_CAP 4


typedef struct {
  char *data;
  int len;
  int cap;
  int type_size;
} Arr;

Arr *createArr(int TYPE) {
  Arr *arr = malloc(sizeof(Arr));
  arr->type_size = TYPE == NUMBER ? 4 : 8;
  if (TYPE == NUMBER) {
    arr->data = malloc(sizeof(int) * DEF_CAP);
  } else {
    arr->data = malloc(sizeof(void *) * DEF_CAP);
  }
  arr->len = 0;
  arr->cap = DEF_CAP;

  return arr;
}

void arrAppend(Arr *arr, void *data) {
  //memcpy(arr->data + (arr->len * arr->type_size), data, arr->type_size);
  void **buf = (void **)arr->data;
  buf[arr->len++] = data;
  if (arr->len == arr->cap) {
    arr->data = realloc(arr->data, arr->type_size * arr->cap * 2);
    arr->cap <<= 1;
  }
}

//1, 2, 3, 4, 5
//      ^
void arrRemove(Arr *arr, int pos) {

  void **buf = malloc(arr->type_size * arr->len - pos - 1);
  memcpy(buf, arr->data + (arr->type_size * (pos + 1)), arr->type_size * (arr->len - pos - 1));
  memcpy(arr->data + (arr->type_size * pos), buf, arr->type_size * (arr->len - pos - 1));
  memset(arr->data + (arr->type_size * (arr->len - 1)), 0, arr->type_size);
  arr->len--;
  free(buf);
}



void *arrGet(Arr *arr, int index) {
  void **buf = (void **)arr->data;
  return buf[index];
  // return arr->data + (arr->type_size * index);
}

void arrDestroy(Arr *arr) {
  free(arr->data);
  free(arr);
}

typedef struct {
  int age;
  char *name;
} Dog;


int main() {

  Dog *a = malloc(sizeof(Dog));
  a->age = 1;
  a->name = "Hello";
  Dog *b = malloc(sizeof(Dog));
  b->age = 2;
  b->name = "Hello";
  Dog *c = malloc(sizeof(Dog));
  c->age = 3;
  c->name = "Hello";
  Dog *d = malloc(sizeof(Dog));
  d->age = 4;
  d->name = "Hello";
  Dog *e = malloc(sizeof(Dog));
  e->age = 5;
  e->name = "Hello";

  Arr *arr = createArr(POINTER);
  arrAppend(arr, a);
  arrAppend(arr, b);
  arrAppend(arr, c);
  arrAppend(arr, d);
  arrAppend(arr, e);

  arrRemove(arr, 2);

  for(int i = 0; i < arr->len; i++) {
    Dog *tmp = arrGet(arr, i);
    printf("%d - %s\n", tmp->age, tmp->name);
  }

  arrDestroy(arr);
  free(a);
  free(b);
  free(c);
  free(d);
  free(e);

  return 0;
}
