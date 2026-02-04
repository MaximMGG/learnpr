#include <cstdext/core.h>
#include <cstdext/core.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdatomic.h>
#include <unistd.h>
#include <strings.h>

_Atomic u64 total_sum = 0;

void *do_joib(void *p) {
  u32 sum = 0;
  for (i32 i = 0; i < 100000; i++) {
    sum += 2 * i - 1 + 4;
  }
  printf("%d\n", sum);
  return null;
}

typedef struct {
  pthread_t *p_arr;
  pthread_mutex_t *m_arr;
  u32 len;
  bool *was_init;
} TPool;

typedef struct {
  pthread_t *t;
  pthread_mutex_t *m;
  void *(*do_job)(void *);
  void *arg;
} TPool_Args;

u32 get_worker(TPool *t) {
  u32 worker_i = 0;
  while (true) {
    if (pthread_mutex_trylock(&t->m_arr[worker_i]) != 0) {
      worker_i++;
    } else {
      pthread_mutex_unlock(&t->m_arr[worker_i]);
      return worker_i;
    }
    if (worker_i == t->len) {
      worker_i = 0;
    }
  }
}

pthread_mutex_t init_mutex;

void *generic_do_job(void *arg) {
  pthread_mutex_lock(&init_mutex);
  TPool_Args *a = (TPool_Args *)arg;
  //pthread_mutex_lock(a->m);
  pthread_mutex_unlock(&init_mutex);
  a->do_job(a->arg);
  pthread_mutex_unlock(a->m);
  DEALLOC(heap_allocator, a);
  
  return null;
}

TPool *threadPoolInit(u32 n_threads) {
  TPool *p = MAKE(heap_allocator, TPool);
  p->p_arr = MAKE_MANY(heap_allocator, pthread_t, n_threads);
  p->m_arr = MAKE_MANY(heap_allocator, pthread_mutex_t, n_threads);
  p->was_init = MAKE_MANY(heap_allocator, bool, n_threads);
  for(u32 i = 0; i < n_threads; i++) {
    p->p_arr[i] = PTHREAD_CREATE_JOINABLE;
    pthread_mutex_init(&p->m_arr[i], null);
  }
  p->len = n_threads;
  pthread_mutex_init(&init_mutex, null);
  return p;
}

void threadPoolDestroy(TPool *p) {
  for(u32 i = 0; i < p->len; i++) {
    if (p->was_init[i]) {
      printf("Thread %d was init\n", i);
      pthread_join(p->p_arr[i], null);      
    }
  }
  for(u32 i = 0; i < p->len; i++) {
    pthread_mutex_destroy(&p->m_arr[i]);
  }  
  DEALLOC(heap_allocator, p->p_arr);
  DEALLOC(heap_allocator, p->m_arr);
  DEALLOC(heap_allocator, p->was_init);
  DEALLOC(heap_allocator, p);
  pthread_mutex_destroy(&init_mutex);
}

void thread_pool_do_job(TPool *t, void *(*some_job)(void *), void *arg) {
  u32 worker_id = get_worker(t);
  TPool_Args *a = MAKE(heap_allocator, TPool_Args);
  a->do_job = some_job;
  a->t = &t->p_arr[worker_id];
  a->arg = arg;
  a->m = &t->m_arr[worker_id];
  t->was_init[worker_id] = true;
  printf("Workder %d in process\n", worker_id);
  pthread_mutex_lock(a->m);
  pthread_create(&t->p_arr[worker_id], null, generic_do_job, a);
}

#define COUNT 50000000

void *test_1(void *a) {
  u64 local_sum = 0;
  for(i32 i = 0; i < COUNT; i++) {
    local_sum++;
    //    printf("Test_1 %d\n", i);
  }
  total_sum += local_sum;
  return null;
}

void *test_2(void *a) {
  u64 local_sum = 0;
  for(i32 i = 0; i < COUNT; i++) {
    local_sum++;
    //    printf("Test_1 %d\n", i);
  }
  total_sum += local_sum;
  return null;
}

void *test_3(void *a) {
  u64 local_sum = 0;
  for(i32 i = 0; i < COUNT; i++) {
    local_sum++;
    //    printf("Test_1 %d\n", i);
  }
  total_sum += local_sum;
  return null;
}

void *test_4(void *a) {
  u64 local_sum = 0;
  for(i32 i = 0; i < COUNT; i++) {
    local_sum++;
    //    printf("Test_1 %d\n", i);
  }
  total_sum += local_sum;
  return null;
}

void *test_5(void *a) {
  u64 local_sum = 0;
  for(i32 i = 0; i < COUNT; i++) {
    local_sum++;
    //    printf("Test_1 %d\n", i);
  }
  total_sum += local_sum;
  return null;
}

void *test_6(void *a) {
  u64 local_sum = 0;
  for(i32 i = 0; i < COUNT; i++) {
    local_sum++;
    //    printf("Test_1 %d\n", i);
  }
  total_sum += local_sum;
  return null;
}

int main() {
  setbuf(stdout, null);  
  TPool *p = threadPoolInit(6);
  thread_pool_do_job(p, test_1, null);
  thread_pool_do_job(p, test_2, null);
  thread_pool_do_job(p, test_3, null);
  thread_pool_do_job(p, test_4, null);
  thread_pool_do_job(p, test_5, null);
  thread_pool_do_job(p, test_6, null);

  threadPoolDestroy(p);
  printf("Total sum %lu\n", total_sum);
  return 0;
}
