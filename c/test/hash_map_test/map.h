#include <cstdext/core.h>
#include <string.h>

#define DEFAULT_AMOUNT_OF_BUCKETS 16
#define DEFAULT_BUCKET_SIZE 16

typedef struct {
  u32 len;
} Map;

typedef struct {
  byte *keys;
  byte *vals;
  u32 len;
  u32 cap;
} Bucket;



typedef struct {
  u32 len;
  u32 key_size;
  u32 val_size;

  Bucket buckets[DEFAULT_AMOUNT_OF_BUCKETS];
  u64 (*hash_func)(ptr, u32);
  i32 (*eql_func)(ptr, ptr, u32);
  bool key_pointer;
  Allocator *al;
} _Map;

typedef struct {
  ptr key;
  ptr val;
  bool ok;

  _Map *m;
} Iter;

typedef struct {
  ptr key;
  ptr val;
} KV;

typedef struct {
  Allocator *al;
  bool pointer;
} MapOptional;


i32 __mapStdStrCmp(str a, str b, u32 __empty);

#define MAP_STD_STR_EQL_FUNC i32 __mapStdStrCmp

Map *_mapCreate(u32 key_size, u32 val_size, u64 (*hash_func)(ptr, u32), i32(*eql_func(ptr, ptr, u32)), ...);

Map *_mapCreateTest(u32 key_size, u32 val_size, u64 (*hash_func)(ptr, u32), i32(*eql_func(ptr, ptr, u32)), MapOptional op);

void __mapGrowBucketLen(_Map *m, u32 i);

#define mapCreate(key, val, hash, eql, args...) _mapCreate(sizeof(key), sizeof(val), hash, eql, ## args, null)

#define mapCreateTest(key, val, hash, eql, options) _mapCreateTest(sizeof(key), sizeof(val), hash, eql, (MapOptional) ##options)


#define getIndex(m, ind) u32 index = m->buckets[ind].len;

#define mapInsert(_m, key, val)                                                \
  _Map *m = (_Map *)_m;                                                        \
  u64 __i;                                                                    \
  if (m->key_pointer) {                                                        \
    __i = m->hash_func(*(&(typeof(key)){key}), m->key_size) % DEFAULT_AMOUNT_OF_BUCKETS;        \
    typeof(key) *tmp_key = (typeof(key *))m->buckets[__i].keys;                               \
    bool find = false;                                                         \
    for(i32 i = 0; i < m->buckets[__i].len; i++) {                             \
      if (m->eql_func(tmp_key[i], key, m->key_size)) {                        \
        ((typeof(val) *)m->buckets[__i].vals)[m->buckets[__i].len] = val;     \
        find = true;                                                           \
      }                                                                        \
    }                                                                          \
    if (!find) {                                                               \
      ((typeof(key) *)m->buckets[__i].keys)[m->buckets[__i].len] = key;       \
      ((typeof(val) *)m->buckets[__i].vals)[m->buckets[__i].len] = val;       \
    }                                                                          \
  } else {                                                                     \
    __i = m->hash_func(&(typeof(key)){key}, m->key_size) % DEFAULT_AMOUNT_OF_BUCKETS;        \
    typeof(key) *tmp_key = (typeof(key *))m->buckets[__i].keys;                          \
    bool find = false;                                                         \
    for(i32 i = 0; i < m->buckets[__i].len; i++) {                             \
      if (tmp_key[i] == key) {                                                     \
        ((typeof(val) *)m->buckets[__i].vals)[m->buckets[__i].len] = val;     \
        find = true;                                                           \
      }                                                                        \
    }                                                                          \
    if (!find) {                                                               \
      ((typeof(key) *)m->buckets[__i].keys)[m->buckets[__i].len] = key;       \
      ((typeof(val) *)m->buckets[__i].vals)[m->buckets[__i].len] = val;       \
    }                                                                          \
  }                                                                            \
  __mapGrowBucketLen(m, __i)

void mapDetsroy(Map *m);
KV mapGet(Map *m, ptr key);
void _mapInsert(Map *m, ptr key, ptr val);
