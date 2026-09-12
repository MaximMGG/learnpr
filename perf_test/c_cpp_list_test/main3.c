#include <cstdext/core.h>
#include <stdio.h>


#define DEF_CAP 32

typedef struct __attribute__((__aligned__(8))){
  u64 cap;
  u64 len;
  u64 data_size;
} Tmp_Info;

#define TMP_DATA(arr) (((i8 *)arr) + sizeof(Tmp_Info))
#define TMP_RAW(arr) (Tmp_Info *)(((i8 *)arr) - sizeof(Tmp_Info))
#define TMP_LEN(arr) ((Tmp_Info *)(((i8 *)arr) - sizeof(Tmp_Info)))->len


ptr _tmpCreate(u64 data_size) {
  u64 size = data_size * DEF_CAP + sizeof(Tmp_Info);
  size = size % sizeof(Tmp_Info) > 0 ? (size / sizeof(Tmp_Info) + 1) * sizeof(Tmp_Info) : size;
  i8 *t = malloc(size);
  Tmp_Info *tmp = (Tmp_Info *)t;
  tmp->cap = DEF_CAP;
  tmp->len = 0;
  tmp->data_size = data_size;
  return t + sizeof(Tmp_Info);
}

inline ptr _tmpIncreaseLen(ptr arr) {
  i8 *t = ((i8 *)arr) - sizeof(Tmp_Info);
  Tmp_Info *tmp = (Tmp_Info *)t;
  if (tmp->len == tmp->cap) {
    tmp->cap <<= 1;
    u64 new_size = tmp->cap * tmp->data_size + sizeof(Tmp_Info);
    new_size = (new_size % 16) > 0 ? (((new_size / 16) + 1) * 16) : new_size;
    Tmp_Info *new = realloc(t, new_size);
    new->len++;
    return cast(ptr, TMP_DATA(new));
  }

  tmp->len++;
  return t + sizeof(Tmp_Info);
}

void tmpDestroy(ptr arr) {
  i8 *t = ((i8 *)arr) - sizeof(Tmp_Info);
  DEALLOC(t);
}


#define tmpAppend(arr, el) arr = _tmpIncreaseLen(arr); arr[TMP_LEN(arr)] = i
#define tmpCreate(type) (type *)_tmpCreate(sizeof(type))


#define COUNT 2000000000

i32 main() {

  i32 *arr = tmpCreate(i32);

  for(i32 i = 0; i < COUNT; i++) {
    tmpAppend(arr, i);
  }

  printf("Len of arr: %ld\n", TMP_LEN(arr));

  tmpDestroy(arr);

  return 0;
}
