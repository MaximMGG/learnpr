#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  char *data;
  int len;
  int cap;
  int data_size;
} Arr;

Arr *_arr_create(int size_of_type) {
  Arr *a = malloc(sizeof(Arr));
  a->data_size = size_of_type;
  a->cap = 20;
  a->len = 0;
  a->data = malloc(a->cap * a->data_size);
  memset(a->data, 0, a->cap * a->data_size);

  return a;
}

void arr_add(Arr *a, void *p) {
  memcpy(a->data + (a->len * a->data_size), p, a->data_size);
  a->len++;
  if (a->len == a->cap) {
    a->cap <<= 1;
    a->data = realloc(a->data, a->cap * a->data_size);
  }
}

void arr_add_ptr(Arr *a, void *p) {
  void **buf = (void **)a->data;
  buf[a->len] = p;
  // memcpy(a->data + (a->len * a->data_size), &p, a->data_size);
  a->len++;
  if (a->len == a->cap) {
    a->cap <<= 1;
    a->data = realloc(a->data, a->cap * a->data_size);
  }
}

void *arr_get(Arr *a, int index) {
  if (index < 0 || index >= a->len) {
    return NULL;
  }
  void *p = a->data + (a->data_size * index);
  return p;
}

void *arr_get_ptr(Arr *a, int index) {
  if (index < 0 || index >= a->len) {
    return NULL;
  }

  void **buf = (void **)a->data;
  return buf[index];
}

void arr_destroy(Arr *a) {
  free(a->data);
  free(a);
}

#define arr_create(type) _arr_create(sizeof(type))

int main() {
  Arr *a = arr_create(int);

  for(int i = 0; i < 10; i++) {
    arr_add(a, &i);
  }

  for(int i = 0; i < 10; i++) {
    int tmp = *(int *)arr_get(a, i);
    printf("%d\n", tmp);
  }

  arr_destroy(a);

  a = arr_create(char *);

  char *msg = "Test msg";

  for(int i = 0; i < 5; i++) {
    arr_add_ptr(a, msg);
  }

  for(int i = 0; i < 5; i++) {
    char *tmp = arr_get_ptr(a, i);
    printf("%s\n", tmp);
  }

  arr_destroy(a);

  return 0;
}

