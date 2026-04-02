#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <cstdext/container/queue.h>
#include <cstdext/core.h>
#include <string.h>

queue *lq;

typedef struct {
  byte *data;
_Atomic u32 len;
  u32 capacity;
  u32 data_size;  
  pthread_mutex_t m;
_Atomic bool exist;
  pthread_t worker;  
} list;


void _list_add(list *l, ptr data) {
  pthread_mutex_lock(&l->m);
  if (l->len == l->capacity) {
    l->capacity <<= 1;
    l->data = realloc(l->data, l->data_size * l->capacity);
  }
  memcpy(l->data + l->len * l->data_size, data, l->data_size);
  l->len++;  

  pthread_mutex_unlock(&l->m);
}

void *__list_add_queue(void *_l) {
  list *l = (list *)_l;
  fprintf(stderr, "Worker begine workd\n");
  while (lq->size != 0 || l->exist) {
    if (lq->size != 0) {
      ptr data = queue_pop(lq);
      _list_add(l, data);
    }
  }
  fprintf(stderr, "Worker and work\n");
  return null;  
}

ptr list_get(list *l, u32 index) {
  pthread_mutex_lock(&l->m);
  
  if (index >= l->len)
    return null;
  
  pthread_mutex_unlock(&l->m);
  return l->data + l->data_size * index;
}

void list_add(list *l, ptr data) {
  queue_push(lq, data);
}

list *list_create() {
  lq = queue_create(PTR);
  list *l = make(list);
  l->exist = true;
  pthread_mutex_init(&l->m, null);
  l->data_size = 4;
  l->capacity = 20;
  l->data = alloc(l->data_size * l->capacity);
  l->len = 0;
  pthread_t worker;
  pthread_create(&l->worker, null, __list_add_queue, l);
  //  pthread_detach(l->worker);  
  return l;
}



void list_destroy(list *l) {
  dealloc(l->data);
  pthread_mutex_destroy(&l->m);
  l->exist = false;  
  dealloc(l);
}

int main() {

  list *l = list_create();

  for (i32 i = 0; i < 100; i++) {
    list_add(l, &i);
  }
  l->exist = false;
  pthread_join(l->worker, null);  

  for (i32 i = 0; i < 100; i++) {
    i32 res = *(i32 *)list_get(l, i);
    fprintf(stderr, "%d\n", res);
  }
  
  list_destroy(l);
  return 0;
}
