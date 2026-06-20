#include "map.h"




int main() {

  Map *r = _mapCreateTest(sizeof(i32), sizeof(u32), ((void *)0), ((void *)0),
                          (MapOptional){.al = null, .pointer = true});


  i32 k = 123;
  u32 v = 333;

  _Map *m = (_Map *)r;
  u64 __i;
  if (m->key_pointer) {
    __i = m->hash_func((&(typeof(k)){k}), m->key_size) % 16;
    typeof(k) *tmp_key = (typeof(k) *)m->buckets[__i].keys;
    _Bool find = 0;
    for (i32 i = 0; i < m->buckets[__i].len; i++) {
      if (m->eql_func(&tmp_key[i], &k, m->key_size)) {
        ((typeof(v) *)m->buckets[__i].vals)[m->buckets[__i].len] = v;
        find = 1;
      }
    }
    if (!find) {
      ((typeof(k) *)m->buckets[__i].keys)[m->buckets[__i].len] = k;
      ((typeof(v) *)m->buckets[__i].vals)[m->buckets[__i].len] = v;
    }
  } else {
    __i = m->hash_func(&(typeof(k)){k}, m->key_size) % 16;
    typeof(k) *tmp_key = (typeof(k) *)m->buckets[__i].keys;
    _Bool find = 0;
    for (i32 i = 0; i < m->buckets[__i].len; i++) {
      if (tmp_key[i] == k) {
        ((typeof(v) *)m->buckets[__i].vals)[m->buckets[__i].len] = v;
        find = 1;
      }
    }
    if (!find) {
      ((typeof(k) *)m->buckets[__i].keys)[m->buckets[__i].len] = k;
      ((typeof(v) *)m->buckets[__i].vals)[m->buckets[__i].len] = v;
    }
  }
  __mapGrowBucketLen(m, __i);

  return 0;
}
