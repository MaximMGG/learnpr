#include <cstdext/core.h>
#include <cstdext/core.h>
#include <pthread.h>
#include <stdio.h>
#include <stdatomic.h>

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
  u32 len;
  atomic_bool *job_done;
} TPool;

typedef struct {
  pthread_t t;
  void *(*do_job)(void *);
  void *arg;
  atomic_bool job_done;
} TPool_Args;

u32 get_worker(TPool *t) {
  u32 worker_i = 0;
  while (true) {
    if (worker_i == t->len) {
      worker_i = 0;
    }
    if (atomic_load(&t->job_done[worker_i])) {
      return worker_i;
    } else {
      worker_i++;
    }
  }
}

pthread_mutex_t init_mutex;

void *generic_do_job(void *arg) {
  pthread_mutex_lock(&init_mutex);
  TPool_Args *a = (TPool_Args *)arg;
  atomic_store(&a->job_done, false);
  pthread_mutex_unlock(&init_mutex);
  a->do_job(a->arg);
  atomic_store(&a->job_done, true);
  return null;
}

TPool *threadPoolInit(u32 n_threads) {
  TPool *p = MAKE(heap_allocator, TPool);
  p->p_arr = MAKE_MANY(heap_allocator, pthread_t, n_threads);
  p->job_done = MAKE_MANY(heap_allocator, atomic_bool, n_threads);
  p->len = n_threads;
  pthread_mutex_init(&init_mutex, null);
  return p;
}

void threadPoolDestroy(TPool *p) {
  for(u32 i = 0; i < p->len; i++) {
    pthread_join(p->p_arr[i], null);
  }
  DEALLOC(heap_allocator, p->job_done);
  DEALLOC(heap_allocator, p->p_arr);
  DEALLOC(heap_allocator, p);
  pthread_mutex_destroy(&init_mutex);
}

void thread_pool_do_job(TPool *t, void *(*some_job)(void *), void *arg) {
  u32 worker_id = get_worker(t);
  TPool_Args a = {0};
  a.do_job = some_job;
  a.t = t->p_arr[worker_id];
  a.arg = arg;
  a.job_done = t->job_done[worker_id];
  pthread_create(&t->p_arr[worker_id], null, generic_do_job, &a);
}


int main() {
  TPool *p = threadPoolInit(4);



  threadPoolDestroy(p);  
  return 0;
}
