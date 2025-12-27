#include <stdio.h>
#include <cstdext/core.h>

typedef void * Generic_Arr;

#define MAKE_ARR(type, _len, name) ARR_TYPE(type) name;      \
                                  name.data = alloc(sizeof(type) * _len);  \
                                  name.len = _len
#define INIT_ARR(type, _len, name) name.data = alloc(sizeof(type) * _len); name.len = _len 

#define DELETE_ARR(arr) dealloc(arr.data)

#define ARR_TYPE(type) struct{type *data; u32 len;}


typedef struct {
  i32 count;
  ARR_TYPE(u64) arr;
} Friend;

void print_names(Generic_Arr arr) {
  ARR_TYPE(str) *val = arr;
  for(i32 i = 0; i < val->len; i++) {
    printf("%s\n", val->data[i]);
  }
}

Friend *make_friends() {
  Friend *f = make(Friend);
  f->count = 5;
  INIT_ARR(u64, 4, f->arr);
  for(i32 i = 0; i < f->arr.len; i++) {
    f->arr.data[i] = i;
  }

  return f;
}


int main() {
  Friend *f = make_friends();
  for(i32 i = 0; i < f->arr.len; i++) {
    printf("%ld\n", f->arr.data[i]);
  }

  DELETE_ARR(f->arr);
  dealloc(f);
  make_arr(names, str, 10);

  str b = "Bob";
  foreachp(n, names, {
      *n = b;
      });

  foreach(n, names, {
    printf("%s\n", n);
      });

  destroy_arr(names);

  return 0;
}
