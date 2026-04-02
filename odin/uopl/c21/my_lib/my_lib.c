#include <stdio.h>

typedef struct TestStruct {
  int num;
  float flt_num;
} TestStruct;

typedef void (*Callback)(TestStruct);

Callback callback = NULL;

void set_callback(Callback c) {
  printf("Setting callback\n");
  callback = c;
}

void do_stuff(TestStruct ts) {
  printf("Doing strff\n");
  ts.num += 1;
  ts.flt_num -= 1;

  fflush(stdout);
  if (callback != NULL) {
    callback(ts);    
  }  
}
