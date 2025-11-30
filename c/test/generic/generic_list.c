#include <stdio.h>
#include <stdlib.h>

typedef enum {
  LDT_INT, LDT_UINT, LDT_STRING, LDT_POINTER
  
} LIST_DATA_TYPE;
 
typedef struct {
  void *data;
  unsigned int len;
  unsigned int cap;
  LIST_DATA_TYPE type;
} List;

List *list_create_INT() {
  printf("Create List int\n");
  
  return NULL;
}
List *list_create_UINT() {
  printf("Create List unsigned int\n");
  return NULL;
}
List *list_create_CHARP() {
  printf("Create List char *\n");
  return NULL; 
}
List *list_create_POINTER() {
  printf("Create List void *\n");
  return NULL;
}

void list_append_INT(List *l, int x) {
  printf("append to int list\n");
   
}
void list_append_UINT(List *l, unsigned int x) {
  printf("append to unsigned int list\n");
}
void list_append_CHARP(List *l, char *x) {
  printf("append to char *list\n");
}
void list_append_POINTER(List *l, void *x) {
  printf("append to void *list\n");
}

#define list_create(type) _Generic((type)(0),        \
                    int: list_create_INT,  \
                    unsigned int: list_create_UINT,  \
                    char*: list_create_CHARP,        \
                    void*: list_create_POINTER)();

                    
#define list_append(l, x) _Generic((typeof(x))(0), \
                    int: list_append_INT,        \
                    unsigned int: list_append_UINT,  \
                    char*: list_append_CHARP,       \
                    void*: list_append_POINTER)(l, x)
int main() {
  List *l = list_create(int);
  list_append(l, 123);

  unsigned int x = 0;
  list_append(l, x);
  char *str = "Hello world";
  list_append(l, str);

  return 0;
}
